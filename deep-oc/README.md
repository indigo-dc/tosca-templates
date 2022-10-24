# DEEP Open Catalog TOSCA Templates

This directory contains the specific TOSCA templates of the [DEEP-Hybrid-DataCloud project](https://deep-hybrid-datacloud.eu/).

The basic templates are:

* [deep-oc-marathon-webdav](./deep-oc-marathon-webdav.yml): default template (with options for Webdav storage configuration like Nextcloud)
* [deep-oc-marathon-minimal](./deep-oc-marathon-minimal.yml): default template (_without_ options for Nextcloud storage configuration)

If you are searching for templates supporting Onedata and/or Flaat configuration,
as they were configured in the DEEP project, you should look at:

* [deep-oc-marathon-webdav-onedata](./deep-oc-marathon-webdav-onedata.yml): default template (with options for Nextcloud storage configuration)

Other TOSCA templates are probably outdated, and only keep for archiving purposes:

 *  deep-oc-dogs_breed-mesos.yml   - TOSCA file to deploy [Dog's breed detector](https://github.com/deephdc/dogs_breed_det) application on CPU or GPU nodes of MESOS+Marathon.
 *  deep-oc-generic-dev_mesos-webdav.yml - TOSCA file to deploy [Development Docker image](https://github.com/deephdc/DEEP-OC-generic-dev) application.
 *  deep-oc-mesos-webdav.yml - general TOSCA file to deploy applications leveraging [DEEPaaS](https://github.com/indigo-dc/DEEPaaS) on MESOS+Marathon. The user has to specify the `docker_image` input value with the application docker image, number of CPUs `num_cpus`, GPUs `num_gpus`, nextcloud parameters etc.
 *  deep-oc-mods_mesos-cpu.yml - TOSCA file to deploy [Massive Online Data Streams (MODS)](https://github.com/deephdc/mods) (CPU version!) application.
 *  deep-oc-mods_mesos-gpu.yml - TOSCA file to deploy [Massive Online Data Streams (MODS)](https://github.com/deephdc/mods) (GPU version!) application.
 *  deep-oc-retinopathy-cpu-template.yml - TOSCA file to deploy [Retinopathy](https://github.com/deephdc/retinopathy_test) (CPU version!) application.
 *  deep-oc-retinopathy-gpu-template.yml - TOSCA file to deploy [Retinopathy](https://github.com/deephdc/retinopathy_test) (GPU version!) application.
 *  kubernetes_cluster_deepaas.yml - TOSCA file to deploy [DEEPaaS](https://github.com/indigo-dc/DEEPaaS)
    application on top of Kubernetes Cluster. The user has to specify the `docker_image` input value with the application docker image.
 *  vm_docker_deepaas.yml - TOSCA file to deploy [DEEPaaS](https://github.com/indigo-dc/DEEPaaS)
    application on top of a single VM. The user has to specify the `docker_image` input value with the application docker image.


#### Acknowledgements

This project has received funding from the European Union’s Horizon 2020
research and innovation programme under grant agreement No 777435.
