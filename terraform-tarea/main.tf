#Declarar proveedor de nube

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "aws-icesi-tarea"
}

#Recursos declaraciones de componentes

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "web"
  }
}

resource "aws_instance" "bd" {
  ami = "ami-00874d747dde814fa"
  instance_type = "t2.micro"
  
  tags = {
    Name = "bd"
  }
}

resource "aws_instance" "backend" {
  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  
  tags = {
    Name = "backend"
  }
}

#Consultas de Datos (Opcional)

#ciclo de vida terraform

# inicializar: terraform init

#verificar diseño: terraform plan

#aplicar el diseño: terraform apply

#destruir infraestructura: terraform destroy