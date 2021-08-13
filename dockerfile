# Container image that runs your code
FROM python:3

RUN echo "1"
COPY Qualys_IaC_Security-1.3.2-py3-none-any.whl /Qualys_IaC_Security-1.3.2-py3-none-any.whl
RUN echo "11"
COPY entrypoint.sh /entrypoint.sh
RUN echo "111"

RUN pip3 install --upgrade pip
RUN echo "1111"
RUN pip3 install click requests prettytable click_option_group
RUN echo "11111"
RUN pip3 install Qualys_IaC_Security-1.3.2-py3-none-any.whl
RUN echo "111111"

RUN ["chmod", "+x", "/entrypoint.sh"]
RUN echo "1111111"

# Code file to execute when the docker container starts up (`entrypoint.sh`)
RUN echo "11111111"
ENTRYPOINT ["sh","/entrypoint.sh"]
