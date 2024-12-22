# The version of the image that will be used. Alpine is the most stript-out version 
FROM python:3.9-alpine3.13

# Who is the manteiner of the app
LABEL manteiner="me@giacomobellomo.it"

# Recommanded if running Python in a Docker container. The Python output will be printed directly to the console
# helping with any possible delay form the python running application to the screen 
ENV PYTHONUNBUFFERED 1 

# Copy the "requirements.txt" file from the machine to "/tmp/requirements.txt". Then use it to install the requirements
# for the Python environment. Then copy the "app" directory that will contain the Django app inside the container.
# "Workdir" is the standard working directory from where the commands will be run from. Next the port will be exposed to the machine 
# allowing us to access the port from the container image.
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# We run the "run" command on the alpine image that we are building.
ARG DEV=false
RUN python -m venv /py && \ 
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip  install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user 
 
# The ENV line updates the environment variable inside the image
ENV PATH="/py/bin:$PATH"

USER django-user
    

