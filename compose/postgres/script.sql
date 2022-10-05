CREATE TABLE booksdb(
  id SERIAL PRIMARY KEY,
  title VARCHAR(32), firstname VARCHAR(32), 
  lastname VARCHAR(32), publisher VARCHAR(64)
);

BEGIN;

SELECT 'init' FROM pg_create_logical_replication_slot(
  'test_slot', 'wal2json'
);

INSERT INTO booksdb(title, firstname, lastname, publisher) VALUES(
  'Learning Python 5th Edition', 'Mark', 'Lutz', 'Orielly'
);

INSERT INTO booksdb(title, firstname, lastname, publisher) VALUES(
  'Mastering Elastic Stack', 'Yuvraj', 'Gupta', 'Packt'
);

INSERT INTO booksdb(title, firstname, lastname, publisher) VALUES(
  'Head First Python', 'Paul', 'Barry', 'Orielly'
);

UPDATE booksdb SET firstname = 'Robert' WHERE lastname = 'Barry';

DELETE FROM booksdb WHERE publisher = 'Packt';

COMMIT;

SELECT data FROM pg_logical_slot_get_changes(
  'test_slot', NULL, NULL, 'pretty-print', '1', 
  'add-msg-prefixes', 'wal2json'
);

SELECT 'stop' FROM pg_drop_replication_slot('test_slot');

DROP TABLE booksdb;
