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
        
                    sh 'tag_value=$(git describe --tags | awk -F - \'{print $1}\')'
                    sh 'Release=$(curl -XPOST -H "Authorization: token $GITHUB_TOKEN" -d \'{"tag_name":"$tag_value","target_commitish":"main","name":"Release Initial","body":"First release","draft":false,"prerelease":false}\' https://api.github.com/repos/nityapisharodi/caesar-cipher/releases |jq -r '.id')'
                    sh 'curl -X POST -H "Authorization:(write token github)" --header "Content-Type: application/octet-stream" --data-binary "build/libs/caesar-cipher.jar" https://api.github.com/repos/nityapisharodi/caesar-cipher/releases/${Release}/assets?name=caesar-cipher.jar'

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
   
