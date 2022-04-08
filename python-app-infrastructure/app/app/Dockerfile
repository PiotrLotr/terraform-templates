ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}-alpine

WORKDIR /app
COPY . . 

RUN pip install -r requirements.txt
EXPOSE 80

CMD ["gunicorn", "-b 0.0.0.0:80", "main:app", "-t 120"]
