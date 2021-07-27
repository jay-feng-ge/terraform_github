FROM hashicorp/terraform:latest

WORKDIR /code

COPY . /code

ENTRYPOINT ["/code/run.sh"]
