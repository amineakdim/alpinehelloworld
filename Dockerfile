#Grab the latest alpine image
FROM alpine:latest

# Installez les dépendances système nécessaires
RUN apk add --no-cache python3 py3-pip bash

# Ajoutez votre code
ADD ./webapp /app
WORKDIR /app

# Créez un environnement virtuel et activez-le
RUN python3 -m venv venv
RUN source venv/bin/activate

# Installez les dépendances Python à partir du fichier requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

# Désactivez l'environnement virtuel
RUN deactivate

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:$PORT wsgi 

