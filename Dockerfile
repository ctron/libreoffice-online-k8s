FROM libreoffice/online:master

ENV LC_CTYPE=en_US.UTF-8

RUN ln -s /etc/tls/tls.crt /etc/loolwsd/cert.pem
RUN ln -s /etc/tls/tls.key /etc/loolwsd/key.pem
RUN ln -s /run/secrets/kubernetes.io/serviceaccount/service-ca.crt /etc/loolwsd/ca-chain.cert.pem
RUN rm /etc/loolwsd/loolwsd.xml
RUN ln -s /etc/config/loolwsd.xml /etc/loolwsd/loolwsd.xml
RUN setcap -r /usr/bin/loolforkit

RUN chmod g=u /etc/passwd
COPY uid_entrypoint /uid_entrypoint
RUN chmod a+x /uid_entrypoint
ENTRYPOINT [ "uid_entrypoint" ]
USER 1001

