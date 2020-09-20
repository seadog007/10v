create extension if not exists pg_trgm;

create table if not exists users (
  key serial primary key,
  username text not null unique constraint users_username_len check (char_length(username) <= 100),
  password text constraint users_password_len check (char_length(password) <= 100),
  method text,
  verified jsonb,
  displayname text, constraint users_displayname_length check (char_length(displayname) <= 64),
  description text, constraint users_description_length check (char_length(description) <= 1024),
  title text, constraint  users_title_length check (char_length(title) <= 100),
  tags text, constraint users_tags_length check (char_length(tags) <= 256),
  createdtime timestamp,
  modifiedtime timestamp,
  lastactive timestamp,
  detail jsonb,
  plan jsonb,
  config jsonb,
  staff int,
  deleted boolean
);

create index if not exists idx_user_displayname on users (lower(displayname) varchar_pattern_ops);

create table if not exists sessions (
  key text not null unique primary key,
  detail jsonb
);