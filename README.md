docker-foreman
==============

A simple Docker image to run [Foreman](http://theforeman.org/)


# Running

Set `-h` to a hostname, that's what Foreman and Puppet will use as fqdn.

    docker run -ti -h foreman.local -p 8443:443 csanchez/foreman

Then go to port 8443 of your docker host (e.g. http://localhost:8443)

If you want to open a shell session and play with the installed Puppet and other tools

    docker run -ti -h foreman.local -p 8443:443 csanchez/foreman bash

Then run `foreman-installer` to customize the instance with the new hostname,
and anything else you want to run.

    foreman-installer
    puppet agent --test
    ...

# Building

    docker build -t csanchez/foreman .
