FROM postgres:14-alpine

# Install dependencies
RUN apk add --no-cache build-base clang llvm git

# Get Wal2Json
RUN git clone https://github.com/eulerto/wal2json.git

# Install Wal2Json
RUN cd wal2json && make && make install

# Add custom config
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Add test file
COPY script.sql script.sql

# Start Postgres with custom config
CMD ["-c", "config_file=/etc/postgresql/postgresql.conf"]
