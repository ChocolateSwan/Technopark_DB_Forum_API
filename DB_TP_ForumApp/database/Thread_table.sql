﻿CREATE TABLE Thread
(
    id SERIAL PRIMARY KEY NOT NULL,
	author_id INT NOT NULL,
    created TIMESTAMP WITH TIME ZONE DEFAULT now(),
    forum_id INT NOT NULL,
	message TEXT NOT NULL,
	slug CITEXT COLLATE pg_catalog.ucs_basic ,
    title VARCHAR(200) NOT NULL,
   votes INT DEFAULT 0,
 
      CONSTRAINT Thread_Forum_id_fk FOREIGN KEY (forum_id)
      REFERENCES public."Forum" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT Thread_User_id_fk FOREIGN KEY (author_id)
      REFERENCES public."User" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
      CONSTRAINT thread_slug_unique UNIQUE (slug)
);
