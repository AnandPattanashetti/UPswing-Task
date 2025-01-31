# UPswing-Task

# RabbitMQ Helm Chart - Production Deployment  

## 📌 Overview  
This Helm chart deploys a **3-node RabbitMQ cluster** in a **Kubernetes environment** using **StatefulSets** for persistence and **automatic clustering**.  
It is designed for **high availability**, **scalability**, and **secure deployments** in a production setup.

## Screenshots

![cluster created](https://github.com/AnandPattanashetti/cloud-devops-task/blob/main/Screenshot%20(722).png)  
![clusters](https://github.com/AnandPattanashetti/cloud-devops-task/blob/main/Screenshot%20(720).png)  
![clusters](https://github.com/AnandPattanashetti/cloud-devops-task/blob/main/Screenshot%20(721).png)  
![cluster created](https://github.com/AnandPattanashetti/cloud-devops-task/blob/main/Screenshot%20(722).png)  
![pods running](https://github.com/AnandPattanashetti/cloud-devops-task/blob/main/Screenshot%20(719).png)  
![the application](https://github.com/AnandPattanashetti/cloud-devops-task/blob/main/Screenshot%20(725).png)


## 📂 Helm Chart Structure  

```plaintext
rabbitmq-helm-chart/
│── charts/             
│── templates/           
│   ├── statefulset.yaml 
│   ├── service.yaml    
│   ├── configmap.yaml   
│   ├── secret.yaml      
│   ├── probes.yaml
|   ├── pv.yaml
|   ├── pvc.yaml       
│── values.yaml          
│── Chart.yaml           
│── README.md '''

