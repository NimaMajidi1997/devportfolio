Here is the way to setup the Ansible:

I made some VMs in Proxmox. VMs can be Debian-based distributions like Ubuntu or  on Red Hat-based distributions like Fedora etc.

To check the IP:
```bash
ip addr show
```

PS: To open a new terminal window: ctrl + shift + T

Use ssh to connect to each VM.
```bash
sudo apt update
sudo apt install ansible
```


To check if these packages are available:
```bash
command -v ansible
command -v apt
```

We are in Ubuntu-WS:

* Make an 'inventory' file: write the IP address for the other Ubuntu server that we would like to manage

To generate a new SSH key pair:
```bash
ssh-keygen:
/home/nima/.ssh/ansible
```

To connect to Ubuntu-server without password:

```bash
ssh-copy-id -i ~/.ssh/ansible.pub **.ip.**.** # To copy the pub key from Ubuntu-WS to Ubuntu-server
eval $(ssh-agent) # To run the ssh-agent in RAM
ssh-add ~/.ssh/ansible
```

More Easier:
```bash
nano ~/.bashrc:
alias ssha='eval $(ssh-agent) && ssh-add ~/.ssh/ansible'

exec bash
ssha
```

To check if the ansible can ping the other machine:

```bash
ansible all --key-file ~/.ssh/ansible -i inventory -m ping
```   
Or:

```bash
nano ansible.cfg:
[defaults]
inventory = inventory
private_key_file = ~/.ssh/ansible

ansible all -m ping
```   

# Commands
To list hosts and gather facts:
```bash
ansible all --list-hosts
ansible all -m gather_facts
ansible all -m gather_facts --limit **.ip.**.**
```  


Use ansible without playbook:
```bash
ansible all -m apt -a update_cache=true
ansible all -m apt -a update_cache=true --become --ask-become-pass
ansible all -m apt -a "name=vim-nox" --become --ask-become-pass
ansible all -m apt -a "name=vim-nox state=latest" --become --ask-become-pass
ansible all -m apt -a upgrade=dist --become --ask-become-pass
```

Use ansible with playbook:
```bash
ansible-playbook --ask-become-pass install_apache.yml
ansible-playbook --tags db --ask-become-pass install_apache.yml # Using Tag
```

After creating a user you can use:
```bash
ansible-playbook --ask-become-pass install_apache.yml
```

Now, if you check ***cat /etc/passwd*** in Ubuntu-server, the new user is added and you can switch to this user by **sudo su - test_user**. By default, this new user won't have any special privileges, such as the ability to run commands as root using sudo. But still you cannot SSH to Ubuntu-server with this user!



Try this in Ubuntu-server:

```bash
sudo su
nano /etc/sudoers.d/test_user: # defining specific sudo privileges for test_user.
test_user ALL=(ALL)  NOPASSWD: ALL
# test_user can execute any command (ALL) on any host (ALL).
# The NOPASSWD option allows test_user to execute commands with sudo without being prompted for a password.
chmod 440 /etc/sudoers.d/test_user  # read-only
```
From the Ubuntu-WS copy the pub key: ***cat ~/.ssh/ansible.pub*** in Ubuntu-server. This step is essential for enabling passwordless SSH access from Ubuntu-WS to Ubuntu-server. Without the public key on the Ubuntu-server, we would have to enter a password every time Ansible tries to connect to Ubuntu-server, which defeats the purpose of automation.

```bash
sudo su - test_user
mkdir ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys: 
***pub_key***

chmod 600 ~/.ssh/authorized_keys
```
Also add ***remote_user = test_user*** to ***ansible.cfg***

Now, you run this command and it does not need any password.
```bash
ansible-playbook install_apache.yml
```


add plays for creating bootstrap user