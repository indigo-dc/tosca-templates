---
description: High level description of the workflow
---

# From the user perspectives

DODAS from the user perspectives is a service aiming at enabling an easy solution for the creation of a complex setup for a computational environment on any cloud based environment. The DODAS solution pretend to be as easy as it is today creating a virtual machine over any IaaS, to some extend. Regarding the complex setup, from the user point of view this must be a TOSCA description, which relies on a set of Ansible roles for any configuration and software installation. As container based service DODAS foreseen that any service the user wants to execute on the dynamic generated cluster has been previously containerised.   
There are a set of already prepared TOSCA templates, one per supported use case \(see [this section](https://dodas.gitbook.io/dynamic-on-demand-analysis-service/~/edit/drafts/-LEDKwAyU8rRIV1lDMsb/getting-started) for further details\) but, of course, you can either extend any of them or create your own.    
As already introduced a user approaching the DODAS service needs to register first, and this must be done through the [IAM-DODAS ](https://dodas-iam.cloud.cnaf.infn.it/login)service. This step is mandatory both to access the DODAS PaaS-core services and possibly the Enabling Facility. Once delegated the user OIDC token to DODAS everything will be transparent thanks to the delegation mechanisms and services federation.   
Except the registration step there is nothing else which represent a pre-requisite DODAS specific. There are, of course, pre-requisites both if you are about to use CMS and AMS implementation of DODAS \([check here](https://dodas.gitbook.io/dynamic-on-demand-analysis-service/~/edit/drafts/-LEDKwAyU8rRIV1lDMsb/getting-started)\) as well as if you are supposed to use your own IaaS, as [explained here. ](https://dodas.gitbook.io/dynamic-on-demand-analysis-service/~/edit/drafts/-LEDKwAyU8rRIV1lDMsb/using-dodas-with-external-providers)





