FROM libreoffice/online:master

ENV LC_CTYPE=en_US.UTF-8

RUN ln -s /etc/tls/tls.crt /etc/loolwsd/cert.pem
RUN ln -s /etc/tls/tls.key /etc/loolwsd/key.pem
RUN ln -s /run/secrets/kubernetes.io/serviceaccount/service-ca.crt /etc/loolwsd/ca-chain.cert.pem
RUN rm /etc/loolwsd/loolwsd.xml
RUN ln -s /etc/config/loolwsd.xml /etc/loolwsd/loolwsd.xml
RUN setcap -r /usr/bin/loolforkit

CMD /usr/bin/loolwsd --version --o:sys_template_path=/opt/lool/systemplate --o:lo_template_path=/opt/libreoffice --o:child_root_path=/opt/lool/child-roots --o:file_server_root_path=/usr/share/loolwsd
