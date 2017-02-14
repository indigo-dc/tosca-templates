#A Brief Guide to TOSCA for INDIGO-DataCloud

This document provides a brief introduction to the usage of the [TOSCA Simple Profile in YAML Version 1.0](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.0/csprd01/TOSCA-Simple-Profile-YAML-v1.0-csprd01.html) standard for INDIGO-DataCloud by means of already existing examples of TOSCA templates that support different use cases. This document is not intended to be a comprehensive description of the TOSCA standard. Instead, it is meant to provide the information required to kick-start yourself into creating or modiying existing TOSCA templates.


### Preliminary Statements
* A TOSCA Template is text document written in [YAML](http://yaml.org/) that describes an architecture of an application to be deployed on a Cloud site (deployment of a customized virtual infrastructure).
* In INDIGO-DataCloud TOSCA templates are also employed to describe jobs to be executed via [Chronos](https://mesos.github.io/chronos/) as well as long-running services executed via [Marathon](https://mesosphere.github.io/marathon/), both on an [Apache Mesos](http://mesos.apache.org/) cluster.
* The INDIGO-DataCloud [PaaS Orchestrator](https://github.com/indigo-dc/orchestrator) accepts TOSCA templates as input.
* There are two main publicly available sources of TOSCA templates for INDIGO-DataCloud:
  * The [tosca-templates](https://github.com/indigo-dc/tosca-templates) GitHub repository, which contains the authoritative templates employed to support different use cases and deploy required infrastructure used by the PaaS (e.g. a Mesos cluster).
  * The [tosca-types/examples](https://github.com/indigo-dc/tosca-types/tree/master/examples) directory of the corresponding GitHub repository, which contains additional TOSCA templates used for examples, training, testing as well as incubating TOSCA templates for uses cases before they are assessed and, therefore, transitioned to the [tosca-templates] repository.
* The very same TOSCA template should be employed to:
  * Deploy an application by spawning an instance of a Docker container out of a Docker image available in Docker Hub on either a Cloud site managed via [OneDock](https://github.com/indigo-dc/onedock), in the case of [OpenNebula](https://opennebula.org/), and [nova-docker](https://github.com/indigo-dc/nova-docker) in the case of [OpenStack](https://www.openstack.org/), which both allow to natively deploy Docker containers (Docker images will have to be registered in the site), and,
  * Deploy an application by spawning a vanilla VM or Docker container on a Cloud site and installing the application by means of the corresponding Ansible Role that defines how to install a particular application.


###Anatomy of a TOSCA Template to Deploy Customized Virtual Infrastructures

Let's dissect a sample TOSCA template used for one of the use cases that involves the [Kepler](https://kepler-project.org/) workflow management system. This use case involves deploying a computing resources (either a Docker container or a Virtual Machine) on a Cloud site that it is automatically configured to have the Kepler application installed. Users will connect to the provisioned computing node via VNC (other use cases may require Web access or SSH access).

The TOSCA template is available in the [tosca-templates/kepler.yaml](https://github.com/indigo-dc/tosca-templates/blob/master/kepler.yaml) file of the corresponding GitHub repository. You should open it alongside this document to be able to follow this explanation.

These are the four top-level nodes of the TOSCA Template:

* **tosca_definitions_version**. It specifies the version of the standard employed, which, in this case is the [TOSCA Simple Profile in YAML Version 1.0](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.0/csprd01/TOSCA-Simple-Profile-YAML-v1.0-csprd01.html).
* **imports**: Imports the [tosca-types/custom_types.yaml](https://github.com/indigo-dc/tosca-types/blob/master/custom_types.yaml) file. There are additional non-normative node types that have been created in that file to define the requirements for the different applications of the user communities.
* **description**: A sample description of the purpose of the document.
* **topology_template**: Description of the architecture (topology) of the application.

The **topology_template** node includes the following sections:

* **inputs**: These are the parameters, together with the default values, that can be used to further customize the TOSCA Template.
* **node_templates**: Description of the nodes that form the application architecture.

For this particular application, the **node_templates** section includes the following information:

* **kepler**: A node of type _tosca.nodes.indigo.Kepler_, whose definition can be found in the [tosca-types/custom_types.yaml](https://github.com/indigo-dc/tosca-types/blob/master/custom_types.yaml) file. It is not strictly required to create additional non-normative types for different applications but this leads to cleaner and reduced TOSCA templates.

* **kepler_server**: A node of type _tosca.nodes.indigo.Compute_, whose definition can be also be found in the aforementioned file. Nodes of this type will be deployed as either VMs or Docker containers on a Cloud site.
  * **capabilities**: The network is requested to be public, what means that a public IP will be allocated to the computing node. It is also specified that a set of open ports (tcp/22, for ssh and tcp/5900, for VNC) should be open.
  * **host**: A certain amount of CPUs and memory size is expressed as requirements for the application.
  * **os**: A specific Operating System (OS) configuration is indicated as a preference for the application to be run on. In this case, a GNU/Linux Ubuntu 14.04 LTS is requested. In this case, a specific image tag is indicated as a user-defined preference on which to run the application. This is explained in the following section.

* **outputs**: Information to be provided as output by the Orchestrator after deploying the customized virtual infrastructure specified in a TOSCA template. This is the information that can be requested:
  * _public_address_: The public IP of a computing node.
  * _credential_: The private key to access a computing node. You will need a username, an IP and a private key to log into a computing node.


### On the Image Configuration

The [tosca-templates/kepler.yaml](https://github.com/indigo-dc/tosca-templates/blob/master/kepler.yaml) TOSCA template specified the [indigodatacloudapps/kepler](https://hub.docker.com/r/indigodatacloudapps/kepler/) image as part of the properties of the OS for the kepler_server of type tosca.nodes.indigo.Compute.

Indeed, computing nodes (i.e., VMs or Docker containers) have to be created out of images. The  [indigodatacloudapps/kepler](https://hub.docker.com/r/indigodatacloudapps/kepler/) is a created image available in Docker Hub that has to be previously registered in a site managed by OneDock or nova-docker. Since Docker containers are created in a matter of seconds it is preferred to deploy the application as a Docker container on a Cloud site that has that image registered.

The information about which Cloud sites support which images is managed by the [CMDB](https://github.com/indigo-dc/cmdb) and it is used by the PaaS Orchestrator to provision the nodes specified in the TOSCA template on a Cloud site that supports that image. If no Cloud site supports that image, then any site that has a vanilla Ubuntu 14.04 image registered (either as a VM image or as a Docker image) will be chosen, as indicated in the specific case of the Kepler TOSCA template.

The Dockerfile employed to create that Docker image is available in [indigodatacloudapps/kepler - Dockerfile](https://hub.docker.com/r/indigodatacloudapps/kepler/~/dockerfile/). You will notice that there is a specific structure that must be followed, summarised as follows:

* It is based on a base image that has certain software installed (e.g. cloud-init, OpenNebula contextualization support, Ansible, openssh, etc.). We provide base images for Ubuntu 14.04 and 16.04 (see the [indigodatacloud/ubuntu-sshd](https://hub.docker.com/r/indigodatacloud/ubuntu-sshd/) and for CentOS 6 and 7 (see the [indigodatacloud/centos-sshd](https://hub.docker.com/r/indigodatacloud/centos-sshd/).

* It retrieves an [Ansible Role](http://docs.ansible.com/ansible/playbooks_roles.html) from the [indigo-dc user in Ansible Galaxy](https://galaxy.ansible.com/indigo-dc/), which is [indigo-dc.kepler](https://galaxy.ansible.com/indigo-dc/kepler/), whose source code is available in the [indigo-dc/ansible-role-kepler](https://github.com/indigo-dc/ansible-role-kepler) GitHub repository, and performs the execution of the role, thus installing the application in the Docker image.
* It invokes the necessary scripts for the OpenNebula contextualization to take place and issues a command so that the Docker container does not stop. In this particular case, it starts the VNC Server in the foreground. Otherwise, the Docker container would just stop after executing the command.

Note that the very same Ansible Role created with the installation recipe of an application, in this case Kepler, is used both to create the Docker image and/or to dynamically deploy the application at runtime on a vanilla VM or Docker container. This simplifies maintenance while providing access to the Docker-based and VM-based Cloud sites.


### A Word of Caution

* Specifying a set of ports to be open in a TOSCA template typically translates into a specific security group configuration in OpenStack or AWS. However, if the computing node is deployed on a Cloud site behind a firewall, your application will still be inaccessible.
