pipeline {
  agent any
  stages {
    stage('Create Terraform Workspace and Polices') {
      steps {
        sh '''cd tfe_setup
terraform init
terraform apply -auto-approve -var organization=SentinelTesting'''
      }
    }
  }
}