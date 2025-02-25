Reinstall MySQL (If Needed)
If all else fails, you can completely reinstall MySQL. First, remove MySQL completely:

```bash
sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
sudo apt-get autoremove
sudo apt-get autoclean
```



Then, reinstall MySQL from scratch:

```bash
sudo apt update
sudo apt install mysql-server
```

After reinstallation, try starting MySQL again:

```bash
sudo systemctl start mysql
```
And then run the secure installation script:

```bash
sudo mysql_secure_installation
```

Create Database:

```bash
mysql -u root -p
CREATE DATABASE semaphore;
CREATE USER 'semaphore'@'localhost' IDENTIFIED BY 'mypassword123';
GRANT ALL PRIVILEGES ON semaphore.* TO 'semaphore'@'localhost';
EXIT;

mysql -u semaphore -p
SHOW DATABASES;
```

download semaphore:

```bash
wget https://github.com/semaphoreui/semaphore/releases/\
download/v2.10.43/semaphore_2.10.43_linux_amd64.deb

sudo dpkg -i semaphore_2.10.43_linux_amd64.deb
```


The command creates a new user semaphore with:

A home directory at /opt/semaphore:
The default shell set to /bin/bash:
The -m option ensures the home directory is created if it doesn't exist:

```bash
sudo useradd -m -d /opt/semaphore -s /bin/bash semaphore
sudo passwd semaphore #password123
sudo chmod 770 /opt/semaphore
sudo groupadd ansiblegroup
sudo gpasswd -M nima,semaphore ansiblegroup


sudo su semaphore
cd

semaphore setup
/usr/bin/semaphore server --config /opt/semaphore/config.json

which semaphore
```

```bash
sudo mkdir /opt/ansible
sudo chown -R nima:ansiblegroup /opt/ansible
#ensures that the user nima and the group ansiblegroup have ownership of /opt/ansible and everything inside it.
sudo chmod -R 770 /opt/ansible 
#Only the owner (nima) and group members (ansiblegroup) can read, write, or execute files in /opt/ansible.
#Other users on the system cannot access the directory or its contents at all.
```