ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}-alpine

WORKDIR /app
COPY . . 

RUN pip install -r requirements.txt
EXPOSE 8000

CMD ["gunicorn", "-b 0.0.0.0:8000", "main:app"]
