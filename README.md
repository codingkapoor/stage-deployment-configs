# stage-deployment-configs

Vagrant based deployment configurations for project https://github.com/codingkapoor/dmv-consul-reactjs.

```
node-a(service-a(customer-a,customer-b),
		service-b(customer-b),
		service-d(customer-c)),
node-b(service-a(customer-b),
		service-b(customer-a,customer-c)),
node-c(service-c(customer-a),
		service-e(customer-b,customer-c)),
node-d(service-d(customer-a,customer-b,customer-c))
```

Follow steps mentioned below to create aforementioned deployment model in a stage/dev environment.

### 1. To create and configure virtual machines.
```
codingkapoor@omkara:$ vagrant up
```

### 2. To check the status of virtual machines created via vagrant.
```
codingkapoor@omkara:$ vagrant status
```

### 3. SSH to `consul-server` virtual mahcine to start consul server.
```
codingkapoor@omkara:$ vagrant ssh consul-server
vagrant@consul-server:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@consul-server:$ consul agent -dev -bind $ip \
                        -config-file /vagrant/consul-server/server.consul.json &
```

### 4. SSH to `node-a` virtual machine to start services and consul agent.
```
codingkapoor@omkara:$ vagrant ssh node-a
vagrant@node-a:$ /vagrant/setup/service-a.setup.sh 
vagrant@node-a:$ /vagrant/setup/service-b.setup.sh 
vagrant@node-a:$ /vagrant/setup/service-d.setup.sh 
vagrant@node-a:$ docker ps
vagrant@node-a:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@node-a:$ consul agent -advertise $ip \
                  -config-file /vagrant/consul/common.consul.json \
                  -config-file /vagrant/consul/node-a/service-a.consul.json \ 
                  -config-file /vagrant/consul/node-a/service-b.consul.json \
                  -config-file /vagrant/consul/node-a/service-d.consul.json &
```

### 5. SSH to `node-b` virtual machine to start services and consul agent.
```
codingkapoor@omkara:$ vagrant ssh node-b
vagrant@node-b:$ /vagrant/setup/service-a.setup.sh 
vagrant@node-b:$ /vagrant/setup/service-b.setup.sh 
vagrant@node-b:$ docker ps
vagrant@node-b:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@node-b:$ consul agent -advertise $ip \
                  -config-file /vagrant/consul/common.consul.json \
                  -config-file /vagrant/consul/node-b/service-a.consul.json \
                  -config-file /vagrant/consul/node-b/service-b.consul.json &
```

### 6. SSH to `node-c` virtual machine to start services and consul agent.
```
codingkapoor@omkara:$ vagrant ssh node-c
vagrant@node-c:$ /vagrant/setup/service-c.setup.sh 
vagrant@node-c:$ /vagrant/setup/service-e.setup.sh 
vagrant@node-c:$ docker ps
vagrant@node-c:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@node-c:$ consul agent -advertise $ip \
                  -config-file /vagrant/consul/common.consul.json \
                  -config-file /vagrant/consul/node-c/service-c.consul.json \
                  -config-file /vagrant/consul/node-c/service-e.consul.json &
```

### 7. SSH to `node-d` virtual machine to start services and consul agent.
```
codingkapoor@omkara:$ vagrant ssh node-d
vagrant@node-d:$ /vagrant/setup/service-d.setup.sh 
vagrant@node-d:$ docker ps
vagrant@node-d:$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
vagrant@node-d:$ consul agent -advertise $ip \
                  -config-file /vagrant/consul/common.consul.json \
                  -config-file /vagrant/consul/node-d/service-d.consul.json &
```

### 8. Start consul agent on your local machine.
```
codingkapoor@omkara:$ consul agent -config-file desky.consul.json &
```
