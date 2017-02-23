#How to deploy a TOSCA Template in INDIGO-DataCloud

This document briefly describes how to deploy a TOSCA template in INDIGO-DataCloud. TOSCA templates in INDIGO-DataCloud are employed to: i) provide the architectural description of an application to be deployed on a Cloud site; ii) to describe jobs to be deployed on Chronos and iii) long-running services to be deployed on Marathon, both on an Apache Mesos cluster. This guide focuses exclusively on the first type of TOSCA templates.

This documentation is aimed at advanced users, since regular users are expected to use the graphical user interfaces provided by the [FutureGateway](https://github.com/indigo-dc/fgDocumentation).

You will be using the [Orchestrator](https://github.com/indigo-dc/orchestrator) the PaaS service that will be responsible for deploying the customized virtual infrastructure described in the TOSCA Template on a Cloud site.

### 1. Registering in IAM
If you do not have a user account in the [IAM](https://github.com/indigo-dc/iam) service at https://iam-test.indigo-datacloud.eu/, proceed to register.
There is further documentation on how to register in the [IAM GitBook](https://indigo-dc.gitbooks.io/iam/content/)

###2. Obtaining an IAM Token
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
