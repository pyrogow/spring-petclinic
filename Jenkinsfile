// pipeline {
//     agent any
    
//     stages {
//         stage ('Clone') {
//             steps {
//                 git branch: 'master', url: "https://github.com/pyrogow/spring-petclinic.git"
//                 echo "Succesfully cloned"
//             }
//         }
//         stage ('unit test and build') {
//             steps {
//                 sh 'mvn clean package'
//             }
//         }
//         stage('Deploy') {
//            steps {
//                 rtUpload (
//                     serverId: 'EpamArtifactory',
//                     spec: '''{
//                         "files": [
//                                     {
//                                         "pattern": "*SNAPSHOT.jar",
//                                         "target": "test/com/epamlabs/pyrohov/Job_F/"
//                                     }
//                         ]
//                     }'''
//                 )
//            }
//        }
//     }
// }


pipeline {
  agent none
  stages {
    stage('Maven Install') {
      agent {
        docker {
          image 'maven:3.5.2'
        }
      }
      steps {
        sh 'mvn clean install'
      }
    }
    stage('Docker Build and push image to ECS') {
      agent any
      steps {
        sh 'docker build -t pyrogow/app1:latest .'
        sh 'aws ecr get-login --no-include-email --region=eu-central-1 > login.sh'
        sh 'chmod +x login.sh'
        sh 'sh ./login.sh'
        sh 'docker tag pyrogow/app1:latest 591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main'
        sh 'docker push 591425342341.dkr.ecr.eu-central-1.amazonaws.com/app-main'
      }
    }
  }
}