ARG version="3.6-alpine"
FROM python
LABEL maintainer="Adrien CHHIMI"

WORKDIR /opt
RUN apt-get update \
    && apt-get install --no-install-recommends -y git \
    && git clone https://github.com/sadofrazer/ic-webapp.git /opt/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf jenkins-tools releases.txt README.md *.pdf \
    && pip3 install flask

    ENV ODOO_URL="odoo.com"
    ENV PGADMIN_URL="pgadmin.org"

    EXPOSE 8080
    ENTRYPOINT ["python" , "app.py"]