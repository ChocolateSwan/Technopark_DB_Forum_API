﻿CREATE TABLE "Forum"
(
    id SERIAL PRIMARY KEY NOT NULL,
    posts INT NOT NULL DEFAULT 0,
    slug CITEXT COLLATE pg_catalog.ucs_basic NOT NULL CONSTRAINT Forum_slug_unique UNIQUE,
    threads INT NOT NULL DEFAULT 0,
    title VARCHAR(100) NOT NULL,
    user_id INT NOT NULL,
   
  CONSTRAINT Forum_user_id_fk FOREIGN KEY (user_id)
   REFERENCES public."User" (id) MATCH SIMPLE
   ON UPDATE NO ACTION ON DELETE NO ACTION
    
);
