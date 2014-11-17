--
-- PostgreSQL
-- Drops all Algorithm related tables
-- June 17, 2014 2:30pm
-- Written by Michael Shipway

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

DROP TABLE algorithm CASCADE;
DROP TABLE algorithmreference CASCADE;
DROP TABLE algorithmperson CASCADE;
DROP TABLE organization CASCADE;
DROP TABLE "organizationContact" CASCADE;
DROP TABLE parameter CASCADE;
DROP TABLE "parameterOption" CASCADE;
DROP TABLE "parameterType" CASCADE;
DROP TABLE "parameterValidator" CASCADE;
DROP TABLE person CASCADE;
DROP TABLE service CASCADE;
--
--
