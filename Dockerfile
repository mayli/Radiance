from alpine:3.20

run apk --no-cache add alpine-sdk autoconf automake boost-dev libcap-dev libev-dev mariadb-dev mysql-client && \
	wget -O- https://tangentsoft.com/mysqlpp/releases/mysql++-3.3.0.tar.gz | tar zxf - && \
	(cd mysql++-3.3.0 && ./configure && make -j8 && make install)

workdir /src
copy . /src
run ./configure --prefix=/srv && make -j7 && make install

# run apk del alpine-sdk autoconf automake boost-dev

workdir /srv
copy ./install/radiance.conf /srv
ENTRYPOINT /srv/sbin/radiance
