docker-foreman
==============

A simple Docker image to run [Foreman](http://theforeman.org/)


# Running

Set `-h` to a hostname, that's what Foreman and Puppet will use as fqdn.

    docker run -ti -h foreman.local --name foreman -p 443:443 -p 8443:8443 -p 8140:8140 csanchez/foreman

Then go to port 443 of your docker host (e.g. http://localhost:443)

To see more hosts in Foreman, you can run more Puppet agents

    docker run --link foreman:puppet --rm -ti csanchez/foreman /puppet-agent.sh puppet

Then sign the new certificate in Foreman under Infrastructure -> Smart Proxies -> Certificates.


If you want to open a shell session and play with the installed Puppet and other tools

    docker run -ti -h foreman.local -p 8443:443 csanchez/foreman bash

Then run `foreman-installer` to customize the instance with the new hostname,
and anything else you want to run.

    foreman-installer
    puppet agent --test
    ...


# Customizing

Create your Dockerfile and run any commands, eg. to install the docker plugin (`csanchez/foreman-docker` image)

    FROM csanchez/foreman
    RUN yum -y install ruby193-rubygem-foreman_docker

# Building

    docker build -t csanchez/foreman .
