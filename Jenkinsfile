pipeline {
agent any
  environment {
    USER = credentials('VAULT_USER')
    USER_PASS = credentials('vault_user_pass')
    VAULT_ADDR = "http://llgames-vault.westeurope.azurecontainer.io:8200"
    MASTER_URL = "jenkins.limitlessgames.cloud:8080"
  }
  stages {
    stage ('Create VM'){
      steps {
        script {
        sh """
          ./get_values.sh ${VAULT_USER} ${VAULT_PASS} ${VAULT_URL} ${MASTER_URL}
          """
        }
      }
    }
    
  }
}
