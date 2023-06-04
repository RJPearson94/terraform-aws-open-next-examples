# Open Next Terraform Examples

This repo contains example Terraform/ Terragrunt configurations to deploy a single and multi-zone website to AWS using [Open Next](https://github.com/serverless-stack/open-next).

This utilises the following module to deploy the Next.js website to AWS

[Github Repo](https://github.com/RJPearson94/terraform-aws-open-next)
[Terraform Registry](https://registry.terraform.io/modules/RJPearson94/open-next/aws/latest)

See the module documentation for more information on the limitations, inputs, outputs, etc.

## Running the examples

To be able to run the examples, you will need to install the dependencies and build the websites using open-next. 

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
