docker-foreman
==============

Docker image to run [Foreman](http://theforeman.org/)


# Building

    docker build -t csanchez/foreman .

# Running

    docker run -ti -h foreman.local -p 8443:443 foreman
