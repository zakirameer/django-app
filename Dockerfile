FROM python:3.10-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip --root-user-action=ignore
COPY ./requirements.txt /usr/src/app
RUN pip install -r requirements.txt --root-user-action=ignore

# copy project
COPY . /usr/src/app

EXPOSE 8000

RUN python manage.py migrate
RUN python manage.py create_dummy_user

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
