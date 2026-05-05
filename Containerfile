FROM python:3.14-slim

RUN apt-get update && apt-get install -y gcc git curl && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash devuser
USER devuser
WORKDIR /home/devuser/app

COPY --chown=devuser:devuser app/ .
RUN pip install --user -r requirements.txt

EXPOSE 8000
CMD ["python", "-m", "flask", "--app", "main", "run", "--host=0.0.0.0", "--port=8000"]
