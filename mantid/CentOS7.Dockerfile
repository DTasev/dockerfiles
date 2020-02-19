FROM centos:7

ADD isis-rhel-testing.repo /etc/yum.repos.d/isis-rhel-testing.repo

# yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \

RUN su -c 'rpm -Uvh https://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
RUN subscription-manager repo-override --repo=rhel-7-workstation-optional-rpms --add=enabled:1
RUN yum install --enablerepo=isis-rhel-testing mantidnightly && \
    rm -rf /tmp/*

