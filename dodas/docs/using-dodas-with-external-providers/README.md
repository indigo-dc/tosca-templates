# Using DODAS with external providers

In order to use DODAS core-PaaS Services to deploy clusters on your preferred IaaS there are two options one through the PaaS Orchestrator and one using a direct interaction with IM. Whether to use option one or two is actually strongly related to the scenario you need to address. The very basic scenario with just one Cloud provider can be addressed with direct IM interaction, everything else, spanning from a multy-hibrid cloud management up to the elastic extension, requires the PaaS Orchestrator. The usage of PaaS Orchestrator with external IaaS \(wrt DODAS provided one\) requires:

* A pre-registration of the actual IaaS provider
* A policy definition in the TOSCA template for credential management
  * This became optional depending whether the IaaS is granting a DODAS-IAM federated authentication or not. Federation could not be possible at all in public Clouds

