FROM devopsil/puppet:3.7.0

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install http://yum.theforeman.org/releases/1.6/el6/x86_64/foreman-release.rpm
RUN yum -y install foreman-installer

# make hostname -f work for foreman-installer
RUN puppet apply -e 'host { $::hostname: ensure => absent } -> host { "${::hostname}.docker.local": ip => $::ipaddress, host_aliases => [$::hostname] }' && foreman-installer

# reset installer config, so the hostname is properly set at runtime
COPY foreman-installer-answers.yaml /etc/foreman/

# rerun setup with current hostname
CMD foreman-installer && tail -f /var/log/foreman/production.log

EXPOSE 443

# Run with
# docker run -ti -h foreman.local -p 8443:443 foreman
