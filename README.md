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
    - GhotBlog app 
    - Monitoring
    - Ingress 
    - Security rbac manager 
    - 


