-- Database: waveform3

-- DROP DATABASE waveform3;

CREATE DATABASE waveform3
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;

COMMENT ON DATABASE waveform3
  IS 'This database will contain all of the information required to connect to and execute 3rd party web services which contain "time series analysis algorithms". 

It may also contain information about one or more optional parameters for each webservice, so that an accurate user interface can be generated for setting these parameters.

 It may also contain optional items like version number, license type, copywrites and contact information, which are not critical to running the web service, but may be important from a licensing perspective.

------

It has now had the previous Waveform tables added, which had previously been in the lportal database:
analysisjob, annotationinfo, coordinate, documentrecord, filesinfo, & uploadstatus.';