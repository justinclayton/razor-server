FROM jboss/torquebox

RUN  yum -y install postgresql libarchive-devel

ADD  start.sh /

ENV  HOSTNAME       razor-server
ENV  TORQUEBOX_HOME /opt/torquebox-3.1.1
ENV  JBOSS_HOME     $TORQUEBOX_HOME/jboss
ENV  JRUBY_HOME     $TORQUEBOX_HOME/jruby
ENV  PATH           $JRUBY_HOME/bin:$PATH

VOLUME /var/lib/razor/repo-store

EXPOSE 8080

CMD /start.sh
