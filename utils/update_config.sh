sed -i "s/#max_connections = 100/max_connections = 300/g" postgresql.conf && \
    sed -i "s/#shared_buffers = 32MB/shared_buffers = 256MB/g" postgresql.conf && \
    sed -i "s/#wal_level = replica/wal_level = replica/g" postgresql.conf && \
    sed -i "s/#archive_mode = off/archive_mode = on/g" postgresql.conf && \
    sed -i "s/#archive_command = ''/archive_command = '\/usr\/bin\/lz4 -q -z %p \/pgdata\/archive_wals\/%f.lz4'/g" postgresql.conf