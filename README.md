Ncloud assignment work in progress 

- Architecture design
- Ability to present solutions
- Engineering skills
- Documentation
- Security


This is a setup that ochestrates deployment of ghost blog to a kubernetes cluster, in our case EKS 

This setup integrate multiple devops tools to achieve a deployment. Below are the following steps we have implemented to 

- Create networking layers (VVPC|Subnets etc)
- Create platform for deployment 
- Build and push application to ECR (Ci)
- Bootstrap platform with fluxCD
- Setup fluxcd sources 
- Deploy components via repo with flux gitOps 
    - GhotBlog app 
    - Monitoring
    - Ingress 
    - Security rbac manager 
    - 

    
