# Ingress

An API object that manages external access to the services in a cluster, typically http.
```
 internet
        |
   [ Ingress ]
   --|-----|--
   [ Services ]
```

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster.

Types of ingress:

* *Single service ingress;* Allows you to expose a single service

  create ingress' manifest file `single-service-ingress.yaml`

  ```yaml
  ---
  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    name: sample-ingress
  spec:
    backend:
      serviceName: samplesvc
      servicePort: 80
  ```

  Run ```kubectl apply -f single-service-ingress.yaml``` to create an ingress object.

* *fanout ingress* configuration routes traffic from a single IP address to more than one service, based on the HTTP url being requested.