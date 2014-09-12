FROM tianon/centos:6.5

RUN  yum -y update

RUN  rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-10.noarch.rpm && \
     yum install -y puppet tar

ADD  razor-postgres-install.pp /
ADD  start.sh /

ENV  HOSTNAME       razor-server
ENV  TORQUEBOX_HOME /opt/razor-torquebox
ENV  JBOSS_HOME     $TORQUEBOX_HOME/jboss
ENV  JRUBY_HOME     $TORQUEBOX_HOME/jruby
ENV  PATH           $JRUBY_HOME/bin:$PATH

RUN  puppet module install puppetlabs/postgresql
RUN  puppet module install puppetlabs/razor
RUN  puppet apply -e 'include razor::torquebox'

# 69      TFTP
# 8080  Torquebox API
EXPOSE    8080
