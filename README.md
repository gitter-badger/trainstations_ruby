
CREATE DATABASE trainstations;
\c trainstations;

CREATE TABLE train (id serial PRIMARY KEY, route varchar);


CREATE TABLE city (id serial PRIMARY KEY, name varchar);

CREATE TABLE train_city (id SERIAL PRIMARY KEY, train_id int, city_id int, stop_time time);

\c Guest

CREATE DATABASE trainstations_test WITH TEMPLATE trainstations;
