#Grab the latest alpine image
FROM alpine:latest

# Install python and pip
RUN apk add --no-cache --update python3 py3-pip bash
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Créer et activer l'environnement virtuel
RUN python3 -m venv /venv
RUN source /venv/bin/activate

# Install dependencies inside virtual environnment
RUN /venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Expose is NOT supported by Heroku
# EXPOSE 5000 		

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD ["/venv/bin/gunicorn", "--bind", "0.0.0.0:$PORT", "wsgi"]
