FROM python:3.9.5
COPY . /task_queue
WORKDIR /task_queue
RUN pip install -r requirements.txt