# Docker-Swarm-Cluster
Vagrant and Ansible provisioning Docker Swarm Cluster

```bash
# To provision machines
vagrant up

# To check conectivity
ansible -m ping -i hosts all

# To start docker swarm cluster
ansible-playbook -i hosts playbook.yml
```