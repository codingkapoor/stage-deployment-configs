# stage-deployment-configs
```

codingkapoor@omkara:$ vagrant up
codingkapoor@omkara:$ vagrant status

codingkapoor@omkara:$ vagrant ssh consul-server
vagrant@consul-server:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@consul-server:$ consul agent -dev -bind $ip -config-file /vagrant/consul-server/server.consul.json &

codingkapoor@omkara:$ vagrant ssh node-a
vagrant@node-a:$ /vagrant/setup/service-a.setup.sh 
vagrant@node-a:$ /vagrant/setup/service-b.setup.sh 
vagrant@node-a:$ /vagrant/setup/service-d.setup.sh 
vagrant@node-a:$ docker ps
vagrant@node-a:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@node-a:$ consul agent -advertise $ip -config-file /vagrant/consul/common.consul.json -config-file /vagrant/consul/node-a/service-a.consul.json -config-file /vagrant/consul/node-a/service-b.consul.json -config-file /vagrant/consul/node-a/service-d.consul.json &

codingkapoor@omkara:$ vagrant ssh node-b
vagrant@node-b:$ /vagrant/setup/service-a.setup.sh 
vagrant@node-b:$ /vagrant/setup/service-b.setup.sh 
vagrant@node-b:$ docker ps
vagrant@node-b:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@node-b:$ consul agent -advertise $ip -config-file /vagrant/consul/common.consul.json -config-file /vagrant/consul/node-b/service-a.consul.json -config-file /vagrant/consul/node-b/service-b.consul.json &

codingkapoor@omkara:$ vagrant ssh node-c
vagrant@node-c:$ /vagrant/setup/service-c.setup.sh 
vagrant@node-c:$ /vagrant/setup/service-e.setup.sh 
vagrant@node-c:$ docker ps
vagrant@node-c:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@node-c:$ consul agent -advertise $ip -config-file /vagrant/consul/common.consul.json -config-file /vagrant/consul/node-c/service-c.consul.json -config-file /vagrant/consul/node-c/service-e.consul.json &

codingkapoor@omkara:$ vagrant ssh node-d
vagrant@node-d:$ /vagrant/setup/service-d.setup.sh 
vagrant@node-d:$ docker ps
vagrant@node-d:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@node-d:$ consul agent -advertise $ip -config-file /vagrant/consul/common.consul.json -config-file /vagrant/consul/node-d/service-d.consul.json &

codingkapoor@omkara:$ consul agent -config-file desky.consul.json &

 
codingkapoor@omkara:$ curl --request PUT http://127.0.0.1:8500/v1/agent/service/deregister/175f012c-d347-4257-9ab9-ba4fd9ecaa60
```
