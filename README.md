# Terraform Initialization Script

## Introduction

This Bash script is designed to assist in initializing Terraform projects for various cloud providers. It prompts you for information related to your cloud provider (Google Cloud, AWS, or Azure) and sets up the initial project structure and configuration files for Terraform.

## Prerequisites

Before using this script, you should have the following prerequisites in place:

- Terraform installed on your machine.
- Access to the cloud provider's console and API keys/credentials for the cloud services you plan to use.

## How to Use

1. Clone or download this script to your local machine.

2. Make the script executable using the following command:

   ```bash
   chmod +x terraform_ini.sh
   
3. Run the script with the following command:
./terraform_ini.sh


The script will prompt you for the following information:
Cloud provider (Google, AWS, or Azure).
Path for creating Terraform directories.
Terraform project name.
Provider-specific details (e.g., Google Cloud: region, zone, project ID, etc.).
Follow the prompts and provide the required information. The script will then create the initial project structure and configuration files for your chosen cloud provider.

After running the script, you can proceed with further configuration and development of your Terraform project as needed.

## Supported Cloud Providers
Google Cloud (gcloud)
Amazon Web Services (AWS)
Microsoft Azure (Azure)

## Notes
Ensure that you have the necessary permissions and credentials for your chosen cloud provider.
Verify and customize the default values, such as regions, zones, and project IDs, as needed in the script.
Disclaimer
This script provides a basic template for initializing Terraform projects but may require additional configuration and adjustments based on your specific project requirements.

Use at your own risk. Contributions are welome on structure layouts.

## License
This script is provided under an open-source license.

