# Containerized Django on Azure with Application Insights

This is a sample project that demonstrates how to containerize a
Django application and deploy it to Azure App Service with Application
Insights.

## TL;DR - how to enable Application Insights in Django

You need to add following lines to your `manage.py`, `asgi.py` and
`wsgi.py` files:

```python
import os
from azure.monitor.opentelemetry import configure_azure_monitor


configure_azure_monitor(
    connection_string=os.environ.get("APPLICATIONINSIGHTS_CONNECTION_STRING")
)
```

Pay attention to the following files within this django project:
- [app/manage.py](app/manage.py)
- [app/wsgi.py](app/config/wsgi.py)

If you have debug mode disabled (`DEBUG=False`) you need to configure
the `LOGGING` settings in your `settings.py` file. This project is
using the `LOGGING` settings in the [app/settings.py](app/config/settings.py):

```python
# https://docs.djangoproject.com/en/5.1/topics/logging/#examples
LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "verbose": {
            "format": "{levelname} {asctime} {module} {message}",
            "style": "{",
        },
    },
    "handlers": {
        "console": {
            "level": "INFO",
            "class": "logging.StreamHandler",
            "formatter": "verbose",
        },
    },
    "loggers": {
        "django": {
            "handlers": ["console"],
            "level": "INFO",
            "propagate": True,
        },
        "config": {
            "handlers": ["console"],
            "level": "INFO",
            "propagate": True,
        },
    },
}
```

## Capabilities
- Containerized Django application
- GitHub Actions CI/CD pipeline for building the Container
- Infrastructure as Code (IaC) with Terraform

## Django Container Setup (Local)

This project is supposed to be deployed at Azure App Service. It's
not really useful to run the Django application locally. However, if
you want to run the Django application locally, you can follow the
steps below.

#### Prerequisites
- Docker
- Optional: a valid Application Insights Instrumentation Key

#### Steps
1. If you have already a valid application insights instrumentation
    key, you can create a `.env.app-insights` file and populate it with
    the key.
    ```bash
    cp app/.env.app-insights.example app/.env.app-insights
    ```
2. Build the Docker image
    ```bash
    docker build -t {{ YOUR_SUPPOSED_DOCKER_REGISTRY_NAME }}:latest .
    ```
3. Run the Docker container
    ```bash
    docker run -p 80:80 --env-file ./app/.env.local --env-file ./app/.env.app-insights {{ YOUR_SUPPOSED_DOCKER_REGISTRY_NAME }}:latest
    ```

If you have a valid Application Insights Instrumentation Key, logs
should be sent to Application Insights. You can view the logs in the
Azure Portal.

## Django Container Setup (Using CI/CD Pipeline)

This repository also includes some workflows to build and push the
Docker image to Azure Container Registry. This is specially useful if
you are working on an Apple Silicon Mac and you don't want to mess
with docker workarounds (like I do).

#### Prerequisites
- Container Registry with username and password access
- Repository hosted on GitHub (i.e. by creating a fork of this
    repository)

#### Steps
1. Set up the following secrets in your GitHub repository:
  `CONTAINER_REGISTRY` (i.e. `mycompany.azurecr.io`),
  `CONTAINER_REGISTRY_USERNAME`, `CONTAINER_REGISTRY_PASSWORD`
2. Trigger the GitHub Actions workflow `2 - Deployment Workflow`
   manually

_If you don't want to use the CI/CD pipeline, you can also use a
local workflow to build and push the Docker image to your container
registry._

## Infrastructure as Code (IaC) with Terraform

For quick setup of the infrastructure, you can use the Terraform
scripts provided in the `iac` directory. Since this is a sample
project, the Terraform scripts are designed to be simple and only
a dev environment is provided.

#### Prerequisites
- Terraform CLI
- Azure CLI
- an active Azure subscription
- Contributor access to the Azure subscription
- A Container Registry with username and password access

#### Steps
1. Navigate into directory `iac/03_dev`
    ```bash
    cd iac/03_dev
    ```

2. Login to azure CLI
    ```bash
    az login
    ```

3. Initialize Terraform
    ```bash
    terraform init
    ```

4. Optional but recommended: create a `terraform.tfvars` file and
    populate it with the required variables. If you are not creating a
    `.tfvars` file, you will be prompted to enter the values
    interactively when you run `terraform apply` or use environment
    variables.
    ```bash
    cp .tfvars.example .tfvars
    ```

5. Apply the infrastructure and press `yes` when prompted
    ```bash
    terraform apply -var-file=.tfvars
    ```

_Unfortunately, the cicd pipeline won't execute the terraform script
yet._
