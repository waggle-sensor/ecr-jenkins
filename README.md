# ECR Jenkins

This repo contains a Dockerfile and automation to build our ECR Jenkins Docker image.

This image adds some additional tools and plugins to the base Jenkins image to support our ECR CI pipeline.

## Deployment Notes

In order to deploy this in an automated way, you'll need to provide a CASC (Jenkins Configuration as Code) config file and disable the setup wizard.

### CASC Config

First, you'll need to write a CASC yaml file such as:

```yaml
jenkins:
  systemMessage: "Jenkins configured automatically by Jenkins Configuration as Code plugin\n\n"

  securityRealm:
    local:
      allowsSignup: false
      users:
        - id: "builder"
          password: "builder's secret password"
...
```

Then, ensure the env var `CASC_JENKINS_CONFIG=/path/to/casc_file.yaml` and you have mounted the CASC config file at that location.

### Disable Setup Wizard

To do this, you simply need to make sure `-Djenkins.install.runSetupWizard=false` is part of your `JAVA_OPTS` env var.
