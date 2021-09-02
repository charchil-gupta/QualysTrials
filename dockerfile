# Container image that runs your code
FROM python:3-alpine

COPY Qualys_IaC_Security-1.4.0-py3-none-any.whl /Qualys_IaC_Security-1.4.0-py3-none-any.whl
COPY entrypoint.sh /entrypoint.sh
COPY resultParser.py /resultParser.py

RUN pip3 install --upgrade pip
RUN pip3 install click requests prettytable click_option_group
RUN pip3 install Qualys_IaC_Security-1.4.0-py3-none-any.whl

RUN ["chmod", "+x", "/entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sh","/entrypoint.sh"]
