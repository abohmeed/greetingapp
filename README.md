# Greeting App

This project consists of a backend and a frontend service, both of which are containerized using Docker. The backend and frontend services can be easily managed using Docker Compose.

## Prerequisites

Before you start, make sure you have the following installed on your machine:

- [Docker](https://www.docker.com/products/docker-desktop)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Directory Structure
```
project-root/
├── backend/
│ ├── Dockerfile
│ └── ... (other backend files)
└── frontend/
├── Dockerfile
└── ... (other frontend files)
```
Ensure that your backend and frontend services each have their own `Dockerfile` within the respective directories.

## Docker Compose Configuration

The Docker Compose configuration is defined in the `docker-compose.yml` file as shown below:

```yaml
services:
  backend:
    build:
      context: ./backend
    ports:
      - 5555:5555

  frontend:
    build:
      context: ./frontend
    ports:
      - 8080:80
```
## Services
### backend:
Build Context: ./backend
Ports: Maps port 5555 on your local machine to port 5555 inside the container.
### frontend:
Build Context: ./frontend
Ports: Maps port 8080 on your local machine to port 80 inside the container.
### Starting the services
```bash
docker-compose up --build
docker-compose up -d
```
### Stopping the services
```bash
docker-compose down
```