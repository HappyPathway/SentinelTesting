pipeline {
  agent any
  stages {
    stage('Create Terraform Workspace and Polices') {
      steps {
        sh '''#!/bin/bash
source ~/vault.sh
cd tfe_setup
terraform init
terraform apply -auto-approve -var organization=SentinelTesting'''
      }
    }
    stage('Policy Pass') {
      steps {
        sh '''source ~/vault.sh
cd pass
terraform apply
'''
      }
    }
  }
}