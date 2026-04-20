# Qovery Service Catalog

Pre-built blueprints for provisioning cloud resources and Kubernetes services through the Qovery catalog. Each blueprint is a **QBM manifest** (`qbm.yml`) paired with **Terraform files** or **Helm values**.

## QBM Quick Reference

### ServiceBlueprint (Terraform)

```yaml
apiVersion: "qovery.com/v2"
kind: ServiceBlueprint

metadata:
  name: "aws-s3"
  version: "1.0.0"
  description: "S3 bucket with encryption and versioning"
  categories: ["storage", "s3"]

spec:
  engine: terraform
  provider: aws

  # credentials.default: cluster (use cluster IAM role) or env (user supplies creds as env vars)
  # credentials.overridable: true → Console shows a credentials selector; user's choice overrides the default
  credentials:
    default: cluster
    overridable: false

  qoveryVariables:
    - name: "region"
      source: "cluster.region"
      overridable: true

  userVariables:
    - name: "bucket_name"
      type: "string"
      required: true

  outputs:
    - name: "bucket_arn"
      sensitive: false
```

### ServiceBlueprint (Helm)

```yaml
apiVersion: "qovery.com/v2"
kind: ServiceBlueprint

metadata:
  name: "helm-redis"
  version: "1.0.0"
  categories: ["cache", "redis"]

spec:
  engine: helm

  chart:
    repository: "https://charts.bitnami.com/bitnami"
    name: "redis"
    version: "19.x"

  userVariables:
    - name: "replica_count"
      type: "number"
      default: "1"

  outputs:
    - name: "redis_host"
```

### StackBlueprint

Composes ServiceBlueprints from one or more catalog repos. Each service specifies its `url` (required). Users fill variables for every service in the Console before provisioning.

`sharedVariables` are declared once at the stack level and injected by q-core into every service that has a matching variable name — the user fills them once instead of once per service.

```yaml
apiVersion: "qovery.com/v2"
kind: StackBlueprint

metadata:
  name: "production-stack"
  version: "1.0.0"

spec:
  sharedVariables:
    - name: "aws_region"
      type: "string"
      required: true
      description: "AWS region for all services in this stack"

  stages:
    - name: "databases"
      description: "Provision databases and caches first"
      services:
        - blueprint: "aws-postgresql"
          url: "https://github.com/my-org/my-catalog.git"
          version: ">=1.0.0 <2.0.0"
          name: "main-db"
        - blueprint: "aws-redis"
          url: "https://github.com/Qovery/service-catalog.git"
          version: "1.x"
          name: "cache"
    - name: "applications"
      description: "Deploy application after databases are ready"
      services:
        - blueprint: "container-app"
          url: "https://github.com/Qovery/service-catalog.git"
          version: "1.0.0"
          name: "api"
```

## Contributing

1. Create a directory under `examples/{name}/`
2. Add `qbm.yml` + Terraform files or Helm values
3. Open a PR -- CI validates

### Releasing

```bash
git tag aws-s3/1.0.0
git push origin aws-s3/1.0.0
```
