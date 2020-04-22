+++
title = "Kubernetes Cheat Sheet"
author = ["Tom Purl"]
date = 2020-04-19T16:39:00-05:00
lastmod = 2020-04-22T16:27:23-05:00
tags = ["docker", "kubernetes"]
categories = ["braindump"]
weight = 2005
draft = false
[menu.braindump]
  weight = 2005
  identifier = "kubernetes-cheat-sheet"
+++

## kubectl {#kubectl}


### Choosing the correct context {#choosing-the-correct-context}

First check out your available contexts like this:

```shell
kubectl config get-contexts
```

```org
CURRENT   NAME                                                 CLUSTER                                              AUTHINFO                                             NAMESPACE
*        do-toms-cluster                                      do-toms-cluster                                      do-toms-cluster-admin
          gke_symmetric-blade-21345                            gke_symmetric-blade-21345                            gke_symmetric-blade-21345
```

You can then choose the desired context like this:

```shell
kubectl config use-context do-toms-cluster
```


### Merging Multiple Contexts {#merging-multiple-contexts}

-   <https://stackoverflow.com/a/46184649/1380901>
