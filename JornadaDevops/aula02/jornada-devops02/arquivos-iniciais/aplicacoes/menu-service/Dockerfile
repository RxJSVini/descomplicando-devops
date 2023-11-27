FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
COPY app/ .
RUN pip install -U pip && pip install -r requirements.txt

EXPOSE 8089

ENTRYPOINT [ "unicorn" ]

CMD ["app.main:app", "--host", "0.0.0.0", "--port", "8089"]