Ncloud assignment work in progress 

- Architecture design
- Ability to present solutions
- Engineering skills
- Documentation
- Security


This is a setup that ochestrates deployment of ghost blog to a kubernetes cluster, in our case EKS 

This setup integrate multiple devops tools to achieve a deployment. Below are the following steps we have implemented to 

- Create networking layers (VPC|Subnets etc)
- Create platform for deployment 
- Build and push application to ECR (Ci)
- Bootstrap platform(EKS) with fluxCD
```ruby
flux bootstrap github --owner timonyia --repository flux-controller --branch master --path apps --personal true --components-extra=image-reflector-controller,image-automation-controller --token-auth
```
```ruby
$ k get po -n flux-system 
NAME                                           READY   STATUS    RESTARTS   AGE
helm-controller-869cbdd784-4gtgq               1/1     Running   0          65m
image-automation-controller-7655f57596-49lwq   1/1     Running   0          65m
image-reflector-controller-7b89476565-vr52v    1/1     Running   0          65m
kustomize-controller-9b95c7748-tswtf           1/1     Running   0          65m
notification-controller-f9b7dc79d-snj79        1/1     Running   0          65m
source-controller-7975f5b479-d8f45             1/1     Running   0          65m
```

- Setup fluxcd sources and kustomizations 
```ruby
flux create source git ncloud-gblog-proj-source --url https://github.com/timonyia/ncloud-gblog-proj.git --branch master --interval 30s --export | tee apps/ncloud-gblog-proj-source.yaml
flux create kustomization ncloud-gblog-proj-source --source ncloud-gblog-proj-source --path "./deployment/flux-kustomizer" --prune true --validation client --interval 10m --export | tee -a apps/ncloud-gblog-proj-source.yaml 
```
```ruby
flux get source git ; flux get kustomization 
NAME                            READY   MESSAGE                                                                 REVISION                                        SUSPENDED 
flux-system                     True    Fetched revision: master/2946a5144624abc62d6a286c5babb823666763ba       master/2946a5144624abc62d6a286c5babb823666763ba False    
ncloud-gblog-proj-source        True    Fetched revision: master/04df242257cd11859b1171c35ee9b3fe29dc0663       master/04df242257cd11859b1171c35ee9b3fe29dc0663 False    
NAME                            READY   MESSAGE                                                                 REVISION                                        SUSPENDED 
flux-system                     True    Applied revision: master/2946a5144624abc62d6a286c5babb823666763ba       master/2946a5144624abc62d6a286c5babb823666763ba False    
ncloud-gblog-proj-source        True    Applied revision: master/04df242257cd11859b1171c35ee9b3fe29dc0663       master/04df242257cd11859b1171c35ee9b3fe29dc0663 False 
```

- Deploy components via repo with flux(gitOps)
    - test|staging|prod environment 
```ruby
ncloud-gblog-proj/deployment/flux-kustomizer/test-env
test-env[master] $ ll 
total 32
-rw-r--r--  1 felixm  181693646  133 15 Nov 20:07 kustomization.yaml
-rw-r--r--  1 felixm  181693646   75 15 Nov 20:09 test-env-ns.yaml
-rw-------  1 felixm  181693646  225 15 Nov 20:12 service.yaml
-rw-------  1 felixm  181693646  516 15 Nov 20:14 deployments.yaml
```
    - GhotBlog app 
    - Monitoring
    - Ingress 
    - Security rbac manager 
    - 

- App routing and ingress configuration 
1. Install ingress controller on cluster via cli
```ruby
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.0/deploy/static/provider/cloud/deploy.yaml

$ k get ns 
NAME                 STATUS   AGE
default              Active   158m
flux-system          Active   138m
ingress-nginx        Active   44s   # Ingress Controller sits on the ingress-nginx NS
kube-node-lease      Active   158m
kube-public          Active   158m
kube-system          Active   158m
test-env-ghostblog   Active   56m

$ kcd ingress-nginx
flux-controller[master] $ k get po 
NAME                                        READY   STATUS      RESTARTS   AGE
ingress-nginx-admission-create-kb5qq        0/1     Completed   0          71s
ingress-nginx-admission-patch-nr96c         0/1     Completed   1          71s
ingress-nginx-controller-65c4f84996-lsf2r   1/1     Running     0          71s
```
2. 

