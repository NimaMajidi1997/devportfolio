In this tutorial, we learn how to connect an Ubuntu-WS to a Windows machine.

First, install this in Ubuntu-WS:

```bash
sudo apt update
sudo apt install pipx
pipx install ansible-core
pipx inject ansible-core pywinrm
```

Then, you need to setup these in Windows by Powershell:

```bash
# Run in an elevated PowerShell session (as Administrator)
winrm quickconfig
winrm set winrm/config/service/Auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/listener?Address=*+Transport=HTTP
Enable-PSRemoting -Force
```

In Ubuntu-WS you need also an inventory file and install_on_windows.yml. Now, you can easily run the .yml file:

```bash
ansible-playbook -i inventory install_on_windows.yml
````

