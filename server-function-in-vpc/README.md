# Server function in VPC

This example shows how you can deploy a single next.js app to AWS using open next v3 with the server function within a VPC. VPC Endpoints are created to allow the server function to talk with S3, DynamoDB and SQS without requiring internet access

## Building the example

To be able to deploy the examples, you will need to install the dependencies and build the websites using open-next. 

**NOTE:** You will need node 20 or above installed to build the applications

Please run the following commands

```shell
pnpm install
pnpm run build:open-next
```

## Deploying the examples

**NOTE:** Deploying an example could cause you to start incurring charges on you AWS account

To deploy the examples to AWS, you will need the following

- An AWS Account
- [Terraform](https://terragrunt.gruntwork.io/) v1.4.0 or above

To configure the AWS providers see the [provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration). 

You will need to configure the AWS providers 5 times, this is due to some orgs using different account or roles for IAM, DNS, etc. The server function is a seperate provider to allow you backend resources to be deployed to a region i.e. eu-west-1 and deploy the server function to another region i.e. us-east-1 for lambda@edge.

An example setup can be seen below

```tf
provider "aws" {
  
}

provider "aws" {
  alias = "server_function"
}

provider "aws" {
  alias = "iam"
}

provider "aws" {
  alias = "dns"
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"
}
```

Once the artifacts have been built they can be deployed using Terraform. First, you need to download the providers and module, you can do this by running the following command:

```shell
terraform init
```

To see what changes will be made, you can run the following command:

```shell
terraform plan
```

You will need to supply values for the required variables.

To deploy the website, you can run the following command:

```shell
terraform apply
```

You will need to supply values for the required variables.

When you see the following

```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

type `yes` and hit the return/ enter key. 


## Destroying the example

Once you are finished with the resources you can remove all the provisioned resources by running the following command:

```shell
terraform destroy
```

You will need to supply values for the required variables.

When you see the following

```
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value:
```

type `yes` and hit the return/ enter key.

Then all the resources (which Terraform has state information for) should be removed.
