# UPswing-Task

# RabbitMQ Helm Chart - Production Deployment  

## 📌 Overview  
This Helm chart deploys a **3-node RabbitMQ cluster** in a **Kubernetes environment** using **StatefulSets** for persistence and **automatic clustering**.  
It is designed for **high availability**, **scalability**, and **secure deployments** in a production setup.

## Screenshots

![cluster created](https://github.com/AnandPattanashetti/UPswing-Task/blob/main/1.png)  
![clusters](https://github.com/AnandPattanashetti/UPswing-Task/blob/main/2.png)  
![clusters](https://github.com/AnandPattanashetti/UPswing-Task/blob/main/3.png)  
![cluster created](https://github.com/AnandPattanashetti/UPswing-Task/blob/main/4.png)  
![pods running](https://github.com/AnandPattanashetti/UPswing-Task/blob/main/5.png)  
![the application](https://github.com/AnandPattanashetti/UPswing-Task/blob/main/6.png)
![the application](https://github.com/AnandPattanashetti/UPswing-Task/blob/main/7.png)

## VideoProof
![Watch the video](https://example.com/video)
![Watch the video](https://example.com/video)
![Watch the video](https://example.com/video)


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

