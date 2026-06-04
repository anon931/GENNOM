# GENNOM
### Grid-Energy Neural Network Optimization & Management
<!-- BANNER PRINCIPAL -->
<p align="center">
  <a href="https://github.com/anon931/GENNOM">
    <img src="https://capsule-render.vercel.app/api?type=waving&color=0:1e293b,100:3b82f6&height=220&section=header&text=⚡%20G-ENNOM&fontSize=60&fontColor=white&animation=fadeIn&fontAlignY=35&desc=Grid-Energy%20Neural%20Network%20Optimization%20%26%20Management&descAlignY=55&descSize=18"/>
  </a>
</p>

<!-- BADGES -->
<p align="center">
  <img src="https://img.shields.io/badge/Java-17-blue.svg?style=for-the-badge&logo=openjdk&logoColor=white&color=1e293b"/>
  <img src="https://img.shields.io/badge/Spring%20Boot-3.2.0-brightgreen.svg?style=for-the-badge&logo=springboot&logoColor=white&color=1e293b"/>
  <img src="https://img.shields.io/badge/React-18-blue.svg?style=for-the-badge&logo=react&logoColor=white&color=1e293b"/>
  <img src="https://img.shields.io/badge/TypeScript-5.2-blue.svg?style=for-the-badge&logo=typescript&logoColor=white&color=1e293b"/>
  <img src="https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge&logo=opensourceinitiative&logoColor=white&color=1e293b"/>
</p>

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=500&size=20&duration=3000&pause=500&color=3B82F6&center=true&vCenter=true&width=800&lines=🌱+Eco-friendly+Industrial+Energy+Optimization;🤖+LSTM+Neural+Network+Predictions;📊+Real-time+Dashboard+with+Recharts;🏭+Designed+for+Chimbote's+Industrial+Sector"/>
</p>

---

## 📌 Sobre el Proyecto

**GENNOM** es una plataforma SaaS (Software as a Service) diseñada para la **optimización de la eficiencia energética en entornos industriales de media tensión**. Utiliza arquitectura hexagonal y modelos de inteligencia artificial (LSTM) para predecir el consumo eléctrico y detectar anomalías en tiempo real.

## ✨ Características Principales

🔮 **Predicción LSTM** | Modelo de red neuronal recurrente para proyectar demandas energéticas futuras 
📊 **Dashboard Interactivo** | Gráficos en tiempo real con métricas de consumo, eficiencia y ahorro 
👥 **Multiempresa (SaaS)** | Registro de empresas, cada una con su propia planta industrial e inventario 
🔐 **Autenticación JWT** | Roles de usuario (ADMIN / USER) con autorización por tokens 
⚙️ **Simulación Automática** | Generación de datos de consumo basada en parámetros configurables 
🚨 **Detección de Anomalías** | Identificación de desviaciones superiores al 20% en el consumo 
🌱 **Eco Score** | Métrica de sostenibilidad que califica la eficiencia de cada planta 
🐳 **Docker Ready** | Entorno completo con Docker Compose 

---

## 🛠️ Stack Tecnológico

### Backend
| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| Java | 17 | Lenguaje de programación base |
| Spring Boot | 3.2.0 | Framework base |
| Spring Security | 6.1.1 | Autenticación JWT |
| Spring Data JPA | - | Persistencia de datos |
| DeepLearning4j | 1.0.0-M2.1 | Red neuronal LSTM |
| MySQL | 8.0 | Base de datos relacional |
| Redis | 7 | Caché de predicciones |
| Flyway | 9.22.3 | Migraciones de BD |
| Lombok | 1.18.30 | Reducción de boilerplate |

### Frontend
| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| React | 18.2.0 | Biblioteca de UI |
| TypeScript | 5.2.2 | Tipado estático |
| Vite | 5.0.8 | Build tool |
| TailwindCSS | 3.3.0 | Estilos |
| Recharts | 2.10.0 | Gráficos interactivos |
| Zustand | 4.4.7 | Estado global |
| React Router DOM | 6.20.0 | Enrutamiento |
| Axios | 1.6.0 | Cliente HTTP |
| Socket.io-client | 4.5.4 | Comunicación WebSocket |

### DevOps
| Tecnología | Propósito |
|------------|-----------|
| Docker | Contenerización |
| Docker Compose | Orquestación multi-contenedor |
| Git | Control de versiones |

## 🚀 Instalación y Ejecución

### Requisitos Previos

- **Docker Desktop** (recomendado) o alternativamente:
  - Java 17+
  - Node.js 18+
  - MySQL 8.0+
  - Maven 3.8+

# Clona el repositorio:
```bash
git clone https://github.com/anon931/GENNOM.git
cd GENNOM
```

### Opción 1: Docker (recomendada)
# Levantar todos los servicios
```bash
docker-compose up --build
```

# Acceder a la aplicación de prueba local
# Frontend: http://localhost:3000
# Backend API: http://localhost:8080

### Opción 2: Sin docker
# Primera terminal
```bash
cd backend
./mvnw clean package -DskipTests
java -jar target/gennom-backend-0.0.1-SNAPSHOT.jar
```
# Segunda terminal
```bash
cd frontend
npm install
npm run dev
```

# 🔑 Credenciales por Defecto 
| Rol | Usuario | Contraseña |
|-----|---------|------------|
| Administrador | admin | admin123 |
| Usuario Normal | (Regístrate en la app) |	- |

# 🤝 Contribuciones
Las contribuciones son bienvenidas. Por favor, abre un issue primero para discutir el cambio que deseas realizar.

# 📄 Licencia
Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](https://github.com/anon931/GENNOM/blob/master/LICENSE) para más detalles.

## Contacto

Autor: Anon931 anon.dima00@gmail.com
Repositorio: [https://github.com/anon931/GENNOM](https://github.com/anon931/GENNOM)

---

