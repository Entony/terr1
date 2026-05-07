pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Что делаем?')
    }

    environment {
        YC_CLOUD_ID  = 'b1gv77uktf2hqo7ed2mc'
        YC_FOLDER_ID = 'b1gkg6dahs4fcqkhecdl'
        YC_KEY_FILE  = credentials('yc-auth-key')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([
                    string(credentialsId: 'YC_ACCESS_KEY', variable: 'ACCESS_KEY'),
                    string(credentialsId: 'YC_SECRET_KEY', variable: 'SECRET_KEY')
        ]) {
                    dir('src') { 
                        sh """
                            terraform init \
                             -backend-config="access_key=${ACCESS_KEY}" \
                             -backend-config="secret_key=${SECRET_KEY}"
                        """
            }
        }
    }
}

        stage('Terraform Action') {
            steps {
                script {
                    dir('src') {
                        ithEnv([
                            "YC_SERVICE_ACCOUNT_KEY_FILE=${YC_KEY_FILE}",
                            "YC_CLOUD_ID=${YC_CLOUD_ID}",
                            "YC_FOLDER_ID=${YC_FOLDER_ID}"
                    ]) {
                            if (params.ACTION == 'apply') {
                                sh 'terraform apply -auto-approve'
                            } else {
                                sh 'terraform destroy -auto-approve'
                        }
                    }
                    }
                }
            }
        }
    }
}