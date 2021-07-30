FROM alpine:latest

WORKDIR /code

COPY . /code

ENTRYPOINT ["/code/run.sh"]

RUN apk update
RUN apk add unzip curl bash vim

RUN curl https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip -o terraform.zip
RUN unzip terraform.zip && rm terraform.zip
RUN mv terraform /usr/bin
