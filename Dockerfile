FROM debian:jessie
ENV VERSION 2.0.38
MAINTAINER porchn <pichai.chin@gmail.com>

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
		ca-certificates \
		curl \
		btrfs-tools \
		apt-utils \
		sqlite3 \
		libcrypto++9 \
		libcurl3 \
		libfuse2 \
	--no-install-recommends
RUN rm -r /var/lib/apt/lists/*

ADD https://www.urbackup.org/downloads/Server/${VERSION}/debian/stable/urbackup-server_${VERSION}_amd64.deb /root/urbackup-server_amd64.deb
RUN echo /var/urbackup | dpkg -i /root/urbackup-server_amd64.deb

#RUN apt install -f

EXPOSE 55413
EXPOSE 55414
EXPOSE 55415
EXPOSE 35623

VOLUME [ "/var/urbackup", "/var/log", "/usr/share/urbackup" ]
ENTRYPOINT ["/usr/sbin/urbackupsrv"]
CMD ["run"]