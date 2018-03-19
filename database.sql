---Tables
CREATE TABLE users(
  id SERIAL NOT NULL,
  email text NOT NULL UNIQUE,
  password text NOT NULL,
  name text,
  photo text,
  adress text,
  country text,
  contact NUMERIC(17,14),
  type text NOT NULL
);

CREATE TABLE admin(
  id SERIAL NOT NULL,
  id_user INTEGER NOT NULL
);

CREATE TABLE bid(
  id SERIAL NOT NULL,
  status BOOLEAN NOT NULL,
  price FLOAT,
  id_auction INTEGER NOT NULL,
  id_user INTEGER NOT NULL
);

CREATE TABLE auction (
  id integer NOT NULL,
  date  TIMESTAMP WITH TIME zone DEFAULT now() NOT NULL,
  name text NOT NULL,
  description text,
  buynow double precision NOT NULL,
  active boolean NOT NULL
);


CREATE TABLE comment(
  "like" INTEGER,
  dislike INTEGER,
  "date" TIMESTAMP WITH TIME zone DEFAULT now() NOT NULL,
  comment text NOT NULL,
  id_user INTEGER NOT NULL,
  id_auction INTEGER NOT NULL
);

CREATE TABLE reportUser(
  id SERIAL NOT NULL,
  reason text NOT NULL,
  id_user INTEGER NOT NULL,
  id_admin INTEGER NOT NULL
);

CREATE TABLE reportAuction(
  id_user INTEGER NOT NULL,
  id_auction INTEGER NOT NULL
);

CREATE TABLE banUser(
  id_user INTEGER NOT NULL,
  isBanned BOOLEAN NOT NULL
);

CREATE TABLE banAuction(
  id_user INTEGER NOT NULL,
  id_auction INTEGER NOT NULL,
  isBanned BOOLEAN NOT NULL
);

CREATE TABLE "owner"(
  id_user INTEGER NOT NULL,
  id_auction INTEGER NOT NULL
);

CREATE TABLE wishList(
  id_user INTEGER NOT NULL,
  id_auction INTEGER NOT NULL,
  "date" TIMESTAMP WITH TIME zone DEFAULT now() NOT NULL,
  follow BOOLEAN NOT NULL
);

CREATE TABLE category(
    id_auction INTEGER NOT NULL,
    CATEGORY text NOT NULL,
    CONSTRAINT TYPE CHECK ((CATEGORY = ANY (ARRAY['Electronics'::text, 'Fashion'::text, 'Home & Garden'::text, 'Motors'::text, 'Music'::text, 
      'Toys'::text, 'Daily Deals'::text, 'Sporting'::text, 'Others'::text])))
);

CREATE TABLE buyNow (
    id_user integer NOT NULL,
    id_auction integer NOT NULL
);

-- Primary Keys and Uniques

ALTER TABLE ONLY users
  ADD CONSTRAINT user_pkey PRIMARY KEY (id);

ALTER TABLE ONLY admin
  ADD CONSTRAINT admin_pkey PRIMARY KEY (id,id_user);

ALTER TABLE ONLY auction
  ADD CONSTRAINT auction_pkey PRIMARY KEY (id);

ALTER TABLE ONLY bid
  ADD CONSTRAINT bid_pkey PRIMARY KEY (id);

ALTER TABLE ONLY comment
  ADD CONSTRAINT comment_pkey PRIMARY KEY (id_user, id_auction);

ALTER TABLE ONLY reportUser
  ADD CONSTRAINT reportUser_pkey PRIMARY KEY (id);

ALTER TABLE ONLY reportAuction
  ADD CONSTRAINT reportAuction_pkey PRIMARY KEY (id_user,id_auction);

ALTER TABLE ONLY banUser
  ADD CONSTRAINT banUser_pkey PRIMARY KEY (id_user);

ALTER TABLE ONLY banAuction
  ADD CONSTRAINT banAuction_pkey PRIMARY KEY (id_user,id_auction);

ALTER TABLE ONLY owner
  ADD CONSTRAINT owner_pkey PRIMARY KEY (id_user, id_auction);

ALTER TABLE ONLY wishList
  ADD CONSTRAINT wishList_pkey PRIMARY KEY (id_user, id_auction);

ALTER TABLE ONLY buyNow
    ADD CONSTRAINT buynow_pkey PRIMARY KEY (id_user, id_auction);

-- Foreign Keys

ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY banauction
    ADD CONSTRAINT banauction_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES auction(id);

ALTER TABLE ONLY banauction
    ADD CONSTRAINT banauction_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY banuser
    ADD CONSTRAINT banuser_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY bid
    ADD CONSTRAINT bid_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES auction(id);

ALTER TABLE ONLY bid
    ADD CONSTRAINT bid_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY category
    ADD CONSTRAINT category_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES auction(id);

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES auction(id);

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY owner
    ADD CONSTRAINT owner_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES auction(id);

ALTER TABLE ONLY owner
    ADD CONSTRAINT owner_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY reportauction
    ADD CONSTRAINT reportauction_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES auction(id);

ALTER TABLE ONLY reportauction
    ADD CONSTRAINT reportauction_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY reportuser
    ADD CONSTRAINT reportuser_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY reportuser
    ADD CONSTRAINT reportuser_id_admin_fkey FOREIGN KEY (id_admin) REFERENCES admin(id);

ALTER TABLE ONLY wishlist
    ADD CONSTRAINT wishlist_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES auction(id);

ALTER TABLE ONLY wishlist
    ADD CONSTRAINT wishlist_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);

ALTER TABLE ONLY buynow
    ADD CONSTRAINT buynow_id_auction_fkey FOREIGN KEY (id_auction) REFERENCES auction(id);

ALTER TABLE ONLY buynow
    ADD CONSTRAINT buynow_id_user_fkey FOREIGN KEY (id_user) REFERENCES users(id);