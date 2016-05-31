--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.12
-- Dumped by pg_dump version 9.1.12
-- Started on 2014-04-25 13:06:51 EDT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2924 (class 1262 OID 36790)
-- Name: waveform3; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE waveform3 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE waveform3 OWNER TO postgres;

\connect waveform3

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2925 (class 1262 OID 36790)
-- Dependencies: 2924
-- Name: waveform3; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE waveform3 IS 'This database will contain all of the information required to connect to and execute 3rd party web services which contain "time series analysis algorithms". 

It may also contain information about one or more optional parameters for each webservice, so that an accurate user interface can be generated for setting these parameters.

 It may also contain optional items like version number, license type, copywrites and contact information, which are not critical to running the web service, but may be important from a licensing perspective.

------

It has now had the previous Waveform tables added, which had previously been in the lportal database:
analysisjob, annotationinfo, coordinate, documentrecord, filesinfo, & uploadstatus.';


--
-- TOC entry 192 (class 3079 OID 12506)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 192
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 36791)
-- Dependencies: 6
-- Name: algorithm; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE algorithm (
    serviceid integer,
    "uiName" character varying(30),
    "shortDescription" character varying(150),
    "completeDescription" character varying(5000),
    "serviceMethod" character varying(250),
    algorithmid integer NOT NULL
);


ALTER TABLE public.algorithm OWNER TO liferay;

--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 161
-- Name: TABLE algorithm; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE algorithm IS 'Data in this table describes a single analysis algorithm service method so that the User Interface code  can auto-generate an invocation interface which will support all the required and optional input parameters.
It also specifies the output files, so the result interface can be auto-generated. 

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm.serviceid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm.serviceid IS 'Foreign key to the "service" table, which will contain the URL and description meta-data for a single web service.  This web service may provide multiple algorithms, each as a method.';


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm."uiName" IS 'Human friendly name to be used by the UI when listing services. ';


--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm."shortDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm."shortDescription" IS 'Short summary description suitable for displaying as a tooltip. ';


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm."completeDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm."completeDescription" IS 'Complete description of the algorithm suitable for using in a manual/help file.  ';


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm."serviceMethod"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm."serviceMethod" IS 'Name of the method which executes the algorithm, within the above webservice. e.g. "sqrsWrapperType2".
';


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm.algorithmid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm.algorithmid IS 'Primary Key for Algorithms.';


--
-- TOC entry 162 (class 1259 OID 36797)
-- Dependencies: 6
-- Name: algorithmPerson; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE "algorithmPerson" (
    "algorithmID" integer,
    "personID" integer,
    "algorithmPersonID" integer NOT NULL
);


ALTER TABLE public."algorithmPerson" OWNER TO liferay;

--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 162
-- Name: TABLE "algorithmPerson"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE "algorithmPerson" IS 'Link table to cite every person who contributed to this algorithm web service, whom should to be credited.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN "algorithmPerson"."algorithmID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "algorithmPerson"."algorithmID" IS 'The algorithm that this person is affiliated with.';


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN "algorithmPerson"."personID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "algorithmPerson"."personID" IS 'The person affiliated with this algorithm.';


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN "algorithmPerson"."algorithmPersonID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "algorithmPerson"."algorithmPersonID" IS 'Primary Key for algorithmPerson table.';


--
-- TOC entry 163 (class 1259 OID 36800)
-- Dependencies: 6 161
-- Name: algorithm_algorithmid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE algorithm_algorithmid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.algorithm_algorithmid_seq OWNER TO liferay;

--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 163
-- Name: algorithm_algorithmid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE algorithm_algorithmid_seq OWNED BY algorithm.algorithmid;


--
-- TOC entry 164 (class 1259 OID 36802)
-- Dependencies: 162 6
-- Name: algorithmperson_algorithmpersonid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE algorithmperson_algorithmpersonid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.algorithmperson_algorithmpersonid_seq OWNER TO liferay;

--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 164
-- Name: algorithmperson_algorithmpersonid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE algorithmperson_algorithmpersonid_seq OWNED BY "algorithmPerson"."algorithmPersonID";


--
-- TOC entry 165 (class 1259 OID 36804)
-- Dependencies: 6
-- Name: analysisjob; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE analysisjob (
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
  	message character varying(300)
);


ALTER TABLE public.analysisjob OWNER TO liferay;

--
-- TOC entry 166 (class 1259 OID 36807)
-- Dependencies: 6
-- Name: analyzejob_sequence; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE analyzejob_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analyzejob_sequence OWNER TO liferay;

--
-- TOC entry 167 (class 1259 OID 36809)
-- Dependencies: 6
-- Name: annotationinfo; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE annotationinfo (
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
    userId bigint
);


ALTER TABLE public.annotationinfo OWNER TO liferay;

--
-- TOC entry 168 (class 1259 OID 36815)
-- Dependencies: 6
-- Name: annotationinfo_sequence; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE annotationinfo_sequence
    START WITH 28646
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotationinfo_sequence OWNER TO liferay;

--
-- TOC entry 169 (class 1259 OID 36817)
-- Dependencies: 6
-- Name: coordinate; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE coordinate (
    coordinateid bigint NOT NULL,
    xcoordinate double precision,
    ycoordinate double precision
);


ALTER TABLE public.coordinate OWNER TO liferay;

--
-- TOC entry 170 (class 1259 OID 36820)
-- Dependencies: 6
-- Name: coordinate_sequence; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE coordinate_sequence
    START WITH 61353
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coordinate_sequence OWNER TO liferay;

--
-- TOC entry 171 (class 1259 OID 36822)
-- Dependencies: 6
-- Name: documentrecord; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE documentrecord (
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
    leadNames character varying(100),
    deleteFlag boolean
);


ALTER TABLE public.documentrecord OWNER TO liferay;

--
-- TOC entry 172 (class 1259 OID 36825)
-- Dependencies: 6
-- Name: documentrecord_sequence; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE documentrecord_sequence
    START WITH 1966
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documentrecord_sequence OWNER TO liferay;

--
-- TOC entry 173 (class 1259 OID 36827)
-- Dependencies: 6
-- Name: filesinfo; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE filesinfo (
    fileid bigint NOT NULL,
    documentrecordid bigint NOT NULL,
    analysisjobid bigint
);


ALTER TABLE public.filesinfo OWNER TO liferay;

--
-- TOC entry 174 (class 1259 OID 36830)
-- Dependencies: 6
-- Name: organization; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE organization (
    "uiName" character varying(250),
    "organizationID" integer NOT NULL,
    "orgUrl" character varying(2000),
    phonenumber character varying(25)
);


ALTER TABLE public.organization OWNER TO liferay;

--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 174
-- Name: TABLE organization; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE organization IS 'Data about an organization.
An organization may be linked either to an algorithm, a service or a person.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN organization."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN organization."uiName" IS 'Name to be displays to users. ';


--
-- TOC entry 2944 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN organization."organizationID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN organization."organizationID" IS 'Primary Key for the organization table.';


--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN organization."orgUrl"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN organization."orgUrl" IS 'URL of the organization''s web page.';


--
-- TOC entry 2946 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN organization.phonenumber; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN organization.phonenumber IS 'Contact phone number for the organization.';


--
-- TOC entry 175 (class 1259 OID 36836)
-- Dependencies: 6
-- Name: organizationContact; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE "organizationContact" (
    "organizationContactID" integer NOT NULL,
    "organizationID" integer,
    "contactID" integer
);


ALTER TABLE public."organizationContact" OWNER TO liferay;

--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE "organizationContact"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE "organizationContact" IS 'Link table, connects "organization" entries with enteries in the "person" table to indicate who the contact person is for an organization.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN "organizationContact"."organizationContactID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "organizationContact"."organizationContactID" IS 'Primary Key for organizationContact link table.';


--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN "organizationContact"."organizationID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "organizationContact"."organizationID" IS 'Foreign Key of the organization.';


--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN "organizationContact"."contactID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "organizationContact"."contactID" IS 'Foreign Key of the person who is the organization''s Contact person.';


--
-- TOC entry 176 (class 1259 OID 36839)
-- Dependencies: 174 6
-- Name: organization_organizationid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE organization_organizationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_organizationid_seq OWNER TO liferay;

--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 176
-- Name: organization_organizationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE organization_organizationid_seq OWNED BY organization."organizationID";


--
-- TOC entry 177 (class 1259 OID 36841)
-- Dependencies: 6 175
-- Name: organizationcontact_organizationcontactid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE organizationcontact_organizationcontactid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizationcontact_organizationcontactid_seq OWNER TO liferay;

--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 177
-- Name: organizationcontact_organizationcontactid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE organizationcontact_organizationcontactid_seq OWNED BY "organizationContact"."organizationContactID";


--
-- TOC entry 178 (class 1259 OID 36843)
-- Dependencies: 2712 2713 6
-- Name: parameter; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE parameter (
    parameterid integer NOT NULL,
    algorithmid integer,
    "uiName" character varying(30),
    "shortDescription" character varying(150),
    "completeDescription" character varying(2000),
    flag character varying(30),
    "defaultValue" character varying(30),
    "parameterTypeid" integer,
    required boolean DEFAULT false,
    "multipleSelect" boolean DEFAULT false,
    "parameterValidationid" integer
);


ALTER TABLE public.parameter OWNER TO liferay;

--
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 178
-- Name: TABLE parameter; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE parameter IS 'Additional "useful" parameter to be passed to the algorithm if selected and entered by the user.
An example of “useful” parameter would be: “select 50hz noise filtering for European sourced data”.
An example of NOT “useful” would be: “Send results to the (non-existent) printer”.

@author mshipwa1@jhu.edu
March 10, 2014
';


--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter.parameterid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter.parameterid IS 'Primary Key for this parameter. ';


--
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter.algorithmid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter.algorithmid IS 'Foreign Key of the algorithm this parameter pertains to.';


--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."uiName" IS 'Human friendly name to be used by the UI when listing options.';


--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter."shortDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."shortDescription" IS 'Short summary description suitable for displaying as a tooltip. ';


--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter."completeDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."completeDescription" IS 'Complete description of the algorithm suitable for using in a manual/help file.  ';


--
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter.flag; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter.flag IS 'Identifying character(s) to be sent to the web service if this optional parameter is to be invoked.
It could be the underlying code''s command line flag which identifies a value that follows it,  e.g. "-r " preceeds the record-name.
Or it could be a short word, specified by the web service writer, e.g. "record".';


--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter."defaultValue"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."defaultValue" IS 'If the parameter equals this value, don''t pass the parameter data to the web service.
Also, this is the value which the algorithm will use if no parameter value is set by the user.';


--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter."parameterTypeid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."parameterTypeid" IS 'Foreign Key to indicate which data type the parameter should be.
Options will be:
   text, integer, float, boolean, select, data_column, or drill_down';


--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter.required; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter.required IS 'If true, this parameter must have a value.';


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter."multipleSelect"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."multipleSelect" IS 'If true, allow multiple selections in a dropdown list.
Only relevent for select or data_column parameter types.';


--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN parameter."parameterValidationid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."parameterValidationid" IS 'Foreign Key to the validation table entry related to this parameter.';


--
-- TOC entry 179 (class 1259 OID 36851)
-- Dependencies: 2715 6
-- Name: parameterOption; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE "parameterOption" (
    "uiText" character varying(30),
    "uiValue" character varying(30),
    "isInitialSelection" boolean DEFAULT false,
    "shortDescription" character varying(150),
    "completeDescription" character varying(500),
    parameteroptionid integer NOT NULL,
    "parentParameterID" integer
);


ALTER TABLE public."parameterOption" OWNER TO liferay;

--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE "parameterOption"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE "parameterOption" IS 'List of parameter options; only needed (or valid) when the parameter type is "select" or "drill_down" .
These options will be the items in a dropdown list or radio button control.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterOption"."uiText"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."uiText" IS 'Text for the UI to display in a drop down list, checkbox or radiobutton. ';


--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterOption"."uiValue"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."uiValue" IS 'Value to be sent to the web service if this option is selected.';


--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterOption"."isInitialSelection"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."isInitialSelection" IS 'If true this option the default for the parent parameter.';


--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterOption"."shortDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."shortDescription" IS 'Short summary description suitable for displaying as a tooltip.';


--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterOption"."completeDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."completeDescription" IS 'Complete description of the parameter’s option suitable for using in a manual/help file.  ';


--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterOption".parameteroptionid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption".parameteroptionid IS 'Primary Key for parameterOption table.';


--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterOption"."parentParameterID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."parentParameterID" IS 'Foreign Key of the parameter that this option pertains to. ';


--
-- TOC entry 180 (class 1259 OID 36858)
-- Dependencies: 6
-- Name: parameterType; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE "parameterType" (
    "parameterTypeid" integer NOT NULL,
    "uiName" character varying(30),
    "shortDescription" character varying(150)
);


ALTER TABLE public."parameterType" OWNER TO liferay;

--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 180
-- Name: TABLE "parameterType"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE "parameterType" IS 'Type of user input control which would best represent this parameter.
Modeled after Galaxy''s tool config XML as documented in the following web pages: http://wiki.g2.bx.psu.edu/Admin/Tools/Tool%20Config%20Syntax#Admin.2BAC8-Tools.2BAC8-Tool_Config_Syntax.A.3Cparam.3E_tag_set

 https://bitbucket.org/galaxy/galaxy-central/src/tip/lib/galaxy/tools/parameters/basic.py
□ text - can take on any text value.
□ integer – takes only an integer number value.
□ float – takes a real number value.
□ Boolean – true or false, e.g. a checkbox, true=checked. 
□ select - takes on one (or many) or a specific set of values. Requires a Parameter Option list below.
□ drill down - takes on one (or many) of a specific set of values. Creating a hierarchical select menu, which allows users to ''drill down'' a tree-like set of options. 

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN "parameterType"."parameterTypeid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterType"."parameterTypeid" IS 'Primary key of parameterType table.';


--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN "parameterType"."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterType"."uiName" IS 'Name of the parameter(control) type, suitable for displaying in the UI.';


--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN "parameterType"."shortDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterType"."shortDescription" IS 'Short description of the parameter type, suitable for a tooltip.';


--
-- TOC entry 190 (class 1259 OID 37057)
-- Dependencies: 6
-- Name: parameterValidator; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE "parameterValidator" (
    "validatorType" integer,
    message character varying(200),
    min numeric,
    max numeric,
    regex character varying(500),
    "parameterValidationid" integer NOT NULL
);


ALTER TABLE public."parameterValidator" OWNER TO liferay;

--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 190
-- Name: TABLE "parameterValidator"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE "parameterValidator" IS 'Contains user input validation information, is only applicable to text, integer, or float parameter types (types 1,2 or 3).
Can be of 3 types:
1 = regex - A javaScript regular expression which describes a valid entry for when type is "text". 
2 = in_range - Defines the minimum and maximum values that a numeric input (integer or float) can have.
3 = length -  Defines the minimum and maximum length that a text input can have.

Modeled after Galaxy''s tool config XML as documented in the following web pages: http://wiki.g2.bx.psu.edu/Admin/Tools/Tool%20Config%20Syntax#Admin.2BAC8-Tools.2BAC8-Tool_Config_Syntax.A.3Cparam.3E_tag_set

 https://bitbucket.org/galaxy/galaxy-central/src/tip/lib/galaxy/tools/parameters/basic.py
';


--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN "parameterValidator"."validatorType"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator"."validatorType" IS 'Can be of 3 types:
1 = regex - A javaScript regular expression which describes a valid entry for when type is "text". 
2 = in_range - Defines the minimum and maximum values that a numeric input (integer or float) can have.
3 = length -  Defines the minimum and maximum length that a text input can have.
';


--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN "parameterValidator".message; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator".message IS 'The message displayed if validation fails.';


--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN "parameterValidator".min; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator".min IS 'minimum parameter value; only valid when type is "integer" or "float"';


--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN "parameterValidator".max; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator".max IS 'maximum parameter value; only valid when type is "integer" or "float"';


--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN "parameterValidator".regex; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator".regex IS 'A JavaScript regular expression which describes a valid entry for when type is "text". ';


--
-- TOC entry 2983 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN "parameterValidator"."parameterValidationid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator"."parameterValidationid" IS 'Primary key of parameterValidation table.';


--
-- TOC entry 181 (class 1259 OID 36861)
-- Dependencies: 6 179
-- Name: parameteroption_parameteroptionid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE parameteroption_parameteroptionid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parameteroption_parameteroptionid_seq OWNER TO liferay;

--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 181
-- Name: parameteroption_parameteroptionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE parameteroption_parameteroptionid_seq OWNED BY "parameterOption".parameteroptionid;


--
-- TOC entry 182 (class 1259 OID 36863)
-- Dependencies: 6 178
-- Name: parameters_parameterid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE parameters_parameterid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parameters_parameterid_seq OWNER TO liferay;

--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 182
-- Name: parameters_parameterid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE parameters_parameterid_seq OWNED BY parameter.parameterid;


--
-- TOC entry 183 (class 1259 OID 36865)
-- Dependencies: 180 6
-- Name: parametertype_parametertypeid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE parametertype_parametertypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parametertype_parametertypeid_seq OWNER TO liferay;

--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 183
-- Name: parametertype_parametertypeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE parametertype_parametertypeid_seq OWNED BY "parameterType"."parameterTypeid";


--
-- TOC entry 191 (class 1259 OID 37065)
-- Dependencies: 6 190
-- Name: parametervalidator_parametervalidationid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE parametervalidator_parametervalidationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parametervalidator_parametervalidationid_seq OWNER TO liferay;

--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 191
-- Name: parametervalidator_parametervalidationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE parametervalidator_parametervalidationid_seq OWNED BY "parameterValidator"."parameterValidationid";


--
-- TOC entry 184 (class 1259 OID 36867)
-- Dependencies: 6
-- Name: person; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE person (
    firstname character varying(25),
    lastname character varying(25),
    middlename character varying(25),
    email character varying(100),
    phonenumber character varying(25),
    "personID" integer NOT NULL
);


ALTER TABLE public.person OWNER TO liferay;

--
-- TOC entry 2988 (class 0 OID 0)
-- Dependencies: 184
-- Name: TABLE person; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE person IS 'Affiliated people who should be credited. (Optional)
Include a entry in this table for every person who contributed to an algorithm web service, who should to be credited.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2989 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN person.email; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN person.email IS 'Contact email for this person.';


--
-- TOC entry 2990 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN person.phonenumber; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN person.phonenumber IS 'Contact phone number for this person.';


--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN person."personID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN person."personID" IS 'Unique ID for this person.';


--
-- TOC entry 185 (class 1259 OID 36870)
-- Dependencies: 6 184
-- Name: person_personid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE person_personid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_personid_seq OWNER TO liferay;

--
-- TOC entry 2992 (class 0 OID 0)
-- Dependencies: 185
-- Name: person_personid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE person_personid_seq OWNED BY person."personID";


--
-- TOC entry 186 (class 1259 OID 36872)
-- Dependencies: 6
-- Name: service; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE service (
    serviceid integer NOT NULL,
    "uiName" character varying(15),
    "wsName" character varying(250),
    "wsUrl" character varying(1000)
);


ALTER TABLE public.service OWNER TO liferay;

--
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 186
-- Name: TABLE service; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE service IS 'Contains the connection information and description for a web service which has analysis algorithm methods which conform to the CVRG Type2 algorithm specification.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN service.serviceid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN service.serviceid IS 'Primary key for the service table.';


--
-- TOC entry 2995 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN service."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN service."uiName" IS 'Human friendly name of the web service for displaying in the user interface.';


--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN service."wsName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN service."wsName" IS 'The web service’s name to be used in the URL when calling the service.   e.g. "physionetAnalysisService".  
';


--
-- TOC entry 2997 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN service."wsUrl"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN service."wsUrl" IS 'URL of the server containing the web services e.g. http://128.220.76.170:8080/axis2/services. 
This is used together with “service.wsName” and "algorithm.method”. e.g. http://128.220.76.170:8080/axis2/services/physionetAnalysisService/sqrsWrapperType2  
';


--
-- TOC entry 187 (class 1259 OID 36878)
-- Dependencies: 186 6
-- Name: service_serviceid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE service_serviceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.service_serviceid_seq OWNER TO liferay;

--
-- TOC entry 2998 (class 0 OID 0)
-- Dependencies: 187
-- Name: service_serviceid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE service_serviceid_seq OWNED BY service.serviceid;


--
-- TOC entry 188 (class 1259 OID 36880)
-- Dependencies: 6
-- Name: uploadstatus; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE uploadstatus (
    uploadstatusid bigint NOT NULL,
    recordname character varying(20),
    filetransfer character varying(75),
    fileconversion character varying(75),
    recordcreation character varying(75),
    annotationcreation character varying(75),
    documentrecordid bigint
);


ALTER TABLE public.uploadstatus OWNER TO liferay;

--
-- TOC entry 189 (class 1259 OID 36883)
-- Dependencies: 6
-- Name: uploadstatus_sequence; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE uploadstatus_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uploadstatus_sequence OWNER TO liferay;

--
-- TOC entry 2708 (class 2604 OID 36885)
-- Dependencies: 163 161
-- Name: algorithmid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithm ALTER COLUMN algorithmid SET DEFAULT nextval('algorithm_algorithmid_seq'::regclass);


--
-- TOC entry 2709 (class 2604 OID 36886)
-- Dependencies: 164 162
-- Name: algorithmPersonID; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "algorithmPerson" ALTER COLUMN "algorithmPersonID" SET DEFAULT nextval('algorithmperson_algorithmpersonid_seq'::regclass);


--
-- TOC entry 2710 (class 2604 OID 36887)
-- Dependencies: 176 174
-- Name: organizationID; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY organization ALTER COLUMN "organizationID" SET DEFAULT nextval('organization_organizationid_seq'::regclass);


--
-- TOC entry 2711 (class 2604 OID 36888)
-- Dependencies: 177 175
-- Name: organizationContactID; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "organizationContact" ALTER COLUMN "organizationContactID" SET DEFAULT nextval('organizationcontact_organizationcontactid_seq'::regclass);


--
-- TOC entry 2714 (class 2604 OID 36889)
-- Dependencies: 182 178
-- Name: parameterid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY parameter ALTER COLUMN parameterid SET DEFAULT nextval('parameters_parameterid_seq'::regclass);


--
-- TOC entry 2716 (class 2604 OID 36890)
-- Dependencies: 181 179
-- Name: parameteroptionid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "parameterOption" ALTER COLUMN parameteroptionid SET DEFAULT nextval('parameteroption_parameteroptionid_seq'::regclass);


--
-- TOC entry 2717 (class 2604 OID 36891)
-- Dependencies: 183 180
-- Name: parameterTypeid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "parameterType" ALTER COLUMN "parameterTypeid" SET DEFAULT nextval('parametertype_parametertypeid_seq'::regclass);


--
-- TOC entry 2720 (class 2604 OID 37067)
-- Dependencies: 191 190
-- Name: parameterValidationid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "parameterValidator" ALTER COLUMN "parameterValidationid" SET DEFAULT nextval('parametervalidator_parametervalidationid_seq'::regclass);


--
-- TOC entry 2718 (class 2604 OID 36892)
-- Dependencies: 185 184
-- Name: personID; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY person ALTER COLUMN "personID" SET DEFAULT nextval('person_personid_seq'::regclass);


--
-- TOC entry 2719 (class 2604 OID 36893)
-- Dependencies: 187 186
-- Name: serviceid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY service ALTER COLUMN serviceid SET DEFAULT nextval('service_serviceid_seq'::regclass);

CREATE TABLE virtualnode(
  nodeid bigint NOT NULL,
  nodename character varying(50),
  externalreference character varying(50),
  userid bigint,
  parentnodeid bigint,
  CONSTRAINT "virtualNode_PK" PRIMARY KEY (nodeid),
  CONSTRAINT "ParentNode_FK" FOREIGN KEY (parentnodeid)
      REFERENCES virtualnode (nodeid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

ALTER TABLE public.virtualnode OWNER TO liferay;

CREATE TABLE virtualdocument(
  virtualnodeid bigint,
  virtualdocumentname character varying(50),
  documentrecordid bigint,
  userid bigint,
  virtualdocumentid bigint NOT NULL,
  CONSTRAINT "VirtualDocument_PK" PRIMARY KEY (virtualdocumentid),
  CONSTRAINT "virtualDocument_documentRecord_FK" FOREIGN KEY (documentrecordid)
      REFERENCES documentrecord (documentrecordid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "virtualDocument_virtualNode_FK" FOREIGN KEY (virtualnodeid)
      REFERENCES virtualnode (nodeid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

ALTER TABLE public.virtualdocument OWNER TO liferay;

CREATE SEQUENCE virtualnode_sequence
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
  
  CREATE SEQUENCE virtualdocument_sequence
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
--
-- TOC entry 2889 (class 0 OID 36791)
-- Dependencies: 161 2920
-- Data for Name: algorithm; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY algorithm (serviceid, "uiName", "shortDescription", "completeDescription", "serviceMethod", algorithmid) FROM stdin;
1	QT Screening	Chesnokov's QT Screening algorithm.	This program analyses a WFDB formatted ECG file and finds Total Beat count, Ectopic Beat count, Corrected QT Interval, Log of the QTV. It also finds the Interval Count, Mean Interval, Variance and Standard Deviation for both RR and QT intervals.  Original code at: http://www.codeproject.com/Articles/20995/ECG-Annotation-C-Library	chesnokovWrapperType2	45
1	rdsamp	reads a WFDB file and writes it in human readable format	rdsamp reads signal files for the specified record and writes the samples \nas decimal numbers on the standard output. If no options are provided, \nrdsamp starts at the beginning of the record and prints all samples. \nBy default, each line of output contains the sample number and samples \nfrom each signal, beginning with channel 0, separated by tabs.	rdsampWrapperType2	46
1	sigamp	Measure signal amplitudes of a WFDB record.	sigamp measures either baseline-corrected RMS amplitudes or (for suitably annotated ECG signals)  \n normal QRS peak-to-peak amplitudes for all signals of the specified record.  \n It makes up to 300 measurements (but see -n below) for each signal and calculates trimmed means  \n (by discarding the largest and smallest 5% of the measurements and taking the mean of the remaining 90%).	sigampWrapperType2	47
1	sqrs2csv	Attempts to locate QRS complexes in an ECG signal in the specified record. The detector algorithm is based on the length transform. Reads the ann...	Attempts to locate QRS complexes in an ECG signal in the specified record. The detector algorithm is based on the length transform. Reads the annotation file specified by record and annotator and writes a comma-separated-value format translation of it, one annotation per line.	sqrs2csvWrapperType2	49
1	sqrs4ihr	Produces an instantaneous heart rate signal from a Single-channel QRS detector.	Produces an instantaneous heart rate signal from a Single-channel QRS detector (from the reciprocals of the interbeat intervals.) Unlike tach(1) , however, ihr does not resample its output in order to obtain uniform time intervals between output samples. (If there is any variation whatsoever in heart rate, the intervals between output samples will be non-uniform.) This property makes the output of ihr unsuitable for conventional power spectral density estimation, but ideal for PSD estimation using the Lomb periodogram (see lomb(1) ).	sqrs4ihrWrapperType2	50
2	sqrs	Single-channel QRS detector.	sqrs attempts to locate QRS complexes in an ECG signal in the specified record. The detector algorithm is based on example 10 in the WFDB Programmer's Guide, which in turn is based on a Pascal program written by W.A.H. Engelse and C. Zeelenberg, "A single scan algorithm for QRS-detection and feature extraction", Computers in Cardiology 6:37-42 (1979). sqrs does not include the feature extraction capability of the Pascal program. The output of sqrs is an annotation file (with annotator name qrs) in which all detected beats are labelled normal; the annotation file may also contain "artifact" annotations at locations that sqrs believes are noise-corrupted.\n sqrs can process records containing any number of signals, but it uses only one signal for QRS detection (signal 0 by default; this can be changed using the -s option, see below). sqrs is optimized for use with adult human ECGs. For other ECGs, it may be necessary to experiment with the sampling frequency as recorded in the input record's header file (see header(5) ) and the time constants indicated in the source file.\n sqrs uses the WFDB library's setifreq function to resample the input signal at 250 Hz if a significantly different sampling frequency is indicated in the header file. sqrs125 is identical to sqrs except that its filter and time constants have been designed for 125 Hz input, so that its speed is roughly twice that of sqrs. If the input signal has been sampled at a frequency near 125 Hz, the quality of the outputs of sqrs and sqrs125 will be nearly identical. (Note that older versions of these programs did not resample their inputs; rather, they warned if the sampling frequency was significantly different than the ideal frequency, and suggested using xform(1) to resample the input.)\n This program is provided as an example only, and is not intended for any clinical application. At the time the algorithm was originally published, its performance was typical of state-of-the-art QRS detectors. Recent designs, particularly those that can analyze two or more input signals, may exhibit significantly better performance.	sqrsWrapperType2	48
1	sqrs4pnnlist/pNNx	Calculates time domain measures of heart rate variability from a Single-channel QRS detector.	Calculates time domain measures of heart rate variability from a Single-channel QRS detector (from the reciprocals of the interbeat intervals). These programs derive pNNx, time domain measures of heart rate variability defined for any time interval x as the fraction of consecutive normal sinus (NN) intervals that differ by more than x.Conventionally, such measures have been applied to assess parasympathetic activity using x = 50 milliseconds (yielding the widely-cited pNN50 statistic).	sqrs4pnnlistWrapperType2	51
1	wqrs	single-channel QRS detector based on length transform.	wqrs attempts to locate QRS complexes in an ECG signal in the specified record. The detector algorithm is based on the length transform. The output of wqrs is an annotation file (with annotator name wqrs) in which all detected beats are labelled normal; the annotation file will also contain optional J-point annotations if the -j option (see below) is used. \n wqrs can process records containing any number of signals, but it uses only one signal for QRS detection (signal 0 by default; this can be changed using the -s option, see below). wqrs is optimized for use with adult human ECGs. For other ECGs, it may be necessary to experiment with the sampling frequency as recorded in the input record's header file (see header(5) ), the detector threshold (which can be set using the -m option), and the time constants indicated in the source file. \n wqrs optionally uses the WFDB library's setifreq function to resample the input signal at 120 or 150 Hz (depending on the mains frequency, which can be specified using the -p option). wqrs performs well using input sampled at a range of rates up to 360 Hz and possibly higher rates, but it has been designed and tested to work best on signals sampled at 120 or 150 Hz.	wqrsWrapperType2	52
1	wqrs2csv	Attempts to locate QRS complexes in an ECG signal in the specified record and reads the annotation file specified by record and annotator and wri...	Attempts to locate QRS complexes in an ECG signal in the specified record and reads the annotation file specified by record and annotator and writes a comma-separated-value format translation of it, one annotation per line.	wqrs2csvWrapperType2	53
1	wqrs4ihr	Produces an instantaneous heart rate signal from a Single-channel QRS detector.	Produces an instantaneous heart rate signal from a Single-channel QRS detector (from the reciprocals of the interbeat intervals.) Unlike tach(1) , however, ihr does not resample its output in order to obtain uniform time intervals between output samples. (If there is any variation whatsoever in heart rate, the intervals between output samples will be non-uniform.) This property makes the output of ihr unsuitable for conventional power spectral density estimation, but ideal for PSD estimation using the Lomb periodogram (see lomb(1) ).	wqrs4ihrWrapperType2	54
1	wqrs4pnnlist/pNNx	Calculates time domain measures of heart rate variability from a Single-channel QRS detector.	Calculates time domain measures of heart rate variability from a Single-channel QRS detector (from the reciprocals of the interbeat intervals). These programs derive pNNx, time domain measures of heart rate variability defined for any time interval x as the fraction of consecutive normal sinus (NN) intervals that differ by more than x.Conventionally, such measures have been applied to assess parasympathetic activity using x = 50 milliseconds (yielding the widely-cited pNN50 statistic).	wqrs4pnnlistWrapperType2	55
\.


--
-- TOC entry 2890 (class 0 OID 36797)
-- Dependencies: 162 2920
-- Data for Name: algorithmPerson; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY "algorithmPerson" ("algorithmID", "personID", "algorithmPersonID") FROM stdin;
\.


--
-- TOC entry 2999 (class 0 OID 0)
-- Dependencies: 163
-- Name: algorithm_algorithmid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('algorithm_algorithmid_seq', 55, true);


--
-- TOC entry 3000 (class 0 OID 0)
-- Dependencies: 164
-- Name: algorithmperson_algorithmpersonid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('algorithmperson_algorithmpersonid_seq', 1, false);


--
-- TOC entry 2893 (class 0 OID 36804)
-- Dependencies: 165 2920
-- Data for Name: analysisjob; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY analysisjob (analysisjobid, filecount, documentrecordid, parametercount, serviceurl, servicename, servicemethod, userid, dateofanalysis, analysistime, message) FROM stdin;
\.


--
-- TOC entry 3001 (class 0 OID 0)
-- Dependencies: 166
-- Name: analyzejob_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('analyzejob_sequence', 1, false);


--
-- TOC entry 2895 (class 0 OID 36809)
-- Dependencies: 167 2920
-- Data for Name: annotationinfo; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY annotationinfo (annotationid, createdby, annotationtype, name, bioportalreferencelink, bioportalclassid, bioportalontology, leadindex, startingcoordinateid, endingcoordinateid, unitofmeasurement, description, value, documentrecordid, "timestamp", analysisjobid) FROM stdin;
\.


--
-- TOC entry 3002 (class 0 OID 0)
-- Dependencies: 168
-- Name: annotationinfo_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('annotationinfo_sequence', 28646, false);


--
-- TOC entry 2897 (class 0 OID 36817)
-- Dependencies: 169 2920
-- Data for Name: coordinate; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY coordinate (coordinateid, xcoordinate, ycoordinate) FROM stdin;
\.


--
-- TOC entry 3003 (class 0 OID 0)
-- Dependencies: 170
-- Name: coordinate_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('coordinate_sequence', 61353, false);


--
-- TOC entry 2899 (class 0 OID 36822)
-- Dependencies: 171 2920
-- Data for Name: documentrecord; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY documentrecord (documentrecordid, recordname, userid, subjectid, originalformat, samplingrate, filetreepath, leadcount, numberofpoints, dateofupload, age, gender, dateofrecording, adugain,leadNames) FROM stdin;
\.


--
-- TOC entry 3004 (class 0 OID 0)
-- Dependencies: 172
-- Name: documentrecord_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('documentrecord_sequence', 1966, false);


--
-- TOC entry 2901 (class 0 OID 36827)
-- Dependencies: 173 2920
-- Data for Name: filesinfo; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY filesinfo (fileid, documentrecordid, analysisjobid) FROM stdin;
\.


--
-- TOC entry 2902 (class 0 OID 36830)
-- Dependencies: 174 2920
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY organization ("uiName", "organizationID", "orgUrl", phonenumber) FROM stdin;
\.


--
-- TOC entry 2903 (class 0 OID 36836)
-- Dependencies: 175 2920
-- Data for Name: organizationContact; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY "organizationContact" ("organizationContactID", "organizationID", "contactID") FROM stdin;
\.


--
-- TOC entry 3005 (class 0 OID 0)
-- Dependencies: 176
-- Name: organization_organizationid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('organization_organizationid_seq', 1, false);


--
-- TOC entry 3006 (class 0 OID 0)
-- Dependencies: 177
-- Name: organizationcontact_organizationcontactid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('organizationcontact_organizationcontactid_seq', 1, false);


--
-- TOC entry 2906 (class 0 OID 36843)
-- Dependencies: 178 2920
-- Data for Name: parameter; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY parameter (parameterid, algorithmid, "uiName", "shortDescription", "completeDescription", flag, "defaultValue", "parameterTypeid", required, "multipleSelect", "parameterValidationid") FROM stdin;
336	46	Begin time(seconds)	Begin time(seconds)	Begin at the specified time in record (default: the beginning of record).	f	0	3	f	f	-1
337	46	Stop Time(seconds)	Stop Time(seconds)	Stop at the specified time. By default, rdsamp stops at the end of the record.	t	-1	3	f	f	-1
338	46	Interval limit(seconds)	Interval limit(seconds)	Limit the amount of output to the specified time interval (in standard time format; default: no limit). If both -l and -t are used, rdsamp stops at the earlier of the two limits	l	-1	3	f	f	-1
339	46	CSV Format	CSV Format	Produce output in CSV (comma-separated value) format (default: write output in tab-separated columns).	c	false	4	f	f	-1
340	46	High Res	High Res	Read the signal files in high-resolution mode (default: standard mode). These modes are identical for ordinary records. For multifrequency records, the standard decimation of oversampled signals to the frame rate is suppressed in high-resolution mode (rather, all other signals are resampled at the highest sampling frequency).	H	false	4	f	f	-1
341	46	Format output	Format output	Output times in the selected format and the values in physical units. By default, rdsamp prints times in sample intervals and values in A/D units.	format		5	f	f	-1
342	46	Signal List.	Signal List.	Print only the signals named in the signal-list (one or more input signal numbers or names, separated by spaces; default: print all signals). This option may be used to re-order or duplicate signals.	s		1	f	f	-1
343	46	Signal	Signal	Search for the first valid sample of the specified signal (a signal name or number) at or following the time specified with -f (or the beginning of the record if the -f option is not present), and begin printing at that time.	S		1	f	f	-1
344	46	Column Headings	Column Headings	Print column headings (signal names on the first line, units on the second). The names of some signals are too wide to fit in the columns; such names are shortened by omitting the initial characters (since names of related signals often differ only at the end, this helps to make the columns identifiable). Names of units are shortened when necessary by omitting the final characters, since the initial characters are usually most important for distinguishing different units. 	v	false	4	f	f	-1
345	46	XML	XML	Produce output in WFDB-XML format (same as the CSV format produced using the -c option, but wrapped within an XML header and trailer). This format is recognized and parsed automatically by wrsamp.	X	false	4	f	f	-1
346	47	Begin time (sec)	Begin time (sec)	Begin at the specified time in record (default: the beginning of record).	f	0	3	f	f	-1
347	47	End time (sec)	End time (sec)	Process until the specified time in record (default: the end of the record). 	t	-1	3	f	f	-1
348	47	High Res	High Res	Read the signal files in high-resolution mode (default: standard mode). These modes are identical for ordinary records. For multifrequency records, the standard decimation of oversampled signals to the frame rate is suppressed in high-resolution mode (rather, all other signals are resampled at the highest sampling frequency).	H	false	4	f	f	-1
349	47	annotator	annotator	Measure QRS peak-to-peak amplitudes based on normal QRS annotations from the specified annotator. Where this appears, substitute an annotator name. Annotator names are not file names! The suffix (extension) of the name of an annotation file is the annotator name for that file; so, for example, the annotator name for `e0104.atr' is `atr'. The special annotator name `atr' is used to name the set of reference annotations supplied by the database developers. Other annotation sets have annotator names that may contain letters, digits, and underscores, as for record names. 	a		1	f	f	-1
350	47	measurement window start d...	measurement window start delta	Set the measurement window start point relative to QRS annotations. Defaults: 0.05 (seconds before the annotation). 	dt1	0.05	3	f	f	-1
351	47	measurement window end del...	measurement window end delta	Set the measurement window end point relative to QRS annotations. Defaults: 0.05 (seconds after the annotation). 	dt2	0.05	3	f	f	-1
352	47	Set RMS amplitude measurem...	Set RMS amplitude measurement window.	Set RMS amplitude measurement window. Default: dtw = 1 (second)	w	1	3	f	f	-1
353	47	Measurement count	Measurement count	Make up to nmax measurements on each signal (default: 300). 	n	300	2	f	f	-1
354	47	Print results in physical ...	Print results in physical units.	Return physical units(default: ADC units) + elapsed time in seconds(same as -ps). (used with -q and -v when printing individual measurements);	p	false	4	f	f	-1
355	47	time of day and date	time of day and date	Return physical units + time of day and date if known	pd	false	4	f	f	-1
356	47	Elapsed time.	Elapsed time.	Return physical units + elapsed time as <hours>:<minutes>:<seconds>	pe	false	4	f	f	-1
357	47	Hours	Hours	Return physical units + elapsed time in hours.	ph	false	4	f	f	-1
358	47	Minutes	Minutes	Return physical units + elapsed time in minute	pm	false	4	f	f	-1
359	47	Seconds	Seconds	Return physical units + elapsed time in seconds(default, same as -p)	ps	false	4	f	f	-1
360	47	Samples	Samples	Return physical units + elapsed time in sample intervals.	pS	false	4	f	f	-1
361	47	Quick mode.	Quick mode.	Quick mode: print individual measurements only, not trimmed means.	q	false	4	f	f	-1
362	47	Verbose mode	Verbose mode	Verbose mode: print individual measurements as well as trimmed means.	v	false	4	f	f	-1
363	48	Begin time(seconds)	Begin time(seconds)	Begin at the specified time in record (default: the beginning of record).	f	0	3	f	f	-1
364	48	End time(seconds)	End time(seconds)	Process until the specified time in record (default: the end of the record). 	t	-1	3	f	f	-1
365	48	High Res	High Res	Read the signal files in high-resolution mode (default: standard mode). These modes are identical for ordinary records. For multifrequency records, the standard decimation of oversampled signals to the frame rate is suppressed in high-resolution mode (rather, all other signals are resampled at the highest sampling frequency).	H	false	4	t	f	-1
366	48	Threshold	Threshold	Specify the detection threshold (default: 500 units); use higher values to reduce false detections, or lower values to reduce the number of missed beats.	m	500	2	f	f	-1
367	48	Signal	Signal	Specify the signal (number or name) to be used for QRS detection (default: 0).	s	0	2	t	f	-1
368	52	Dump the raw	Dump the raw	Dump the raw and length-transformed input samples in text format on the standard output, but do not detect or annotate QRS complexes.	d	false	4	f	f	-1
369	52	Begin time (sec)	Begin time (sec)	Begin at the specified time in record (default: the beginning of record).	f	0	3	f	f	-1
370	52	Print a brief usage (help)...	Print a brief usage (help) summary.	Print a brief usage (help) summary.	h	false	4	f	f	-1
371	52	High Res	High Res	Read the signal files in high-resolution mode (default: standard mode). These modes are identical for ordinary records. For multifrequency records, the standard decimation of oversampled signals to the frame rate is suppressed in high-resolution mode (rather, all other signals are resampled at the highest sampling frequency).	H	false	4	t	f	-1
372	52	Annotate J-points	Annotate J-points	Find and annotate J-points (QRS ends) as well as QRS onsets.	j	false	4	f	f	-1
373	52	Threshold	Threshold	Specify the detection threshold (default: 100 microvolts); use higher values to reduce false detections, or lower values to reduce the number of missed beats.	m	100	2	f	f	-1
374	52	Power line frequency.	Power line frequency.	Specify the power line (mains) frequency used at the time of the recording, in Hz (default: 60). wqrs will apply a notch filter of the specified frequency to the input signal before length-transforming it.	p	60	2	f	f	-1
375	52	Resample the input.	Resample the input.	Resample the input at 120 Hz if the power line frequency is 60 Hz, or at 150 Hz otherwise (default: do not resample).	R	false	4	f	f	-1
376	52	Signal	Signal	Specify the signal (number or name) to be used for QRS detection (default: 0).	s	0	2	t	f	-1
377	52	End time (sec)	End time (sec)	Process until the specified time in record (default: the end of the record).	t	-1	3	f	f	-1
378	52	Verbose mode	Verbose mode	Verbose mode: print information about the detector parameters.	v	false	4	f	f	-1
\.


--
-- TOC entry 2907 (class 0 OID 36851)
-- Dependencies: 179 2920
-- Data for Name: parameterOption; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY "parameterOption" ("uiText", "uiValue", "isInitialSelection", "shortDescription", "completeDescription", parameteroptionid, "parentParameterID") FROM stdin;
\.


--
-- TOC entry 2908 (class 0 OID 36858)
-- Dependencies: 180 2920
-- Data for Name: parameterType; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY "parameterType" ("parameterTypeid", "uiName", "shortDescription") FROM stdin;
1	text	Can take on any text value.
2	integer	Takes only an integer number value.
3	float	Takes a real number value.
4	boolean	Takes a true or false, e.g. a checkbox, true=checked
5	select	Takes on one (or many) or a specific set of values. Requires a Parameter Option list below.
6	drill down	Takes on one (or many) of a specific set of values. Creating a hierarchical select menu, which allows users to "drill down" a set of options.
\.


--
-- TOC entry 2918 (class 0 OID 37057)
-- Dependencies: 190 2920
-- Data for Name: parameterValidator; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY "parameterValidator" ("validatorType", message, min, max, regex, "parameterValidationid") FROM stdin;
0	no validator	\N	\N	\N	-1
\.


--
-- TOC entry 3007 (class 0 OID 0)
-- Dependencies: 181
-- Name: parameteroption_parameteroptionid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parameteroption_parameteroptionid_seq', 1, false);


--
-- TOC entry 3008 (class 0 OID 0)
-- Dependencies: 182
-- Name: parameters_parameterid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parameters_parameterid_seq', 7, true);


--
-- TOC entry 3009 (class 0 OID 0)
-- Dependencies: 183
-- Name: parametertype_parametertypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parametertype_parametertypeid_seq', 6, true);


--
-- TOC entry 3010 (class 0 OID 0)
-- Dependencies: 191
-- Name: parametervalidator_parametervalidationid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parametervalidator_parametervalidationid_seq', 1, false);


--
-- TOC entry 2912 (class 0 OID 36867)
-- Dependencies: 184 2920
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY person (firstname, lastname, middlename, email, phonenumber, "personID") FROM stdin;
\.


--
-- TOC entry 3011 (class 0 OID 0)
-- Dependencies: 185
-- Name: person_personid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('person_personid_seq', 1, false);


--
-- TOC entry 2914 (class 0 OID 36872)
-- Dependencies: 186 2920
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY service (serviceid, "uiName", "wsName", "wsUrl") FROM stdin;
1	LocalPhysionet	physionetAnalysisService	http://localhost:8080/axis2/services
2	icmv058	physionetAnalysisService	http://128.220.76.170:8080/axis2/services
\.


--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 187
-- Name: service_serviceid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('service_serviceid_seq', 2, true);


--
-- TOC entry 2916 (class 0 OID 36880)
-- Dependencies: 188 2920
-- Data for Name: uploadstatus; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY uploadstatus (uploadstatusid, filetransfer, fileconversion, recordcreation, annotationcreation, documentrecordid) FROM stdin;
\.


--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 189
-- Name: uploadstatus_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('uploadstatus_sequence', 1, false);


--
-- TOC entry 2730 (class 2606 OID 36895)
-- Dependencies: 165 165 2921
-- Name: analysisjob_pk; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY analysisjob
    ADD CONSTRAINT analysisjob_pk PRIMARY KEY (analysisjobid);


--
-- TOC entry 2732 (class 2606 OID 36897)
-- Dependencies: 167 167 2921
-- Name: annotation_pk; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY annotationinfo
    ADD CONSTRAINT annotation_pk PRIMARY KEY (annotationid);


--
-- TOC entry 2738 (class 2606 OID 36899)
-- Dependencies: 169 169 2921
-- Name: coordinate_pk; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY coordinate
    ADD CONSTRAINT coordinate_pk PRIMARY KEY (coordinateid);


--
-- TOC entry 2741 (class 2606 OID 36901)
-- Dependencies: 171 171 2921
-- Name: documentrecord_pk; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY documentrecord
    ADD CONSTRAINT documentrecord_pk PRIMARY KEY (documentrecordid);


--
-- TOC entry 2749 (class 2606 OID 36903)
-- Dependencies: 173 173 2921
-- Name: filesinfo_pk; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY filesinfo
    ADD CONSTRAINT filesinfo_pk PRIMARY KEY (fileid);


--
-- TOC entry 2723 (class 2606 OID 36905)
-- Dependencies: 161 161 2921
-- Name: idAlgorithm; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY algorithm
    ADD CONSTRAINT "idAlgorithm" PRIMARY KEY (algorithmid);


--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 2723
-- Name: CONSTRAINT "idAlgorithm" ON algorithm; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON CONSTRAINT "idAlgorithm" ON algorithm IS 'Primary Key for algorithm table.';


--
-- TOC entry 2727 (class 2606 OID 36907)
-- Dependencies: 162 162 2921
-- Name: idAlgorithmPerson; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY "algorithmPerson"
    ADD CONSTRAINT "idAlgorithmPerson" PRIMARY KEY ("algorithmPersonID");


--
-- TOC entry 2753 (class 2606 OID 36909)
-- Dependencies: 174 174 2921
-- Name: idOrganization; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT "idOrganization" PRIMARY KEY ("organizationID");


--
-- TOC entry 3015 (class 0 OID 0)
-- Dependencies: 2753
-- Name: CONSTRAINT "idOrganization" ON organization; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON CONSTRAINT "idOrganization" ON organization IS 'Primary Key of the organization table.';


--
-- TOC entry 2757 (class 2606 OID 36911)
-- Dependencies: 175 175 2921
-- Name: idOrganizationContact; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY "organizationContact"
    ADD CONSTRAINT "idOrganizationContact" PRIMARY KEY ("organizationContactID");


--
-- TOC entry 2761 (class 2606 OID 36913)
-- Dependencies: 178 178 2921
-- Name: idParameter; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT "idParameter" PRIMARY KEY (parameterid);


--
-- TOC entry 2763 (class 2606 OID 37056)
-- Dependencies: 179 179 2921
-- Name: idParameterOption; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY "parameterOption"
    ADD CONSTRAINT "idParameterOption" PRIMARY KEY (parameteroptionid);


--
-- TOC entry 2765 (class 2606 OID 36915)
-- Dependencies: 180 180 2921
-- Name: idParameterType; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY "parameterType"
    ADD CONSTRAINT "idParameterType" PRIMARY KEY ("parameterTypeid");


--
-- TOC entry 2767 (class 2606 OID 36917)
-- Dependencies: 184 184 2921
-- Name: idPerson; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT "idPerson" PRIMARY KEY ("personID");


--
-- TOC entry 2769 (class 2606 OID 36919)
-- Dependencies: 186 186 2921
-- Name: idService; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY service
    ADD CONSTRAINT "idService" PRIMARY KEY (serviceid);


--
-- TOC entry 2771 (class 2606 OID 36921)
-- Dependencies: 188 188 2921
-- Name: uploadstatus_pk; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY uploadstatus
    ADD CONSTRAINT uploadstatus_pk PRIMARY KEY (uploadstatusid);


--
-- TOC entry 2728 (class 1259 OID 36922)
-- Dependencies: 165 2921
-- Name: analysisjob__pkey; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE UNIQUE INDEX analysisjob__pkey ON analysisjob USING btree (analysisjobid);

ALTER TABLE analysisjob CLUSTER ON analysisjob__pkey;


--
-- TOC entry 2733 (class 1259 OID 36923)
-- Dependencies: 167 2921
-- Name: annotationinfo_pkey; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE UNIQUE INDEX annotationinfo_pkey ON annotationinfo USING btree (annotationid);


--
-- TOC entry 2739 (class 1259 OID 36924)
-- Dependencies: 169 2921
-- Name: coordinate_pkey; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE UNIQUE INDEX coordinate_pkey ON coordinate USING btree (coordinateid);


--
-- TOC entry 2742 (class 1259 OID 36925)
-- Dependencies: 171 2921
-- Name: documentrecord_pkey; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE UNIQUE INDEX documentrecord_pkey ON documentrecord USING btree (documentrecordid);


--
-- TOC entry 2750 (class 1259 OID 36926)
-- Dependencies: 173 2921
-- Name: filesinfo_pkey; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE UNIQUE INDEX filesinfo_pkey ON filesinfo USING btree (fileid);


--
-- TOC entry 2758 (class 1259 OID 36927)
-- Dependencies: 178 2921
-- Name: fki_idAlgorithm; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idAlgorithm" ON parameter USING btree (algorithmid);


--
-- TOC entry 2724 (class 1259 OID 36928)
-- Dependencies: 162 2921
-- Name: fki_idAlgorithmPersonAlg; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idAlgorithmPersonAlg" ON "algorithmPerson" USING btree ("algorithmID");


--
-- TOC entry 2725 (class 1259 OID 36929)
-- Dependencies: 162 2921
-- Name: fki_idAlgorithmPersonPerson; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idAlgorithmPersonPerson" ON "algorithmPerson" USING btree ("personID");


--
-- TOC entry 2754 (class 1259 OID 36930)
-- Dependencies: 175 2921
-- Name: fki_idOrganizationContactOrg; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idOrganizationContactOrg" ON "organizationContact" USING btree ("organizationID");


--
-- TOC entry 2755 (class 1259 OID 36931)
-- Dependencies: 175 2921
-- Name: fki_idOrganizationContactPerson; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idOrganizationContactPerson" ON "organizationContact" USING btree ("contactID");


--
-- TOC entry 2759 (class 1259 OID 36932)
-- Dependencies: 178 2921
-- Name: fki_idParameterType; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idParameterType" ON parameter USING btree ("parameterTypeid");


--
-- TOC entry 2721 (class 1259 OID 36933)
-- Dependencies: 161 2921
-- Name: fki_service; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX fki_service ON algorithm USING btree (serviceid);


--
-- TOC entry 2734 (class 1259 OID 36934)
-- Dependencies: 167 167 167 167 2921
-- Name: ix_annotationinfo_1; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_annotationinfo_1 ON annotationinfo USING btree (documentrecordid, name, annotationtype, leadindex);


--
-- TOC entry 2735 (class 1259 OID 36935)
-- Dependencies: 167 2921
-- Name: ix_annotationinfo_2; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_annotationinfo_2 ON annotationinfo USING btree (documentrecordid);


--
-- TOC entry 2736 (class 1259 OID 36936)
-- Dependencies: 167 167 2921
-- Name: ix_annotationinfo_3; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_annotationinfo_3 ON annotationinfo USING btree (annotationtype, documentrecordid);


--
-- TOC entry 2743 (class 1259 OID 36937)
-- Dependencies: 171 171 171 171 2921
-- Name: ix_documentrecord_1; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_documentrecord_1 ON documentrecord USING btree (recordname, userid, subjectid, filetreepath);


--
-- TOC entry 2744 (class 1259 OID 36938)
-- Dependencies: 171 2921
-- Name: ix_documentrecord_2; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_documentrecord_2 ON documentrecord USING btree (userid);


--
-- TOC entry 2745 (class 1259 OID 36939)
-- Dependencies: 171 2921
-- Name: ix_documentrecord_3; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_documentrecord_3 ON documentrecord USING btree (documentrecordid);


--
-- TOC entry 2746 (class 1259 OID 36940)
-- Dependencies: 171 2921
-- Name: ix_documentrecord_4; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_documentrecord_4 ON documentrecord USING btree (subjectid);


--
-- TOC entry 2747 (class 1259 OID 36941)
-- Dependencies: 171 2921
-- Name: ix_documentrecord_5; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_documentrecord_5 ON documentrecord USING btree (originalformat);


--
-- TOC entry 2751 (class 1259 OID 36942)
-- Dependencies: 173 2921
-- Name: ix_filesinfo_1; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX ix_filesinfo_1 ON filesinfo USING btree (documentrecordid);


--
-- TOC entry 2772 (class 1259 OID 36943)
-- Dependencies: 188 2921
-- Name: uploadstatus_pkey; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE UNIQUE INDEX uploadstatus_pkey ON uploadstatus USING btree (uploadstatusid);


--
-- TOC entry 2777 (class 2606 OID 36944)
-- Dependencies: 2729 165 167 2921
-- Name: analysisjob_annotationinfo; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY annotationinfo
    ADD CONSTRAINT analysisjob_annotationinfo FOREIGN KEY (analysisjobid) REFERENCES analysisjob(analysisjobid);


--
-- TOC entry 2781 (class 2606 OID 36949)
-- Dependencies: 173 165 2729 2921
-- Name: analysisjob_filesinfo_fk; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY filesinfo
    ADD CONSTRAINT analysisjob_filesinfo_fk FOREIGN KEY (analysisjobid) REFERENCES analysisjob(analysisjobid);


--
-- TOC entry 2776 (class 2606 OID 36954)
-- Dependencies: 165 2740 171 2921
-- Name: documentrecord_analysisjob_fk; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY analysisjob
    ADD CONSTRAINT documentrecord_analysisjob_fk FOREIGN KEY (documentrecordid) REFERENCES documentrecord(documentrecordid);


--
-- TOC entry 2778 (class 2606 OID 36959)
-- Dependencies: 167 2740 171 2921
-- Name: documentrecord_annotationinfo_fk; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY annotationinfo
    ADD CONSTRAINT documentrecord_annotationinfo_fk FOREIGN KEY (documentrecordid) REFERENCES documentrecord(documentrecordid);


--
-- TOC entry 2782 (class 2606 OID 36964)
-- Dependencies: 173 2740 171 2921
-- Name: documentrecord_fk; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY filesinfo
    ADD CONSTRAINT documentrecord_fk FOREIGN KEY (documentrecordid) REFERENCES documentrecord(documentrecordid);


--
-- TOC entry 2787 (class 2606 OID 36969)
-- Dependencies: 188 2740 171 2921
-- Name: documentrecord_uploadstatus_fk; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY uploadstatus
    ADD CONSTRAINT documentrecord_uploadstatus_fk FOREIGN KEY (documentrecordid) REFERENCES documentrecord(documentrecordid);


--
-- TOC entry 2779 (class 2606 OID 36974)
-- Dependencies: 2737 169 167 2921
-- Name: endcoordinate_annotationinfo_fk; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY annotationinfo
    ADD CONSTRAINT endcoordinate_annotationinfo_fk FOREIGN KEY (endingcoordinateid) REFERENCES coordinate(coordinateid);


--
-- TOC entry 2773 (class 2606 OID 37020)
-- Dependencies: 161 186 2768 2921
-- Name: fkService; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithm
    ADD CONSTRAINT "fkService" FOREIGN KEY (serviceid) REFERENCES service(serviceid);


--
-- TOC entry 2785 (class 2606 OID 37129)
-- Dependencies: 161 2722 178 2921
-- Name: idAlgorithm; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT "idAlgorithm" FOREIGN KEY (algorithmid) REFERENCES algorithm(algorithmid);


--
-- TOC entry 2774 (class 2606 OID 37025)
-- Dependencies: 2722 162 161 2921
-- Name: idAlgorithmPersonAlg; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "algorithmPerson"
    ADD CONSTRAINT "idAlgorithmPersonAlg" FOREIGN KEY ("algorithmID") REFERENCES algorithm(algorithmid);


--
-- TOC entry 2775 (class 2606 OID 37030)
-- Dependencies: 2766 162 184 2921
-- Name: idAlgorithmPersonPerson; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "algorithmPerson"
    ADD CONSTRAINT "idAlgorithmPersonPerson" FOREIGN KEY ("personID") REFERENCES person("personID");


--
-- TOC entry 2783 (class 2606 OID 37035)
-- Dependencies: 175 174 2752 2921
-- Name: idOrganizationContactOrg; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "organizationContact"
    ADD CONSTRAINT "idOrganizationContactOrg" FOREIGN KEY ("organizationID") REFERENCES organization("organizationID");


--
-- TOC entry 2784 (class 2606 OID 37040)
-- Dependencies: 2766 184 175 2921
-- Name: idOrganizationContactPerson; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "organizationContact"
    ADD CONSTRAINT "idOrganizationContactPerson" FOREIGN KEY ("contactID") REFERENCES person("personID");


--
-- TOC entry 2786 (class 2606 OID 37134)
-- Dependencies: 178 2764 180 2921
-- Name: idParameterType; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT "idParameterType" FOREIGN KEY ("parameterTypeid") REFERENCES "parameterType"("parameterTypeid");


--
-- TOC entry 2780 (class 2606 OID 37014)
-- Dependencies: 2737 167 169 2921
-- Name: startcoordinate_fk; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY annotationinfo
    ADD CONSTRAINT startcoordinate_fk FOREIGN KEY (startingcoordinateid) REFERENCES coordinate(coordinateid);


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-04-25 13:06:51 EDT

--
-- PostgreSQL database dump complete
--

