FROM ctfd/ctfd:3.5.1
RUN pip3 install pika requests
ENTRYPOINT /opt/CTFd/docker-entrypoint.sh
