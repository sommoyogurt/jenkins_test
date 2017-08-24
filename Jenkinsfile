node {
    def app
    def scmVars
    def PROPS
    
    properties([parameters([string(name: 'branch', defaultValue: 'master')])])
    
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        println "BRANCH NAME: ${params.branch}" 
        echo "${params}"
        println params
        scmVars = checkout scm
    }

    stage('Build containter image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("sommoyogurt/base", "--build-arg ENVIROMENT=192.168.100.173 -f ./Dockerfile .")
        app.inside {
            sh 'env > env.txt'
            PROPS = readProperties(file: 'env.txt')
        }
        app.inside(" -v /var/jenkins_home/workspace/test-pipe-me:${PROPS.PYTHONPATH} -w /var/jenkins_home/workspace/test-pipe-me:${PROPS.PYTHONPATH}") {
            dir(PROPS.PYTHONPATH) { 
                sh 'ls -ltr'
                sh "cd ${PROPS.PYTHONPATH}"
                sh "ls -ltr ${PROPS.PYTHONPATH}"
                sh 'pwd'
                sh 'git rev-parse HEAD > ./VERSION'
                sh 'git rev-parse --short HEAD >> ./VERSION'
                sh "echo ${params.branch} - ${scmVars.GIT_COMMIT} >> VERSION"
            } 
        }
        
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            echo "PYHONPATH: ${PROPS.PYTHONPATH}"
            sh "cd ${PROPS.PYTHONPATH}"
            sh 'pwd'
            /* sh DEUS_PATH '/py.test --junitxml results.xml tests.py'
             * sh 'echo "Tests passed"' */
        }
    }
    
    stage('Images list') {
        sh 'docker ps -a'
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        /* docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
         *   app.push("${env.BUILD_NUMBER}")
         * app.push("latest")
        }*/
    }
}
