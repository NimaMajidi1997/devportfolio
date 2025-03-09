# DevOpsAdventures
## To learn different aspects of DevOps

# &#128640; Website setup:
![Alt text](images/website_cycle.svg)

	1. Making Dockerfile
	2. Build image and run container
	3. Push image to Dockerhub (dockerhub token)
	4. Deploy image to the Server (private key for github and public one for ~/.ssh/authorized_keys)
	5. Run container inside the server
 	6. https://www.nimadevops.de

	1.0.0 --> initial setup
	1.0.1 --> bug for mobile phone fixed, education added

 	2.0.0 --> About, Work Experience, DevOps experience completed, fonts changed
	2.1.0 --> phone display fixed

	3.0.0 --> change the nginx image from debian to ubuntu
	3.1.0 --> ssl certificates added for https
	3.2.0 --> certificates in table, fix responsive
	3.2.2 --> docker-compose added for testing (docker-compose up --build , docker-compose down --remove-orphans)
	3.3.0 --> docker certificate added, modify style
	3.4.3 --> add google analytics to website 
	3.4.4 --> modify style - compile css auto (sass --watch scss/styles.scss:css/styles.css)
	

	Renew SSL certificates:
		docker stop <container_id_or_name>;
		sudo certbot certonly --standalone -d nimadevops.de -d www.nimadevops.de;
		docker rm -f port_web || true;
		sudo docker run -d -p 80:80 -p 443:443 -v /etc/letsencrypt:/etc/letsencrypt --name port_web nimaianp75/devops_web:3.4.2


# &#128640; Azure Pipeline Agents
![Alt text](images/azure_pipeline_agents.png)

1. In Proxmox Virtual Environment, create a Virtual Machine. 
2. Download the agent from Azure and install it inside this VM.
3. Register this VM with agent pool that is already defined in Azure.
4. Now, you can have an Azure pipeline and use the resources of this VM by means of self-hosted agent.


Setup the agent:

```bash
.\config.cmd --unattended --replace --url *project_repo* --auth pat --token *PAT* --pool *agent_pool_name* --agent *agent_name* --acceptTeeEula --runAsService --windowsLogonAccount *computer_name\Administrator* --windowsLogonPassword Administrator
```

###### Docker Registry Service Connection: It muse be assured that Azure DevOps pipeline is authenticated correctly with the Docker registry before attempting to pull the image.

When a pipeline starts, Azure DevOps checks out source code (typically from Git or other version control systems) onto the build agent. The directory where the code is placed is referred to by the $(Build.SourcesDirectory) variable.

This is an example azure-pipelines.yml file that we learn how to:

- Setup container for agent
- Copy file from azure repo inside the container
- Use volume binding for container
- Run script inside the container

Now, we have an windows agent in proxmox that runs the windows container on its host. By means of Conan, building and packaging of the project can be done sucessfully.

# &#128640; Ansible
![Alt text](images/ansible.svg)
1. Create virtual machines on the Proxmox server.
2. Install packages like the CUDA toolkit and Docker.
3. Set up Azure DevOps agents in the VMs.
4. Deploy files from JFrog to the VMs


# &#128640; Windows Containers
You can find the Dockerfile in Windows Container folder.
I made a Dockerfile to have a windows container based on the following Packages. Tested in a VM in Proxmox server - host OS: Windows Server 2022 and process isolation. (Based on [microsoft documentation](https://learn.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/gpu-acceleration#requirements) GPU acceleration for workloads in Hyper-V-isolated Windows containers is not currently supported.):

	1.windows server 2022
	2.Git-2.44.0-64
	3.python-3.10.0
	4.conan==1.64.1
	5.cmake-3.29.0 
	6.cuda_12.1.0_531.14
	7.conda
	8.visual studio 2019 --> Workloads: MSBuildTools - VCTools

[Visual Studio installation](https://learn.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2019)
