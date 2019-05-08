#### Secrets

A secret is an object that contains a small amount of sensitive data such as a password, a token, or a key.

_Noteworthy points:_

* Reduces risk of exposing sensitive data
* Created outside pods
* Can be used in two ways: Env or Volume
* Created outside of pods
* Stored inside `etcd database` on kubernetes Master

##### Usage:



Create secret's manifest file `sample-secret.yaml`
```
---
apiVersion: v1
kind: Secret
metadata:
  name: samplesecret
type: Opaque
data: 
  username: YWRtaW4=
  password: MTIzNDU=
```

Run `kubectl create -f sample-secret.yaml` to create a secret.

Use secret via `env`:
```
---
apiVersion: v1
kind: Pod
metadata:
  name: sample-env-pod
spec:
  containers:
  - name: sample-env-pod
    image: redis
    env:
    - name:  SECRET_USERNAME
      valueFrom:
        secretKeyRef:
          name: samplesecret
          key: username

    - name:  SECRET_PASSWORD
      valueFrom:
        secretKeyRef:
          name: samplesecret
          key: password
  restartPolicy: Never
````

Run `kubectl create -f sample-secret-env-pod.yaml` to create a pod.


*Or* via `volume`;

Create the pod's manifest file `sample-secret-volume-pod.yaml`

```
---
apiVersion: v1
kind: Pod
metadata:
  name: samplepod
spec:
  containers:
  - name: samplepod
    image: redis
    volumeMounts:
    - name: foo
      mountPath: "/etc/foo"
      readOnly: true
  volumes:
  - name: foo
    secret:
      secretName: samplesecret
```

Run `kubectl create -f sample-secret-volume-pod.yaml` to create a pod.