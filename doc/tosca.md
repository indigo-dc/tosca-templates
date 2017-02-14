#A Brief Guide to TOSCA for INDIGO-DataCloud

This document provides a brief introduction to the usage of the [TOSCA Simple Profile in YAML Version 1.0](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.0/csprd01/TOSCA-Simple-Profile-YAML-v1.0-csprd01.html) standard for INDIGO-DataCloud by means of already existing examples of TOSCA templates that support different use cases. This document is not intended to be a comprehensive description of the TOSCA standard. Instead, it is meant to provide the information required to kick-start yourself into creating or modiying existing TOSCA templates


### Preliminary Statements
* A TOSCA Template is text document written in [YAML](http://yaml.org/) that describes an architecture of an application to be deployed on a Cloud site.
* In INDIGO-DataCloud TOSCA templates are also employed to describe jobs to be executed via [Chronos](https://mesos.github.io/chronos/) as well as long-running services executed via [Marathon](https://mesosphere.github.io/marathon/), both on an [Apache Mesos](http://mesos.apache.org/) cluster.
* The INDIGO-DataCloud [PaaS Orchestrator](https://github.com/indigo-dc/orchestrator) accepts TOSCA templates as input.
* There are two main publicly available sources of TOSCA templates for INDIGO-DataCloud:
  * The [tosca-templates](https://github.com/indigo-dc/tosca-templates) GitHub repository, which contains the authoritative templates employed to support different use cases and deploy required infrastructure used by the PaaS (e.g. a Mesos cluster).
  * The [tosca-types/examples](https://github.com/indigo-dc/tosca-types/tree/master/examples) directory of the corresponding GitHub repository, which contains additional TOSCA templates used for examples, training, testing as well as incubating TOSCA templates for uses cases before they are assessed and, therefore, transitioned to the [tosca-templates] repository.


###Anatomy of a TOSCA Template
