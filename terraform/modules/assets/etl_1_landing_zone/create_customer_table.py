import sys
from datetime import datetime

from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from pyspark.conf import SparkConf
from pyspark.context import SparkContext
from pyspark.sql.functions import col, lit, to_date, current_timestamp
from pyspark.sql.types import StructType, StructField, StringType, TimestampType, IntegerType, DoubleType
# Initialize Glue context and Spark session
args = getResolvedOptions(
    sys.argv,
    [
        "JOB_NAME",
        "data_lake_bucket",
        "catalog_database",
        "ingest_date",
        "customer_source_path",
        "customer_table",
    ],
)

conf = SparkConf()
conf.set(
    "spark.sql.extensions",
    "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions",
)
conf.set(
    "spark.sql.catalog.glue_catalog", "org.apache.iceberg.spark.SparkCatalog"
)
conf.set(
    "spark.sql.catalog.glue_catalog.warehouse",
    f"s3://{args['data_lake_bucket']}/transform_zone",
)
conf.set(
    "spark.sql.catalog.glue_catalog.catalog-impl",
    "org.apache.iceberg.aws.glue.GlueCatalog",
)
conf.set(
    "spark.sql.catalog.glue_catalog.io-impl",
    "org.apache.iceberg.aws.s3.S3FileIO",
)

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)
data_lake_bucket = args["data_lake_bucket"]
catalog_database = args["catalog_database"]
customer_table_name = args["customer_table"]
logger = glueContext.get_logger()

# Define S3 paths
ingest_date_str = args["ingest_date"]
ingest_date = datetime.strptime(ingest_date_str, "%Y-%m-%d")
formatted_ingest_date = ingest_date.strftime("%Y_%m_%d")
s3_path_customer = f"{args['customer_source_path']}/ingest_on={formatted_ingest_date}"

# Define Schema
customer_schema = StructType(
    [
        StructField("serialnumber", StringType(), True),
        StructField("sharewithpublicasofdate", StringType(), True),
        StructField("birthday", StringType(), True),
        StructField("registrationdate", StringType(), True),
        StructField("sharewithresearchasofdate", StringType(), True),
        StructField("customername", StringType(), True),
        StructField("email", StringType(), True),
        StructField("lastupdatedate", StringType(), True),
        StructField("phone", StringType(), True),
        StructField("sharewithfriendsasofdate", StringType(), True),
    ]
)


def add_metadata(source_df):
    """Add ingest_ts and source metadata to the raw data located in a dataframe
    also add to the schema the new columns related to metadata.

    Args:
        source_df (DataFrame): Dataframe containing the source table data.

    Returns:
        DataFrame: updated Dataframe
    """
    source_df = source_df.withColumn("ingest_ts", current_timestamp())
    source_df = source_df.withColumn("source", lit("customer_json"))
    return source_df


def enforce_schema(source_df, source_schema):
    """Cast the columns of the source DataFrame to comply with the provided schema

    Args:
        source_df (DataFrame): Dataframe containing the source table data.
        source_schema (StructType): Schema associated to the source table

    Returns:
        DataFrame: Dataframe with the correct data types for each column.
    """
    source_schema_dict = {
        name: field.dataType for name, field in zip(source_schema.names, source_schema.fields)
    }
    for field_name, field_type in source_schema_dict.items():
        if isinstance(field_type, StringType):
           source_df = source_df.withColumn(field_name, col(field_name).cast("string"))
        elif isinstance(field_type, IntegerType):
            source_df = source_df.withColumn(field_name, col(field_name).cast("int"))
        elif isinstance(field_type, DoubleType):
            source_df = source_df.withColumn(field_name, col(field_name).cast("double"))
    return source_df


# Read JSON data from S3
source_df = spark.read.schema(customer_schema).json(s3_path_customer)

# Enforce schema
source_df = enforce_schema(source_df, customer_schema)
logger.info(f"enforced schema done for customer")

# Add metadata
target_df = add_metadata(source_df)
logger.info(f"add metadata done for customer")


# Write data into curated location and glue catalog
target_data_path = f"s3://{data_lake_bucket}/curated_zone/{customer_table_name}"

## Using normal pySpark glue
# target_data = DynamicFrame.fromDF(target_df, glueContext, "target_data")
# sink = glueContext.getSink(
#     connection_type="s3",
#     path=target_data_path,
#     enableUpdateCatalog=True,
#     updateBehavior="UPDATE_IN_DATABASE",
#     partitionKeys=["ingest_ts"],
#     compression="snappy",
# )
# sink.setFormat("parquet", useGlueParquetWriter=True)
# sink.setCatalogInfo(catalogDatabase=catalog_database, catalogTableName=customer_table_name)
# sink.writeFrame(target_data)

## Using spark sql
# Create table using Spark SQL
create_table_sql = f"""
    CREATE TABLE IF NOT EXISTS {catalog_database}.{customer_table_name}
    USING iceberg
    #USING PARQUET
    PARTITIONED BY (ingest_ts)
    LOCATION '{target_data_path}'
    #TBLPROPERTIES ('parquet.compression'='SNAPPY')
    AS SELECT * FROM customer_view
"""
spark.sql(create_table_sql)
logger.info(f"table created using spark sql for customer")


logger.info(f"write done for customer")
job.commit()