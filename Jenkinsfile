pipeline {
    agent any
    parameters {
        string(name: 'INTERNAL_REGISTRY_URL', defaultValue: 'https://hub.ops.ikats.org', description: 'IKATS Internal registry')
    }
    stages {
        stage('Fetch SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build and push images') {
            when {
                anyOf {
                    branch "develop/*"
                    branch "feature/*"
                    branch "bugfix/*"
                }
            }

            parallel {
                stage ('ikats-spark') {
                    agent { node { label 'docker' } }
                    steps {
                        dir ('ikats-spark') {
                            script {

                                // Replacing docker registry to private one
                                sh "sed -i 's/FROM ikats/FROM hub.ops.ikats.org/' Dockerfile"

                                module = 'spark'
                                moduleImage = docker.build(module, "--pull .")

                                // Prepare image tag
                                fullBranchName = "${env.BRANCH_NAME}"
                                branchName = fullBranchName.substring(fullBranchName.lastIndexOf("/") + 1)
                                shortCommit = "${GIT_COMMIT}".substring(0, 7)

                                // 'DOCKER_REGISTRY' stands for internal registry creds
                                docker.withRegistry("${params.INTERNAL_REGISTRY_URL}", 'DOCKER_REGISTRY') {
                                    /* Push the container to the custom Registry */
                                    moduleImage.push(branchName + "_" + shortCommit)
                                    moduleImage.push(branchName + "_latest")
                                    if (branchName == "master") {
                                        moduleImage.push("master")
                                    }
                                }
                            }
                        }
                    }
                }

                stage ('openTDSB') {
                    agent { node { label 'docker' } }
                    steps {
                        dir ('opentsdb') {
                            script {

                                // Replacing docker registry to private one
                                sh "sed -i 's/FROM ikats/FROM hub.ops.ikats.org/' Dockerfile"

                                module = 'opentsdb'
                                moduleImage = docker.build(module, "--pull .")

                                // Prepare image tag
                                fullBranchName = "${env.BRANCH_NAME}"
                                branchName = fullBranchName.substring(fullBranchName.lastIndexOf("/") + 1)
                                shortCommit = "${GIT_COMMIT}".substring(0, 7)

                                // 'DOCKER_REGISTRY' stands for internal registry creds
                                docker.withRegistry("${params.INTERNAL_REGISTRY_URL}", 'DOCKER_REGISTRY') {
                                    /* Push the container to the custom Registry */
                                    moduleImage.push(branchName + "_" + shortCommit)
                                    moduleImage.push(branchName + "_latest")
                                    if (branchName == "master") {
                                        moduleImage.push("master")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
