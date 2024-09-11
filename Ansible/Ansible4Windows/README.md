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

 In Ubuntu-WS you need also an inventory file and install_on_windows.yml:


```bash
# inventory
[windows]
windows_server ansible_host=<WINDOWS_IP>

[windows:vars]
ansible_user=<WINDOWS_USER>
ansible_password=<WINDOWS_PASSWORD>
ansible_connection=winrm
ansible_winrm_transport=basic
ansible_port=5985
ansible_winrm_server_ert_validation=ignore
```

```bash
# install_on_windows.yml
---
- name: Install software on Windows
  hosts: windows
  tasks:
    - name: Ensure Chocolatey is installed
      win_chocolatey:
        name: chocolatey
        state: present

    - name: Install Google Chrome
      win_chocolatey:
        name: googlechrome
        state: present
```
Now, you can easily run the .yml file:

```bash
ansible-playbook -i inventory install_on_windows.yml
````

