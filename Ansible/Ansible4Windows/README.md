In this tutorial, we learn how to connect an Ubuntu-WS to a Windows machine.

First, install these in Ubuntu-WS:

```bash
sudo apt update
sudo apt install pipx
pipx install ansible
pipx inject ansible pywinrm

```

Then, you need to setup these in Windows by Powershell:

```bash
# Run in an elevated PowerShell session (as Administrator)
winrm quickconfig
winrm set winrm/config/service/Auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/listener?Address=*+Transport=HTTP
Enable-PSRemoting -Force

# winrm quickconfig -force
# Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true
# Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $true
# Restart-Service WinRM
```
To change the network profile from Public to Private or Domain:
```bash
Get-NetConnectionProfile
Set-NetConnectionProfile -Name "YourNetworkName" -NetworkCategory Private
```

In Ubuntu-WS you need also an inventory file and install_on_windows.yml. Now, you can easily run the .yml file:

```bash
ansible-playbook -i inventory download_copy_install.yml
# CUDA installation with Chocolatey
ansible-playbook -i inventory playbook_CUDA.yml
````

