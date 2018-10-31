# INDIGO-DataCloud tosca-templates

These are the TOSCA Templates Supporting the Use Cases for INDIGO-DataCloud.
The applications currently supported are:

* `amber/ambertools.yaml`: Deploy an instance that supports [AmberTools](http://ambermd.org).

* `amber/amber_job_*.yaml`: Run the amber tool [_sander_](http://ambermd.org/) through a Chronos job.

* `disvis.yaml`: Deploy an instance that supports [DisVis](https://github.com/haddocking/disvis.git).

* `docker-kepler.yaml`: Deploy a container with the [Kepler WF engine](https://kepler-project.org/) in the OneDock testbed.

* `galaxy.yaml`: Deploy a [Galaxy](http://galaxyproject.org/) server configured to execute jobs locally.

* `galaxy_elastic_cluster.yaml`:  Deploy a [Galaxy](http://galaxyproject.org/) server configured with a SLURM elastic cluster as LRMS.

* `mesos_cluster.yaml`: Deploy a [mesos](https://mesos.apache.org/) cluster. The cluster is composed by one master, three slaves and one load balancer.

* `powerfit.yaml`: Deploy an instance that supports [PowerFit](https://github.com/haddocking/disvis.git).

* `dodas/*.yaml`: Deploy an HTCondor cluster on Mesos (DODAS)

**User guides:**

* [Brief guide to TOSCA](doc/tosca.md)

* [How to deploy a TOSCA Template](doc/tosca-deploy.md)


