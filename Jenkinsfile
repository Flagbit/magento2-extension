pipeline {
  agent {
    label 'jenkins-master01'
  }

  environment {
    http_proxy          = 'http://webproxy.emarsys.at:3128'
    https_proxy         = 'http://webproxy.emarsys.at:3128'
    NPM_TOKEN           = credentials('npm_token')
    MAGENTO_REPO_KEY    = credentials('magento_repo_key')
    MAGENTO_REPO_SECRET = credentials('magento_repo_secret')
    MYSQL_HOST          = 'db'
    MYSQL_USER          = 'magento'
    MYSQL_PASSWORD      = 'magento'
    MAGENTO_URL         = 'http://magento-test.local'
  }

  triggers {
    pollSCM '* * * * *'
    cron('*/30 0,1,2,3,4,5,6,19,20,21,22,23 * * *')
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '50'))
    disableConcurrentBuilds()
    timestamps()
  }

  stages {
    stage('Run versions in parallel') {
      parallel {
        stage('Build and run tests on Magento 2.2.6') {
          steps {
            sh 'VERSION=2.2.6 sh dev/jenkins/run.sh'
          }
        }
        stage('Build and run tests on Magento 2.1.8') {
          steps {
            sh 'VERSION=2.1.8 sh dev/jenkins/run.sh'
          }
        }
      }
    }
  }
  post {
    always {
      sh 'VERSION=2.2.6 docker-compose -f ./dev/jenkins/docker-compose.yml down -v --rmi all'
      sh 'VERSION=2.1.8 docker-compose -f ./dev/jenkins/docker-compose.yml down -v --rmi all'
      sh 'docker container rm -f $(docker container ls -aq) || echo \'No leftover containers…\''
    }
  }
}
