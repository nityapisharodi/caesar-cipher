pipeline {
    agent any
    stages {
        stage ('Test') {
            steps {
                sh './gradlew test'
            }
        }
        stage ('Build') {
            steps {
                sh './gradlew build'
            }
        }
        stage ('Deploy/Show Output'){
            steps {
                echo 'Deploying/Outputing .....'
                sh 'java -jar build/libs/caesar-cipher.jar'
            }  
        }

        stage ('Release') {
            steps {

                withCredentials([string(credentialsId: 'my_github_token', variable: 'GITHUB_TOKEN')])
                {
        
                    sh 'tag=$(git describe --tags | awk -F - \'{print $1}\')'
                    sh 'Release=$(curl -XPOST -H "Authorization: token $GITHUB_TOKEN" -d "{\"tag_name\":\"$tag\",\"target_commitish\":\"main\",\"name\":\"Release Initial\",\"body\":\"First release\",\"draft\":false,\"prerelease\":false}" https://api.github.com/repos/nityapisharodi/caesar-cipher/releases)'

                }
            }
        }
                
    }
    post {
        always {
            archiveArtifacts artifacts: 'build/libs/caesar-cipher.jar', onlyIfSuccessful: true
        }
    }
        
   }
   
