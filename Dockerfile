FROM devopsil/puppet:3.7.0

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install http://yum.theforeman.org/releases/1.6/el6/x86_64/foreman-release.rpm
RUN yum -y install foreman-installer

# make hostname -f work for foreman-installer
RUN puppet apply -e 'host { $::hostname: ensure => absent } -> host { "${::hostname}.docker.local": ip => $::ipaddress, host_aliases => [$::hostname] }' && foreman-installer --foreman-admin-password=changeme

# reset installer config, so the hostname is properly set at runtime
COPY foreman-installer-answers.yaml /etc/foreman/

# helper script to run puppet agent
COPY puppet-agent.sh /

# rerun setup with current hostname
CMD foreman-installer --foreman-admin-password=changeme \
  && puppet agent --test \
  && tail -f /var/log/foreman/production.log

EXPOSE 443
