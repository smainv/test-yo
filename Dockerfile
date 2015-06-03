# Ubuntu base image
FROM ansible/ubuntu14.04-ansible:stable

# Add provisioning files to the Docker image
ADD provisioning /srv/provisioning/
WORKDIR /srv/provisioning

# Configure Docker image using Ansible
RUN ansible-playbook webserver.yml -c local

# Port mapping
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/apachectl", "-DFOREGROUND"]

