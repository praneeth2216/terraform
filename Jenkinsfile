pipeline {
    agent any
    parameters {
    booleanParam(name: 'APPLY', defaultValue: false, description: 'Set true to actually run terraform apply')
    }
    environment {
        TF_VAR_region = "us-east-2"   // optional, if you want to pass vars
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out repository..."
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                echo "Initializing Terraform..."
                sh '''
                terraform init \
                  -backend-config="bucket=karupothula1" \
                  -backend-config="key=state/terraform.tfstate" \
                  -backend-config="region=us-east-2" \
                  -backend-config="dynamodb_table=terraform-locks" \
                  -backend-config="encrypt=true"
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                echo "Validating Terraform code..."
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo "Running Terraform Plan..."
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {            
            steps {
                echo "Applying Terraform changes..."
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        success {
            echo "Terraform pipeline executed successfully 🎉"
        }
        failure {
            echo "Terraform pipeline failed ❌"
        }
    }
}
