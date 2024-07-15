FROM centos:7

RUN yum update -y && yum install -y epel-release python3 python3-pip
WORKDIR /python_api
COPY python-api.py /python_api/
COPY requirements.txt /python_api/

RUN pip3 install --no-cache-dir -r /python_api/requirements.txt

EXPOSE 5000

CMD ["python3", "python-api.py"]