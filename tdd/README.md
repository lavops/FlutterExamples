# Test-Driven Development & Clean Architecture



## Clean Architecture Project Structure
```
├─ core/                       
│  ├─ api/                     
│  ├─ errors/                  
│  ├─ network/                 
│  └─ usecases/                
│
├─ features/
│  └─ feature/
│     ├─ data/                       
│     │  ├─ datasources/             
│     │  ├─ models/                   
│     │  └─ repositories             
│     │
│     ├─ domain/                     
│     │  ├─ entities/                
│     │  ├─ repositories/            
│     │  └─ usecases/                
│     │
│     └─ presentation/               
│         ├─ business_logic/          
│         ├─ pages/                   
│         └─ widgets/                 
│   
├─ injection_container.dart    
└─ main.dart
```

![architecture](./assets/architecture.jpg)