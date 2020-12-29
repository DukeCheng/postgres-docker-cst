FROM postgres:12.3

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		lz4 \
	; \
	rm -rf /var/lib/apt/lists/*

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone

RUN localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8
#ENV LANG zh_CN.utf8

RUN sed -i "s/#max_connections = 100/max_connections = 200/g" /usr/share/postgresql/12/postgresql.conf.sample && \
    sed -i "s/#shared_buffers = 32MB/shared_buffers = 512MB/g" /usr/share/postgresql/12/postgresql.conf.sample && \
    sed -i "s/#wal_level = replica/wal_level = replica/g" /usr/share/postgresql/12/postgresql.conf.sample && \
    sed -i "s/#archive_mode = off/archive_mode = off/g" /usr/share/postgresql/12/postgresql.conf.sample

# override PGDATA folder
ENV PGDATA /pgdata/data
# set WAL folder
# ENV POSTGRES_INITDB_WALDIR /pgdata/archive_wals

ARG BUILD_VERSION
ENV BUILD_VERSION ${BUILD_VERSION:-1.0.0}

ARG BUILD_DATE
ENV BUILD_DATE ${BUILD_DATE:-none}

# override PG VERSION STRING
ENV PG_VERSION $PG_VERSION;niusys/postgres-cst:$BUILD_VERSION;build date:$BUILD_DATE;

# set mount volume for postgres data folder
VOLUME /pgdata