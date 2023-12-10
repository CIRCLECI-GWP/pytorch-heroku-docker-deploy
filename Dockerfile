FROM python:3.8-slim
ARG port

USER root

WORKDIR /opt/app-root/

ENV PORT=$port

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
    && apt-get -y install curl \
    && apt-get install libgomp1

COPY requirements.txt /opt/app-root/

RUN chgrp -R 0 /opt/app-root/ \
    && chmod -R g=u /opt/app-root/ \
    && pip install pip --upgrade \
    && pip install -r requirements.txt --no-cache-dir

COPY . /opt/app-root/

EXPOSE $PORT

CMD gunicorn app:app --bind 0.0.0.0:$PORT --preload