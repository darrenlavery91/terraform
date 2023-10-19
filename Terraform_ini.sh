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

provider "google" {
  project = "$vargcloudregion"
  region  = "$vargcloudproject_id"
  zone    = "$vargcloudzone"
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
  region = "$varawsregion"
  access_key = "$varawsaccesskey"
  secret_key = "$varawssecretkey"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "$varawscidrblock"
}

provider "aws" {
  assume_role {
    role_arn     = "$varawsrolearn"
    session_name = "$varawssessionname"
    external_id  = "$varawsexternalid"
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
  name     = "$varazureresourcename"
  location = "$varazureresourcelocation"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "$varazurevnetname"
  resource_group_name = "$varazureresourcegname"
  location            = "$varazureresourceglocation"
  address_space       = ["$varazureaddressspace"]
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
    echo "-------------------------------------------"
    echo "**** Please only run in gcloud console ****"
    echo "-------------------------------------------"
    echo "What is your gcloud REGION?"
    read vargcloudregion
    echo "What is your gcloud ZONE?"
    read vargcloudzone
    echo "What is your gcloud PROJECT_ID?"
    read vargcloudproject_id
    gcloudfunction
elif [[ $varcloudname == "aws" ]]; then
    echo "What is your AWS REGION?"
    read varawsregion
    echo "What is your AWS VPC?"
    read varawsvpc
    echo "What is your AWS cidr_block?"
    read varawscidrblock
    echo "What is your access_key? /token"
    read varawsaccesskey
    echo "What is your secret_key /token?"
    read varawssecretkey
    echo "What are your IAM Role details arn? (example: arn:aws:iam::123456789012:role/ROLE_NAME)"
    read varawsrolearn
    echo "What is your session name?"
    read varawssessionname
    echo "What is your external id?"
    read varawsexternalid
    awsfunction
elif [[ $varcloudname == "azure" ]]; then
    echo "We will make a resource group, what is your Azure resource group name?"
    read varazureresourcename
    echo "What is your Azure resource location?"
    read varazureresourcelocation
    echo "We will create a Virtual network within the resource group, what is your Virtual network (vnet) name?"
    read varazurevnetname
    echo "What is your resource group name? (example: azurerm_resource_group.example.name)"
    read varazureresourcegname
    echo "What is your resource group location? (example: azurerm_resource_group.example.location)"
    read varazureresourceglocation
    echo "What is the IP address space for this resource group location? (example: 10.0.0.0/16)"
    read varazureaddressspace
    azurefunction
else
    echo "I don't have that cloud yet"
fi