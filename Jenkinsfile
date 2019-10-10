pipeline {
    agent any
    
    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/pyrogow/spring-petclinic.git"
                echo "Succesfully cloned"
            }
        }
        stage ('unit test and build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Deploy') {
           steps {
                rtUpload (
                    serverId: 'EpamArtifactory',
                    spec: '''{
                        "files": [
                                    {
                                        "pattern": "*SNAPSHOT.jar",
                                        "target": "test/com/epamlabs/pyrohov/Job_F/"
                                    }
                        ]
                    }'''
                )
           }
       }
    }
}


