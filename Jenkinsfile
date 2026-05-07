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
                dir('src') {
                    sh 'terraform init'
            } }
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