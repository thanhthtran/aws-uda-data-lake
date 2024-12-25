## create security groups for public subnet:

resource "aws_security_group" "bastion_host" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.project}-bastion-host-sg"
  ## http
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_all]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_all]
    description = "Allow incoming SSH connections (Linux)"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_all]
    description = "Allow all outgoing traffic"
  }

  tags = {
    Name = "${var.project}-bastion-host-sg"
  }
}

resource "aws_security_group" "database" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.project}-database-sg"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host.id]
    description     = "Allow incoming connections from the bastion host sg"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_all]
    description = "Allow all outgoing traffic"
  }

  tags = {
    Name = "${var.project}-database-sg"
  }
}


