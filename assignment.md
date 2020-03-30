# Steps to deploy

Of course it is not best practiced in the all meanings solution:

- Dockerfile - enabled multistage, used alpine to create as little as possible image (most close to be best practice)
- Travis CI file - enabled build/push, choosen minimal image for CI, no deploy, no testing, no PR checks, allowed only f-assignment branch (for excercise only)
- Infrastructure - only design without real terraform files/ k8s deployment files

## Resources

- [Travis project link](https://travis-ci.com/github/zelig81/spring-petclinic)
- [DockerHub repo link](https://hub.docker.com/repository/registry-1.docker.io/ilyag/spring-petclinic/tags?page=1)
- [Travis pipeline](./.travis.yml)
- [Dockerfile](./Dockerfile)
- To-be-implemented infrastructure:

<img width="1042" alt="petclinic-screenshot" src="./PetClinic infrastructure Architecture.png">

## CI/CD process

- clone the repository: `git clone -b f-assignment https://github.com/zelig81/spring-petclinic.git`
- commit and push to the repo. A push with new commits to branch f-assignment will cancel all the queue (and not started) builds and will start a new build.
- each Travis build should push after successful build docker image with 4 tags:
  - `latest`
  - `<branch_name>`
  - `<branch_name>__<git_commit_hash>__<travis_build_number>`
  - `<travis_build_number>`
- (still not implemented) Travis build should deploy the built docker image to test environment and launch some testing on the application
- (still not implemented) Travis build should deploy the build docker image to production (according to the architecture above)
