#!/bin/sh

sed -i "/certname.*=.*/d" /etc/puppet/puppet.conf
sed -i "s/server.*=.*/server = $1/" /etc/puppet/puppet.conf
sed -i "s/:url: .*/:url: \"https:\/\/$1\"/" /etc/puppet/foreman.yaml

while true; do
  echo "Running puppet agent"
  puppet agent --test --verbose --server $1 --waitforcert 60
  sleep 60
done
