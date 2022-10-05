import os
import time

import psycopg2
from psycopg2.errors import UndefinedObject
from psycopg2.extras import LogicalReplicationConnection

my_connection  = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    dbname=os.getenv('POSTGRES_DB'),
    user=os.getenv('POSTGRES_USER'),
    password=os.getenv('POSTGRES_PASSWORD'),
    connection_factory = LogicalReplicationConnection
)

cur = my_connection.cursor()

try:
    cur.drop_replication_slot('wal2json_test_slot')
except UndefinedObject:
    pass

cur.create_replication_slot(
    'wal2json_test_slot',
    output_plugin = 'wal2json'
)
cur.start_replication(
    slot_name = 'wal2json_test_slot',
    options = {
        'pretty-print' : 4,
        'filter-tables' : 'public.booksdb'
    },
    decode= True
)

def consume(msg):
    print("msg: ", msg.payload)

cur.consume_stream(consume)
