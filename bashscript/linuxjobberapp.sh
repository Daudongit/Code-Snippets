
yum -y install wget epel-release
yum -y install  https://centos7.iuscommunity.org/ius-release.rpm 
yum -y update
yum -y install python36u \
                python36u-pip \
                python36u-devel \
                uwsgi \
                # uwsgi-plugin-python36u-2.0.14-1.ius.centos7.x86_64.rpm \
                # uwsgi-logger-file \
                python-pip \
                mysql-devel \
                git
yum groupinstall "Development Tools"