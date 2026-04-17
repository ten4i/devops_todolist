ARG PYTHON_VERSION=3.11

#build stage
FROM python:${PYTHON_VERSION}-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

#run stage 
FROM python:${PYTHON_VERSION}-slim
WORKDIR /app
ENV PYTHONUNBUFFERED=1
EXPOSE 8080
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY . .
RUN python manage.py migrate
CMD [ "python" , "manage.py", "runserver", "0.0.0.0:8080"] 
