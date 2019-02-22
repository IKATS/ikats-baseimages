pipeline {
    options { 
        buildDiscarder(logRotator(numToKeepStr: '4', artifactNumToKeepStr: '5'))
        disableConcurrentBuilds() 
    }
    agent any
    stages {
        stage('Fetch SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build and push images') {
            
            parallel {
                stage ('ikats-spark') {
                    agent { node { label 'docker' } }
                    steps {
                        dir ('ikats-spark') {
                            script {
                                dockerBuild 'hub.ops.ikats.org/spark'
                            }
                        }
                    }
                }

                stage ('openTDSB') {
                    agent { node { label 'docker' } }
                    steps {
                        dir ('opentsdb') {
                            script {
                                dockerBuild 'hub.ops.ikats.org/opentsdb'
                            }
                        }
                    }
                }
            }
        }
    }
}
