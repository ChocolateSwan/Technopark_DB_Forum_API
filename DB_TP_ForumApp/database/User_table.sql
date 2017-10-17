﻿CREATE TABLE "User"
(
  id SERIAL PRIMARY KEY NOT NULL,
  about TEXT,
  email CITEXT COLLATE pg_catalog.ucs_basic NOT NULL CONSTRAINT User_email_unique UNIQUE,
  fullname VARCHAR(100) NOT NULL,
  nickname CITEXT COLLATE pg_catalog.ucs_basic NOT NULL CONSTRAINT User_nickname_unique UNIQUE
);