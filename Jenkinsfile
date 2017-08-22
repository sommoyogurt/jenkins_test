node {
    def app
    def scmVars
    def DEUS_PATH = '/var/deus'

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        scmVars = checkout scm
        println scmVars.GIT_COMMIT
        
    }
    
    stage('Info image') {
        sh 'whoami'
        sh 'pwd'
        sh 'ls -trl /var/run/*'
        sh 'ls -trl ./*'
    }

    stage('Build containter image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        app = docker.build("sommoyogurt/base")
        app.inside {
            sh 'apt-get install -y git'
            sh 'python --version'
        }
        
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'cd ${env.PYTHONPATH}'
            sh 'pwd'
            /*sh DEUS_PATH '/py.test --junitxml results.xml tests.py'
            sh 'echo "Tests passed"'*/
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
