# AWS Terraform Sample

## Abstract
As of now, the code implements a Terraform sample code to build AWS EC2 instance in different environment based on branch strategy. 

## Directory structure
- **DIT** store terraform configure and state for DIT environment
- **SIT** store terraform configure and state for SIT environment
- **UAT** store terraform configure and state for UAT environment
- **PROD** store terraform configure and state for PROD environment

## Pipeline Stages
### Recognize
* Job checkEnv can figure out branch, and determine environment [DIT, SIT, UAT, PROD] to deploy
### Validate
* Job validate can validate terraform configure
### Build
* Job plan can generate a plan for terraform apply
### Test
Not implemented
### Deploy
* Job apply can create/update/destroy infrastructures with the plan 
### State
* Job commit can commit terraform state file to version control system to track infrastructures' status

## Branch Policy
_**Branches develop, release/* and master are protected branches**_
### Develop
* Change event in branch develop will trigger the pipeline and make infrastructures change in SIT
### Release/*
* Change event in any branch of release/* will trigger the pipeline and make infrastructures change in UAT
### Master
* Change event in branch master will trigger the pipeline. 
* To make infrastructures change in PROD, user need manually trigger the **apply** job in **deploy** stage and provide value of variable DEPLOY_SECRET.
* As a strategy of approval, value of **DEPLOY_SECRET** should match **DEPLOY_PRODUCTION_SECRET** to proceed **apply** job.
### Other branches
* Event in those branches created by developer can trigger build on DIT environment.

## Environment variables
- **DESTROY**: With value of "-destroy", infrastructures can be destroyed.
- **DEPLOY_PRODUCTION_SECRET**: Set by Approver and provide deployer to manually trigger deploy on PROD