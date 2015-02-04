;
-- In the future, an actual solution needs to be found for the above line
-- It is a temporary workaround to get this script to work on the psql command line
DROP SEQUENCE analyzejob_sequence;
DROP SEQUENCE uploadstatus_sequence;
DROP SEQUENCE documentrecord_sequence;
DROP SEQUENCE coordinate_sequence;
DROP SEQUENCE annotationinfo_sequence;

DROP INDEX uploadstatus_pkey;
DROP TABLE uploadstatus;

DROP INDEX ix_annotationinfo_3;
DROP INDEX ix_annotationinfo_2;
DROP INDEX ix_annotationinfo_1;
DROP INDEX annotationinfo_pkey;
DROP TABLE annotationinfo;

DROP INDEX coordinate_pkey;
DROP TABLE coordinate;

DROP INDEX ix_filesinfo_1;
DROP INDEX filesinfo_pkey;
DROP TABLE filesinfo;

DROP INDEX analysisjob__pkey;
DROP TABLE analysisjob;

DROP INDEX ix_documentrecord_5;
DROP INDEX ix_documentrecord_4;
DROP INDEX ix_documentrecord_3;
DROP INDEX ix_documentrecord_2;
DROP INDEX ix_documentrecord_1;
DROP INDEX documentrecord_pkey;
DROP TABLE documentrecord;

-- Table: documentrecord
CREATE TABLE documentrecord
(
  documentrecordid bigint NOT NULL,
  recordname character varying(75),
  userid bigint,
  subjectid character varying(75),
  originalformat integer,
  samplingrate double precision,
  filetreepath character varying(75),
  leadcount integer,
  numberofpoints integer,
  dateofupload timestamp without time zone,
  age integer,
  gender character varying(75),
  dateofrecording timestamp without time zone,
  adugain double precision,
  CONSTRAINT documentrecord_pk PRIMARY KEY (documentrecordid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE documentrecord
  OWNER TO liferay;

-- Index: documentrecord_pkey
CREATE UNIQUE INDEX documentrecord_pkey ON documentrecord USING btree (documentrecordid);

-- Index: ix_documentrecord_1
CREATE INDEX ix_documentrecord_1 ON documentrecord USING btree (recordname, userid, subjectid , filetreepath );

-- Index: ix_documentrecord_2
CREATE INDEX ix_documentrecord_2 ON documentrecord USING btree (userid);

-- Index: ix_documentrecord_3
CREATE INDEX ix_documentrecord_3 ON documentrecord USING btree (documentrecordid);

-- Index: ix_documentrecord_4
CREATE INDEX ix_documentrecord_4 ON documentrecord USING btree (subjectid );

-- Index: ix_documentrecord_5
CREATE INDEX ix_documentrecord_5 ON documentrecord USING btree (originalformat);

-- Table: filesinfo

-- Table: analysisjob

CREATE TABLE analysisjob
(
  analysisjobid bigint NOT NULL,
  filecount integer NOT NULL,
  documentrecordid bigint NOT NULL,
  parametercount integer NOT NULL,
  serviceurl character varying(75) NOT NULL,
  servicename character varying(50) NOT NULL,
  servicemethod character varying(50) NOT NULL,
  userid bigint NOT NULL,
  dateofanalysis timestamp without time zone NOT NULL,
  analysistime bigint,
  message character varying(300),
  CONSTRAINT analysisjob_pk PRIMARY KEY (analysisjobid),
  CONSTRAINT documentrecord_analysisjob_fk FOREIGN KEY (documentrecordid)
      REFERENCES documentrecord (documentrecordid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE analysisjob
  OWNER TO liferay;

-- Index: analysisjob__pkey
CREATE UNIQUE INDEX analysisjob__pkey ON analysisjob USING btree (analysisjobid);
ALTER TABLE analysisjob CLUSTER ON analysisjob__pkey;

CREATE TABLE filesinfo
(
  fileid bigint NOT NULL,
  documentrecordid bigint NOT NULL,
  analysisjobid bigint,
  CONSTRAINT filesinfo_pk PRIMARY KEY (fileid),
  CONSTRAINT analysisjob_filesinfo_fk FOREIGN KEY (analysisjobid)
      REFERENCES analysisjob (analysisjobid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT documentrecord_fk FOREIGN KEY (documentrecordid)
      REFERENCES documentrecord (documentrecordid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE filesinfo OWNER TO liferay;

-- Index: filesinfo_pkey
CREATE UNIQUE INDEX filesinfo_pkey ON filesinfo USING btree (fileid);

-- Index: ix_filesinfo_1
CREATE INDEX ix_filesinfo_1 ON filesinfo USING btree (documentrecordid);


-- Table: coordinate

CREATE TABLE coordinate
(
  coordinateid bigint NOT NULL,
  xcoordinate double precision,
  ycoordinate double precision,
  CONSTRAINT coordinate_pk PRIMARY KEY (coordinateid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE coordinate OWNER TO liferay;

-- Index: coordinate_pkey
CREATE UNIQUE INDEX coordinate_pkey ON coordinate USING btree (coordinateid);	

-- Table: annotationinfo

CREATE TABLE annotationinfo
(
  annotationid bigint NOT NULL,
  createdby character varying(75),
  annotationtype character varying(75),
  name character varying(75),
  bioportalreferencelink character varying(200),
  bioportalclassid character varying(200),
  bioportalontology character varying(50),
  leadindex integer,
  startingcoordinateid bigint,
  endingcoordinateid bigint,
  unitofmeasurement character varying(75),
  description text,
  value text,
  documentrecordid bigint,
  "timestamp" timestamp without time zone,
  analysisjobid bigint,
  CONSTRAINT annotation_pk PRIMARY KEY (annotationid),
  CONSTRAINT analysisjob_annotationinfo FOREIGN KEY (analysisjobid)
      REFERENCES analysisjob (analysisjobid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT documentrecord_annotationinfo_fk FOREIGN KEY (documentrecordid)
      REFERENCES documentrecord (documentrecordid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT endcoordinate_annotationinfo_fk FOREIGN KEY (endingcoordinateid)
      REFERENCES coordinate (coordinateid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT startcoordinate_fk FOREIGN KEY (startingcoordinateid)
      REFERENCES coordinate (coordinateid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)WITH (
  OIDS=FALSE
);
ALTER TABLE annotationinfo OWNER TO liferay;

-- Index: annotationinfo_pkey
CREATE UNIQUE INDEX annotationinfo_pkey ON annotationinfo USING btree (annotationid);

-- Index: ix_annotationinfo_1
CREATE INDEX ix_annotationinfo_1 ON annotationinfo USING btree (documentrecordid, name , annotationtype , leadindex);

-- Index: ix_annotationinfo_2
CREATE INDEX ix_annotationinfo_2 ON annotationinfo USING btree (documentrecordid);

-- Index: ix_annotationinfo_3
CREATE INDEX ix_annotationinfo_3 ON annotationinfo USING btree (annotationtype, documentrecordid);

-- Table: uploadstatus

CREATE TABLE uploadstatus
(
  documentrecordid bigint NOT NULL,
  validationtime bigint,
  transferreadtime bigint,
  writetime bigint,
  annotationtime bigint,
  status boolean,
  message character varying(300),
  CONSTRAINT uploadstatus_pk PRIMARY KEY (documentrecordid),
  CONSTRAINT documentrecord_uploadstatus_fk FOREIGN KEY (documentrecordid)
      REFERENCES documentrecord (documentrecordid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE uploadstatus
  OWNER TO liferay;

-- Index: uploadstatus_pkey
CREATE UNIQUE INDEX uploadstatus_pkey ON uploadstatus USING btree (documentrecordid);

-- Sequence: annotationinfo_sequence

CREATE SEQUENCE annotationinfo_sequence
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 28646
  CACHE 1;
ALTER TABLE annotationinfo_sequence
  OWNER TO liferay;
  
-- Sequence: coordinate_sequence

CREATE SEQUENCE coordinate_sequence
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 61353
  CACHE 1;
ALTER TABLE coordinate_sequence
  OWNER TO liferay;
  
-- Sequence: documentrecord_sequence

CREATE SEQUENCE documentrecord_sequence
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1966
  CACHE 1;
ALTER TABLE documentrecord_sequence
  OWNER TO liferay;

-- Sequence: analyzejob_sequence

  CREATE SEQUENCE analyzejob_sequence
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE analyzejob_sequence
  OWNER TO liferay;