# Open Next Terraform Examples

This repo contains example Terraform/ Terragrunt configurations to deploy a single and multi-zone website to AWS using [Open Next](https://github.com/serverless-stack/open-next).

This utilises the following module to deploy the Next.js website to AWS

[Github Repo](https://github.com/RJPearson94/terraform-aws-open-next)

[Terraform Registry](https://registry.terraform.io/modules/RJPearson94/open-next/aws/latest)

See the module documentation for more information on the limitations, inputs, outputs, etc.

## Building the examples

To be able to deploy the examples, you will need to install the dependencies and build the websites using open-next. 

**NOTE:** You will need node 18 or above installed to build the applications

For the multi-zone website please run the following commands

```shell
cd multi-zone/docs
yarn install
yarn build:open-next
...
cd ../home
yarn install
yarn build:open-next
```

For the single-zone website please run the following commands

```shell
cd single-zone
yarn install
yarn build:open-next
```

## Deploying the examples

**NOTE:** Deploying an example could cause you to start incurring charges on you AWS account

To deploy the examples to AWS, you will need the following

- An AWS Account
- [Terragrunt](https://terragrunt.gruntwork.io/) v0.45.14 or above
- [Terraform](https://terragrunt.gruntwork.io/) v1.4.0 or above

To configure the AWS providers see the [provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration). 

You will need to configure the AWS providers 4 times, this is due to some orgs using different account or roles for IAM, DNS, etc. The server function is a seperate provider to allow you backend resources to be deployed to a region i.e. eu-west-1 and deploy the server function to another region i.e. us-east-1 for lambda@edge.

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
```

Once the artifacts have been built they can be deployed using Terraform & Terragrunt. First, you need to download the providers and module, you can do this by running the following command:

```shell
terragrunt init
```

To see what changes will be made, you can run the following command:

```shell
terragrunt plan
```

To deploy the website, you can run the following command:

```shell
terragrunt apply
```

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
terragrunt destroy
```

When you see the following

```
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value:
```

type `yes` and hit the return/ enter key.

Then all the resources (which Terraform has state information for) should be removed.