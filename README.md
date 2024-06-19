# LitServe meets Traefik

Deploying LitServe with Traefik Using Docker Compose.

LitServe is a high-throughput serving engine for deploying AI models at scale, while Traefik is a modern HTTP reverse proxy and load balancer that simplifies microservices deployment.

## Table of Contents

- [Run Locally](#run-locally)
  - [Direct Python Execution](#direct-python-execution)
  - [Using Docker Compose](#using-docker-compose)
- [Deploy on AWS or Other Servers](#deploy-on-aws-or-other-servers)
  - [Step-by-Step Deployment](#step-by-step-deployment)
- [Configuration](#configuration)
  - [.env Configuration](#env-configuration)
  - [Generating Traefik Dashboard Password](#generating-traefik-dashboard-password)
- [Accessing Services](#accessing-services)
  - [Local Deployment](#local-deployment)
  - [Production Deployment](#production-deployment)
- [Additional Notes](#additional-notes)

## Run Locally

### Direct Python Execution

```bash
git clone https://github.com/bhimrazy/litserve-meets-traefik.git
cd litserve-meets-traefik

# Install dependencies
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt

# Start the server
python server.py
```

Check the server at http://localhost:8000.

### Using Docker Compose

```bash
# Start the services
docker-compose up  # or docker-compose up -d to run in detached mode
```

Check the server at http://litapi.localhost.

## Deploy on AWS or Other Servers

### Step-by-Step Deployment

1. **Create a new EC2 instance and install Docker and Docker Compose:**

   ```bash
   sudo apt-get update
   sudo apt-get install docker.io
   sudo apt-get install docker-compose

   # Check Docker status
   sudo systemctl status docker
   ```

2. **Clone the repo & Set Up Environment Variables:**

   - Clone the repository and navigate to the project directory.

     ```bash
       git clone https://github.com/bhimrazy/litserve-meets-traefik.git
       cd litserve-meets-traefik
     ```

   - Create `.env` from `.env.example` and customize with your values.

     ```bash
     cp .env.example .env
     ```

3. **Generate Traefik Dashboard Password:**

   - Install `apache2-utils` and generate a password for the Traefik dashboard.

     ```bash
     sudo apt install apache2-utils
     htpasswd -nbB yourusername yourpassword
     ```

   - Add the generated password to `.env`.

4. **Start the Services:**
   use `docker-compose.prod.yml` to start the services in production mode.

   ```bash
   sudo docker-compose -f docker-compose.prod.yml up -d
   ```

Check the API server at `API_DOMAIN` as configured in `.env`, and access the Traefik dashboard at `TRAEFIK_DOMAIN` as specified in `.env`.

## Configuration

### .env Configuration

Ensure that `.env` contains the following configuration:

```plaintext
API_DOMAIN=your-api-domain.com
TRAEFIK_DOMAIN=your-traefik-dashboard-domain.com
TRAEFIK_USER=
TRAEFIK_PASSWORD=
EMAIL=
# Add other necessary environment variables
```

### Generating Traefik Dashboard Password

Generate a password for the Traefik dashboard using `htpasswd` and update `.env`:

```bash
htpasswd -nbB yourusername yourpassword
```

## Accessing Services

### Local Deployment

- LitServe API: http://litapi.localhost
- Traefik Dashboard: http://traefik.localhost

### Production Deployment

- LitServe API: httsp://your-api-domain.com
- Traefik Dashboard: https://your-traefik-dashboard-domain.com

## Additional Notes

- Ensure proper DNS configuration for domain-based access in production.
- Monitor Traefik logs (`docker-compose logs -f traefik`) for troubleshooting and monitoring.
- Customize `docker-compose.prod.yml` and `.env` according to your specific deployment requirements.

## References

- [LitServe](https://github.com/Lightning-AI/LitServe)
- [Traefik Docker Compose Configuration](https://doc.traefik.io/traefik/user-guides/docker-compose/acme-tls/)
- [FastAPI in Containers - Docker](https://fastapi.tiangolo.com/deployment/docker/)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Authors

- [Bhimraj Yadav](https://github.com/bhimrazy)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
