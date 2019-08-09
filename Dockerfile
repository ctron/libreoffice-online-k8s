FROM libreoffice/online:master

ENV LC_CTYPE=en_US.UTF-8

RUN apt-get install -y curl wget
RUN ln -s /etc/tls/tls.crt /etc/loolwsd/cert.pem
RUN ln -s /etc/tls/tls.key /etc/loolwsd/key.pem
RUN ln -s /run/secrets/kubernetes.io/serviceaccount/service-ca.crt /etc/loolwsd/ca-chain.cert.pem
RUN chmod a+w /etc/loolwsd/loolwsd.xml
RUN chmod a+w /etc/loolwsd
RUN setcap -r /usr/bin/loolforkit

RUN chmod g=u /etc/passwd

COPY start /start
RUN chmod a+x /start
ENTRYPOINT [ "/start" ]

