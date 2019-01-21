# DEEP Open Catalog TOSCA Templates

This directory contains the specific TOSCA templates of the
[DEEP-Hybrid-DataCloud project](https://deep-hybrid-datacloud.eu/)


 *  deep-oc-dogs_breed-mesos-cpu.yml   - TOSCA file to deploy [DEEP-OC-dogs_breed_det](https://github.com/indigo-dc/DEEP-OC-dogs_breed_det) on CPU nodes of MESOS.
 *  deep-oc-dogs_breed-mesos-gpu.yml   - TOSCA file to deploy [DEEP-OC-dogs_breed_det](https://github.com/indigo-dc/DEEP-OC-dogs_breed_det) on GPU nodes of MESOS.
 *  deep-oc-mesos-template.yml   - TOSCA file to deploy [DEEPaaS](https://github.com/indigo-dc/DEEPaaS)
    applications: The user has to specify the `docker_image` input value with the application docker image.
 *  kubernetes_cluster_deepaas.yaml    - TOSCA file to deploy [DEEPaaS](https://github.com/indigo-dc/DEEPaaS)
    application on top of Kubernetes Cluster. The user has to specify the `docker_image` input value with the application docker image.
 *  vm_docker_deepaas.yml              - TOSCA file to deploy [DEEPaaS](https://github.com/indigo-dc/DEEPaaS)
    application on top of a single VM. The user has to specify the `docker_image` input value with the application docker image.


# Acknowledgement

This project has received funding from the European Union’s Horizon 2020
research and innovation programme under grant agreement No 777435.
