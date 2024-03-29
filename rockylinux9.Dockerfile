FROM rockylinux/rockylinux:9-ubi
ENV container docker

# systemd
# https://github.com/docker-library/docs/tree/master/centos
# https://github.com/rocky-linux/sig-cloud-instance-images/issues/39
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]

RUN yum -y update \
    && yum -y install sudo which python3 python3-pip python3-setuptools \
        epel-release \
    && yum clean all

RUN pip3 install --no-cache-dir --upgrade pip

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

CMD ["/usr/sbin/init"]
