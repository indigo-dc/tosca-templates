#How to deploy a TOSCA Template in INDIGO-DataCloud

This document briefly describes how to deploy a TOSCA template in INDIGO-DataCloud. TOSCA templates in INDIGO-DataCloud are employed to: i) provide the architectural description of an application to be deployed on a Cloud site; ii) to describe jobs to be deployed on Chronos and iii) long-running services to be deployed on Marathon, both on an Apache Mesos cluster. This guide focuses exclusively on the first type of TOSCA templates.

This documentation is aimed at advanced users, since regular users are expected to use the graphical user interfaces provided by the [FutureGateway](https://github.com/indigo-dc/fgDocumentation).

You will be using the [Orchestrator](https://github.com/indigo-dc/orchestrator) the PaaS service that will be responsible for deploying the customized virtual infrastructure described in the TOSCA Template on a Cloud site.

If you want to have an overview of the services involved in the orchestration, there is further documentation available in the public [deliverable D5.2](https://www.indigo-datacloud.eu/documents/design-document-and-work-plan-paas-architecture-d52).

## 1. Registering in IAM
If you do not have a user account in the [IAM](https://github.com/indigo-dc/iam) service at https://iam-test.indigo-datacloud.eu/, proceed to register.
There is further documentation on how to register in the [IAM GitBook](https://indigo-dc.gitbooks.io/iam/content/)

##2. Obtaining an IAM Token
An IAM token is required to interact with the Orchestrator.

There are different ways to obtain an IAM token.

* Option 1: Connect to https://watts-dev.data.kit.edu/, select the "INDIGO DataCloud Identity and Access Management (IAM) OpenId Connect Provider and login using your IAM credentials. You will find a button to know your IAM token which looks like this one:

```
eyJraWQiOiJyc2ExIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJmODcwNzdiNi1iNDZhLTQ3ODEtYjhmMy00Mzg1MTgxY2QzODIiLCJpc3MiOiJodHRwczpcL1wvaWFtLXRlc3QuaW5kaWdvLWRhdGFjbG91ZC5ldVwvIiwiZXhwIjoxNDg3ODY1NDQ0LCJpYXQiOjE0ODc4NjE4NDQsImp0aSI6IjQzNWVlMjJhLTEzMzctNDFmOS1hZmFhLTE3Nzg3YzJjZDE0ZiJ9.IhNumm3iQ_4CuO9xgbmFIYXsNuXjQPIEHSmHoEK4fbcL7I8yq4MzPLbYVC9_NU7tTJ2nWzt-adyzTt2_R4aFrsa-5Vh-F5xbWQWwwBHCxLooXolNFKM37PRXQ1W6CGZlv26nvPnj3DBQ1kPgUuxAO-sFbEoufG6pXJbaNyhJAOU
```

* Option 2: Connect to the [IAM Login Service Test Client](https://iam-test.indigo-datacloud.eu/iam-test-client/) and login with your IAM credentials. The "access_token (JWT)" is your IAM token.

If you have a client registered in IAM, you can also obtain an IAM token by issuing a [curl](https://curl.haxx.se/) command from the command-line as in this example:

```
curl -s -L -d client_id=7893d62e-bf8d-4a1b-81b4-a9e6b7afb192 -d client_secret=ALy1LCRoEQA8tmVuOkEDVIr0cFNZecdNCiJ2PKA4HUvmCqyfKlqIQGg8C21Mh1tPgyhH1v98YVdQTOx2JeYf1gw -d grant_type=password -d username=jdoe -d password=janed0e! -d scope="openid address phone profile offline_access email" https://iam-test.indigo-datacloud.eu/token
```

For further information on the scopes, please refer to the [IAM documentation](https://indigo-dc.gitbooks.io/iam/content/).


##3. Deciding the Client-Side Tool to Use the Orchestrator

The Orchestrator supports a [REST API](https://indigo-dc.github.io/orchestrator/restdocs/) and, therefore, it can be used by many different client-side tools. The list of tools include, but is not restricted to, the following, shown in order of usability for the end-user:

* [orchent](https://github.com/indigo-dc/orchent). This is a command-line client specifically created to interact with the Orchestrator.

* [postman](https://www.getpostman.com/) (or any other GUI-based REST client, such as [Restlet Client - DHC](https://chrome.google.com/webstore/detail/restlet-client-dhc/aejoelaoggembcahagimdiliamlcdmfm)). The advantage of using Postman is that you can have a centralized control panel to interact with other PaaS core services (e.g. [IM](https://github.com/indigo-dc/im), [CMDB](https://github.com/indigo-dc/cmdb) and [SLAM](https://github.com/indigo-dc/slam)), which are used by the Orchestrator to choose the appropriate Cloud site.

* [curl](https://curl.haxx.se/). This a low-level command-line tool.

If you just need to submit an existing TOSCA template in the [tosca-templates](https://github.com/indigo-dc/tosca-templates) GitHub repository to the Orchestrator, then using orchent should be enough and has the lowest learning curve. However, if you are planning to further interact with other PaaS core services, using Postman would be a more versatile tool.

##4. Submitting a TOSCA Template with Orchent

For further information about installing and using Orchent to submit a TOSCA template, please refer to the [Orchent User Guide](https://indigo-dc.gitbooks.io/orchent/content/user.html).

The required computational resources described in the TOSCA template will be provisioned from an underlying Cloud site that may support either VMs or Docker containers (see [A Brief Guide to TOSCA in INDIGO-DataCloud](tosca.md) in case you missed it).



##5. Deploying on a Public Cloud
INDIGO-DataCloud services can also be employed to deploy on public Clouds (such as [Amazon Web Services (AWS)](https://aws.amazon.com/) and [Microsoft Azure](https://azure.microsoft.com)).

You can indicate a restriction in a TOSCA Template so that the resources are provisioned in a specific region of a public Cloud. This depends on the specific Cloud provider.

### 5.1 Deploying on AWS

As an example, the [kepler_aws.yaml](https://github.com/indigo-dc/tosca-types/blob/master/examples/kepler_aws.yaml) TOSCA template enables to deploy an instance of the [Kepler](https://kepler-project.org/) workflow manager on AWS.

Three additional parameters are required as inputs:

```
access_key:
  type: string
  default: AKXX
secret_key:
  type: string
  default: SKXX
network_name:
  type: string
  default: vpc-XX.subnet-XX.PUBLIC
  ```

These parameters are
  * access_key: The [Access Key ID](https://aws.amazon.com/es/developers/access-keys/) of an [IAM](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html) user of an AWS account with permissions to deploy EC2 instances on the specified region.
  * secret_key: The [Secret Access Key]((https://aws.amazon.com/es/developers/access-keys/)) of the aforementioned IAM user.
  * network_name: The subnet identifier of a [VPC](https://aws.amazon.com/vpc/) on which the instances (Virtual Machines) will be provisioned. The suffix PUBLIC indicates that a public IP is requested for those instances.

  The restriction in a TOSCA Template to provision the resources from AWS is specified as follows, via the [tosca.policies.Placement](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.0/csprd01/TOSCA-Simple-Profile-YAML-v1.0-csprd01.html#_Toc430015785) normative node type:
  ```
  policies:
    - deploy_on_aws:
       type: tosca.policies.Placement
       properties: { sla_id: SLA_provider-AWS-us-east-1_indigo-dc,  username: {get_input: access_key}, password: {get_input: secret_key}}
       targets: [ kepler_server ]
  ```

The value of sla_id must correspond to the SLA Identifier in the SLAM instance that the Orchestrator is using. The CMDB must have a set of [AMI](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) identifiers registered for the different operating systems supported: Ubuntu 16.04 and CentOS 7, at least. This process should be carried out by a system administrator. Please refer to the [CMDB documentation](https://www.gitbook.com/book/indigo-dc/cmdb/details) and [SLAM documentation](https://www.gitbook.com/book/indigo-dc/slam/details) for further details.

If you want to deploy an elastic virtual cluster specifically on AWS, as in the [galaxy_elastic_cluster_aws.yaml](https://github.com/indigo-dc/tosca-types/blob/master/examples/galaxy_elastic_cluster_aws.yaml), you must only specify the worker nodes in the tosca.policies.Placement section:

```
policies:
    - deploy_on_aws:
       type: tosca.policies.Placement
       properties: { sla_id: SLA_provider-AWS-us-east-1_indigo-dc,  username: {get_input: access_key}, password: {get_input: secret_key}}
       targets: [ lrms_wn ]
```
This will cause the front-end to be deployed on AWS and the worker nodes to be dynamically provisioned also from AWS.
