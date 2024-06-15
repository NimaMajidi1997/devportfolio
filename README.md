# DevOpsAdventures
# To learn different aspects of DevOps

# &#128640; Website setup:
![Alt text](website_cycle.svg)

	1. Making Dockerfile
	2. Build image and run container
	3. Push image to Dockerhub (dockerhub token)
	4. Deploy image to the Server (private key for github and public one for ~/.ssh/authorized_keys)
	5. Run container inside the server
 	6. https://www.nimadevops.de


	1.0.0 --> initial setup
	1.0.1 --> bug for mobile phone fixed, education added

 	2.0.0 --> About, Work Experience, DevOps experience completed, fonts changed
	2.0.1 --> About me completed
	2.0.2 --> Certificates added
	2.0.3 --> Contact implemented
	2.0.4 --> resume updated
	2.0.5 --> resume modified
	2.1.0 --> phone display fixed

	3.0.0 --> change the nginx image from debian to ubuntu
	3.1.0 --> ssl certificates added for https
	3.1.1 --> add favicon and title
	3.2.0 --> certificates in table, fix responsive
	3.2.1 --> update resume - V4
	

	To renew SSL certificates:
		docker stop <container_id_or_name>;
		sudo certbot certonly --standalone -d nimadevops.de -d www.nimadevops.de;
		docker rm -f port_web || true;
		sudo docker run -d -p 80:80 -p 443:443 -v /etc/letsencrypt:/etc/letsencrypt --name port_web nimaianp75/devops_web:3.1.0

# &#128640; Windows Containers
	Sample1: Dockerfile
 	I made a Dockerfile to have a windows container based on these Packages:
		1.windows server 2019
		2.Git-2.44.0-64
		3.python-3.10.0
		4.conan==1.57.0
		5.cmake-3.29.0 
		6.cuda_12.1.0_531.14 --> download from https://developer.nvidia.com/cuda-12-1-0-download-archive
		7.visual studio 2019 --> Workloads: MSBuildTools - VCTools --> download from https://learn.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2019
  	
