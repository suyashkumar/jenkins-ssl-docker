FROM jenkins/jenkins:lts
LABEL maintainer="suyash@suyashkumar.com"
USER jenkins
WORKDIR /usr/src/work
COPY get-docker.sh .
COPY gen_certs.sh .
USER root
# Install Docker CE inside the container
RUN sh get-docker.sh
RUN usermod -aG docker jenkins
# Generate self-signed certs
RUN bash gen_certs.sh
RUN openssl rsa -in server.key -out privkey-rsa.pem
RUN mkdir -p /var/lib/jenkins
RUN cp privkey-rsa.pem /var/lib/jenkins/pk
RUN cp server.pem /var/lib/jenkins/cert
RUN chown jenkins:jenkins /var/lib/jenkins/pk
RUN chown jenkins:jenkins /var/lib/jenkins/cert
# Other misc config
USER jenkins
ENV JENKINS_OPTS --httpPort=-1 --httpsPort=4430 --httpsCertificate=/var/lib/jenkins/cert --httpsPrivateKey=/var/lib/jenkins/pk
EXPOSE 443
