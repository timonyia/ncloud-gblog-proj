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
- Setup fluxcd sources and kustomizations 
```ruby
flux create source git ncloud-gblog-proj-source --url https://github.com/timonyia/ncloud-gblog-proj.git --branch master --interval 30s --export | tee apps/ncloud-gblog-proj-source.yaml 
```

- Deploy components via repo with flux gitOps 
    - GhotBlog app 
    - Monitoring
    - Ingress 
    - Security rbac manager 
    - 


