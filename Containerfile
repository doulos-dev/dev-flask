FROM python:3.14-slim

RUN apt-get update && apt-get install -y gcc git curl locales \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN useradd -ms /bin/bash devuser
USER devuser
WORKDIR /home/devuser/app

COPY --chown=devuser:devuser app/ .
RUN pip install --user -r requirements.txt

EXPOSE 8000
CMD ["python", "-m", "flask", "--app", "main", "run", "--host=0.0.0.0", "--port=8000"]
