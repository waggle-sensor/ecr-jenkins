# buildkit is used as a convinient source to install all builtkit related tools
FROM moby/buildkit:v0.11.2 as buildkit

FROM jenkins/jenkins:lts-jdk11

# escalate privileges to install additional system tools
USER root

# install additional system utils
RUN apt-get update && apt-get install -y jq curl file

# copy all buildkit tools into jenkins image
COPY --from=buildkit /usr/bin/buildkit* /usr/bin/buildctl* /usr/bin/

# deescalate privileges back to jenkins user
USER jenkins

# install additional jenkins plugins
RUN jenkins-plugin-cli \
    --plugins \
    build-timeout \
    timestamper \
    workflow-aggregator \
    github-branch-source \
    pipeline-stage-view \
    git \
    ssh-slaves \
    email-ext \
    mailer \
    configuration-as-code \
    configuration-as-code-groovy \
    ws-cleanup \
    credentials-binding                 # required for ecr-registry credentials
