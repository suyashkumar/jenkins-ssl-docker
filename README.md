# Jenkins SSL + Docker
A Jenkins docker configuration that includes SSL out of the box as well as support for running Docker container builds **within** Jenkins. I find the latter very useful as I tend to run all of my Jenkins jobs and builds using docker containers to best handle dependency management and reproducibility. The default SSL certificates are self-signed and generated at build time, but can be overridden with your own using Docker volumes.

To run (with self-signed SSL certificates):
```sh
docker run -p 443:4430 -v jenkins_home:/var/jenkins_home suyashkumar/jenkins-ssl-docker
```

To run WITH the ability to have Jenkins build Docker containers within itself:
```sh
docker run -p 443:4430 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock suyashkumar/jenkins-ssl-docker
```

To run with your own certificates:
```sh
docker run -p 443:4430 -v jenkins_home:/var/jenkins_home -v YOUR_PRIV_KEY_FILE:/var/lib/jenkins/pk -v YOUR_CERT:/var/lib/jenkins/cert suyashkumar/jenkins-ssl-docker
```
