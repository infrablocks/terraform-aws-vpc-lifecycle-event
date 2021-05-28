Terraform AWS VPC Lifecycle Event
=================================

[![CircleCI](https://circleci.com/gh/infrablocks/terraform-aws-vpc-lifecycle-event.svg?style=svg)](https://circleci.com/gh/infrablocks/terraform-aws-vpc-lifecycle-event)

A Terraform module for notifying of VPC lifecycle changes in AWS.

This module is designed to be used in conjunction with 
`infrablocks/base-networking/aws` and `infrablocks/infrastructure-events/aws`.

The network consists of:
* A notification (in the form of an S3 object) in an S3 bucket on VPC creation
* A notification (in the form of removal of the S3 object) in an S3 bucket on
  VPC deletion

Usage
-----

To use the module, include something like the following in your terraform configuration:

```hcl-terraform
module "vpc_lifecycle_event" {
  source  = "infrablocks/vpc-lifecycle-event/aws"
  version = "0.0.1"
}
```

See the 
[Terraform registry entry](https://registry.terraform.io/modules/infrablocks/vpc-lifecycle-event/aws/latest) 
for more details.

### Inputs

| Name                             | Description                                                               | Default | Required                                    |
|----------------------------------|---------------------------------------------------------------------------|:-------:|:-------------------------------------------:|

### Outputs

| Name                         | Description                                          |
|------------------------------|------------------------------------------------------|


### Required Permissions

* ec2:DescribeVpcs
* ec2:DescribeAddresses
* ec2:DescribeVpcAttribute
* ec2:DescribeVpcClassicLink
* ec2:DescribeVpcClassicLinkDnsSupport
* ec2:DescribeRouteTables
* ec2:DescribeSecurityGroups
* ec2:DescribeNetworkAcls
* ec2:DescribeSubnets 
* ec2:DescribeInternetGateways
* ec2:DescribeNatGateways
* ec2:ModifyVpcAttribute
* ec2:AllocateAddress
* ec2:ReleaseAddress
* ec2:AssociateRouteTable
* ec2:DisassociateRouteTable
* ec2:AttachInternetGateway
* ec2:DetachInternetGateway
* ec2:DeleteInternetGateway
* ec2:CreateRoute
* ec2:CreateNatGateway
* ec2:CreateVpc
* ec2:CreateTags
* ec2:CreateSubnet
* ec2:CreateRouteTable
* ec2:CreateInternetGateway
* ec2:DeleteRoute
* ec2:DeleteRouteTable
* ec2:DeleteSubnet
* ec2:DeleteNatGateway
* ec2:DeleteVpc
* s3:ListBucket
* s3:GetObject
* s3:GetObjectTagging
* s3:DeleteObject
* route53:AssociateVPCWithHostedZone
* route53:DisassociateVPCFromHostedZone
* route53:GetChange
* route53:GetHostedZone

### Compatibility

This module is compatible with Terraform versions greater than or equal to 
Terraform 0.14.

Development
-----------

### Machine Requirements

In order for the build to run correctly, a few tools will need to be installed on your
development machine:

* Ruby (2.3.1)
* Bundler
* git
* git-crypt
* gnupg
* direnv

#### Mac OS X Setup

Installing the required tools is best managed by [homebrew](http://brew.sh).

To install homebrew:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Then, to install the required tools:

```
# ruby
brew install rbenv
brew install ruby-build
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
eval "$(rbenv init -)"
rbenv install 2.3.1
rbenv rehash
rbenv local 2.3.1
gem install bundler

# git, git-crypt, gnupg
brew install git
brew install git-crypt
brew install gnupg

# direnv
brew install direnv
echo "$(direnv hook bash)" >> ~/.bash_profile
echo "$(direnv hook zsh)" >> ~/.zshrc
eval "$(direnv hook $SHELL)"

direnv allow <repository-directory>
```

### Running the build

To provision module infrastructure, run tests and then destroy that infrastructure,
execute:

```bash
./go
```

To provision the module prerequisites:

```bash
./go deployment:prerequisites:provision[<deployment_identifier>]
```

To provision the module contents:

```bash
./go deployment:harness:provision[<deployment_identifier>]
```

To destroy the module contents:

```bash
./go deployment:harness:destroy[<deployment_identifier>]
```

To destroy the module prerequisites:

```bash
./go deployment:prerequisites:destroy[<deployment_identifier>]
```


### Common Tasks

#### Generating an SSH key pair

To generate an SSH key pair:

```
ssh-keygen -t rsa -b 4096 -C integration-test@example.com -N '' -f config/secrets/keys/bastion/ssh
```

#### Managing CircleCI keys

To encrypt a GPG key for use by CircleCI:

```bash
openssl aes-256-cbc \
  -e \
  -md sha1 \
  -in ./config/secrets/ci/gpg.private \
  -out ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

To check decryption is working correctly:

```bash
openssl aes-256-cbc \
  -d \
  -md sha1 \
  -in ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at 
https://github.com/infrablocks/terraform-aws-vpc-lifecycle-event. 
This project is intended to be a safe, welcoming space for collaboration, and 
contributors are expected to adhere to the 
[Contributor Covenant](http://contributor-covenant.org) code of conduct.


License
-------

The library is available as open source under the terms of the 
[MIT License](http://opensource.org/licenses/MIT).
