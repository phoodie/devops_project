FROM alpine
MAINTAINER phoodie <email.com>

# Download terraform
RUN wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.3.5/terraform_1.3.5_linux_amd64.zip
RUN apk add --no-cache ca-certificates curl
# unzip terraform to root directory
RUN unzip /tmp/terraform.zip -d /

#COPY *.tf /
# to avoid users from executing as root
#USER nobody

#Command to run upon launch
ENTRYPOINT ["/terraform"]
