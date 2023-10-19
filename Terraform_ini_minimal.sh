#!bin/bash
#creating function for gcloud
gcloudfunction() {
echo "Building foundation for gcloud terraform"
mkdir -p $varcloudpath$varcloudprjectname
cd $varcloudpath$varcloudprjectname
touch main.tf variables.tf
mkdir -p modules/instances modules/storage
cd modules/instances
touch instances.tf outputs.tf variables.tf
cd ../storage
touch storage.tf outputs.tf variables.tf

#making main.tf
echo "terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}
#Please add in the below information
provider "google" {
  project = "PROJECT"
  region  = "REGION"
  zone    = "ZONE"
}" >> $varcloudpath$varcloudprjectname/main.tf

#running terraform init
echo "running gcloud terraform init"
terraform init
}

#creating function for AWS
awsfunction () {
echo "Building foundation for AWS terraform"
mkdir -p $varcloudpath$varcloudprjectname
cd $varcloudpath$varcloudprjectname
touch main.tf variables.tf
mkdir -p modules/instances modules/storage
cd modules/instances
touch instances.tf outputs.tf variables.tf
cd ../storage
touch storage.tf outputs.tf variables.tf

echo "terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ""~> 5.0""
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "REGION"
  access_key = "awsaccesskey"
  secret_key = "awssecretkey"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "awscidrblock"
}

provider "aws" {
  assume_role {
    role_arn     = "awsrolearn"
    session_name = "awssessionname"
    external_id  = "awsexternalid"
  }
}" >> $varcloudpath$varcloudprjectname/main.tf

#running terraform init
echo "running AWS terraform init"
terraform init
}


#creating function for azure
azurefunction () {
echo "Building foundation for azure terraform"
mkdir -p $varcloudpath$varcloudprjectname
cd $varcloudpath$varcloudprjectname
touch main.tf variables.tf
mkdir -p modules/instances modules/storage
cd modules/instances
touch instances.tf outputs.tf variables.tf
cd ../storage
touch storage.tf outputs.tf variables.tf

echo "# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "azureresourcename"
  location = "azureresourcelocation"
}

# Create a virtual network within the resource group
#Please edit the below
resource "azurerm_virtual_network" "example" {
  name                = "azurevnetname"
  resource_group_name = "azureresourcegname"
  location            = "azureresourceglocation"
  address_space       = ["IP"]
}" >> $varcloudpath$varcloudprjectname/main.tf

#running terraform init
echo "running azure terraform init"
terraform init
}

echo "--------------------------------"
echo "Welcome to the Terraform builder"
echo "--------------------------------"
echo "What cloud provider are you using? (only: google, aws, azure)"
read varcloudname
echo "What path would you like to create your terraform directories in? (example: /usr/home/terraform/)"
read varcloudpath
echo "What would you like to call your terrform project?"
read varcloudprjectname

if [[ $varcloudname == "google" ]]; then
    gcloudfunction
elif [[ $varcloudname == "aws" ]]; then
    awsfunction
elif [[ $varcloudname == "azure" ]]; then
    azurefunction
else
    echo "I don't have that cloud yet"
fi