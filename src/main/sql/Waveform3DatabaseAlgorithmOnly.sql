--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.12
-- Dumped by pg_dump version 9.1.12
-- Started on 2014-07-09 17:18:08 EDT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
    algorithmid integer NOT NULL,
    resultformat character varying(20)
);


ALTER TABLE public.algorithm OWNER TO liferay;

--
-- TOC entry 2852 (class 0 OID 0)
-- Dependencies: 161
-- Name: TABLE algorithm; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE algorithm IS 'Data in this table describes a single analysis algorithm service method so that the User Interface code  can auto-generate an invocation interface which will support all the required and optional input parameters.
It also specifies the output files, so the result interface can be auto-generated. 

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2853 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm.serviceid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm.serviceid IS 'Foreign key to the "service" table, which will contain the URL and description meta-data for a single web service.  This web service may provide multiple algorithms, each as a method.';


--
-- TOC entry 2854 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm."uiName" IS 'Human friendly name to be used by the UI when listing services. ';


--
-- TOC entry 2855 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm."shortDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm."shortDescription" IS 'Short summary description suitable for displaying as a tooltip. ';


--
-- TOC entry 2856 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm."completeDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm."completeDescription" IS 'Complete description of the algorithm suitable for using in a manual/help file.  ';


--
-- TOC entry 2857 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm."serviceMethod"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm."serviceMethod" IS 'Name of the method which executes the algorithm, within the above webservice. e.g. "sqrsWrapperType2".
';


--
-- TOC entry 2858 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm.algorithmid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm.algorithmid IS 'Primary Key for Algorithms.';


--
-- TOC entry 2859 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN algorithm.resultformat; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithm.resultformat IS 'Data format of the result file which the web service will return.
Valid values are "WFDBAnnotation" and "CSV"';


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
-- TOC entry 2860 (class 0 OID 0)
-- Dependencies: 163
-- Name: algorithm_algorithmid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE algorithm_algorithmid_seq OWNED BY algorithm.algorithmid;


--
-- TOC entry 162 (class 1259 OID 36797)
-- Dependencies: 6
-- Name: algorithmperson; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE algorithmperson (
    algorithmid integer,
    personid integer,
    "algorithmPersonid" integer NOT NULL
);


ALTER TABLE public.algorithmperson OWNER TO liferay;

--
-- TOC entry 2861 (class 0 OID 0)
-- Dependencies: 162
-- Name: TABLE algorithmperson; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE algorithmperson IS 'Link table to cite every person who contributed to this algorithm web service, whom should to be credited.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2862 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN algorithmperson.algorithmid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmperson.algorithmid IS 'The algorithm that this person is affiliated with.';


--
-- TOC entry 2863 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN algorithmperson.personid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmperson.personid IS 'The person affiliated with this algorithm.';


--
-- TOC entry 2864 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN algorithmperson."algorithmPersonid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmperson."algorithmPersonid" IS 'Primary Key for algorithmPerson table.';


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
-- TOC entry 2865 (class 0 OID 0)
-- Dependencies: 164
-- Name: algorithmperson_algorithmpersonid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE algorithmperson_algorithmpersonid_seq OWNED BY algorithmperson."algorithmPersonid";


--
-- TOC entry 181 (class 1259 OID 37240)
-- Dependencies: 6
-- Name: algorithmreference; Type: TABLE; Schema: public; Owner: liferay; Tablespace: 
--

CREATE TABLE algorithmreference (
    algorithmreferenceid integer NOT NULL,
    algorithmid integer,
    "versionAlgorithm" character varying(30),
    "dateAlgorithm" date,
    "versionWebService" character varying(30),
    "dateWebService" date,
    licence character varying(200),
    referenceurl character varying(200)
);


ALTER TABLE public.algorithmreference OWNER TO liferay;

--
-- TOC entry 2866 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE algorithmreference; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE algorithmreference IS 'Contains reference data about the algorithm which is not strictly neccessary for executing the algorithm, such as version numbers, documentations links and license.';


--
-- TOC entry 2867 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN algorithmreference.algorithmreferenceid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmreference.algorithmreferenceid IS 'Unique ID of the algorithmReference table.';


--
-- TOC entry 2868 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN algorithmreference.algorithmid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmreference.algorithmid IS 'Foriegn key linking this entry to an algorithm table entry.';


--
-- TOC entry 2869 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN algorithmreference."versionAlgorithm"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmreference."versionAlgorithm" IS 'Version ID of the algorithm (e.g. "2.5" or "3.0 Beta" ) ';


--
-- TOC entry 2870 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN algorithmreference."dateAlgorithm"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmreference."dateAlgorithm" IS 'Date of this version of the algorithm.';


--
-- TOC entry 2871 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN algorithmreference."versionWebService"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmreference."versionWebService" IS 'Version ID of the web service which contains this algorithm (e.g. "1.0" or "3.0 Beta" )';


--
-- TOC entry 2872 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN algorithmreference."dateWebService"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmreference."dateWebService" IS 'Date of this version of the Web Service.';


--
-- TOC entry 2873 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN algorithmreference.licence; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmreference.licence IS 'License of this algorithm, or URL of license e.g. "GPL 2.0".';


--
-- TOC entry 2874 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN algorithmreference.referenceurl; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN algorithmreference.referenceurl IS 'URL of a documentation web page about this algorithm.';


--
-- TOC entry 182 (class 1259 OID 37243)
-- Dependencies: 181 6
-- Name: algorithmreference_algorithmreferenceid_seq; Type: SEQUENCE; Schema: public; Owner: liferay
--

CREATE SEQUENCE algorithmreference_algorithmreferenceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.algorithmreference_algorithmreferenceid_seq OWNER TO liferay;

--
-- TOC entry 2875 (class 0 OID 0)
-- Dependencies: 182
-- Name: algorithmreference_algorithmreferenceid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE algorithmreference_algorithmreferenceid_seq OWNED BY algorithmreference.algorithmreferenceid;


--
-- TOC entry 165 (class 1259 OID 36830)
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
-- TOC entry 2876 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE organization; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE organization IS 'Data about an organization.
An organization may be linked either to an algorithm, a service or a person.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2877 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN organization."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN organization."uiName" IS 'Name to be displays to users. ';


--
-- TOC entry 2878 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN organization."organizationID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN organization."organizationID" IS 'Primary Key for the organization table.';


--
-- TOC entry 2879 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN organization."orgUrl"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN organization."orgUrl" IS 'URL of the organization''s web page.';


--
-- TOC entry 2880 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN organization.phonenumber; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN organization.phonenumber IS 'Contact phone number for the organization.';


--
-- TOC entry 166 (class 1259 OID 36836)
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
-- TOC entry 2881 (class 0 OID 0)
-- Dependencies: 166
-- Name: TABLE "organizationContact"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE "organizationContact" IS 'Link table, connects "organization" entries with enteries in the "person" table to indicate who the contact person is for an organization.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2882 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN "organizationContact"."organizationContactID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "organizationContact"."organizationContactID" IS 'Primary Key for organizationContact link table.';


--
-- TOC entry 2883 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN "organizationContact"."organizationID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "organizationContact"."organizationID" IS 'Foreign Key of the organization.';


--
-- TOC entry 2884 (class 0 OID 0)
-- Dependencies: 166
-- Name: COLUMN "organizationContact"."contactID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "organizationContact"."contactID" IS 'Foreign Key of the person who is the organization''s Contact person.';


--
-- TOC entry 167 (class 1259 OID 36839)
-- Dependencies: 6 165
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
-- TOC entry 2885 (class 0 OID 0)
-- Dependencies: 167
-- Name: organization_organizationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE organization_organizationid_seq OWNED BY organization."organizationID";


--
-- TOC entry 168 (class 1259 OID 36841)
-- Dependencies: 6 166
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
-- TOC entry 2886 (class 0 OID 0)
-- Dependencies: 168
-- Name: organizationcontact_organizationcontactid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE organizationcontact_organizationcontactid_seq OWNED BY "organizationContact"."organizationContactID";


--
-- TOC entry 169 (class 1259 OID 36843)
-- Dependencies: 2699 2700 6
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
-- TOC entry 2887 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE parameter; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE parameter IS 'Additional "useful" parameter to be passed to the algorithm if selected and entered by the user.
An example of “useful” parameter would be: “select 50hz noise filtering for European sourced data”.
An example of NOT “useful” would be: “Send results to the (non-existent) printer”.

@author mshipwa1@jhu.edu
March 10, 2014
';


--
-- TOC entry 2888 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter.parameterid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter.parameterid IS 'Primary Key for this parameter. ';


--
-- TOC entry 2889 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter.algorithmid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter.algorithmid IS 'Foreign Key of the algorithm this parameter pertains to.';


--
-- TOC entry 2890 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."uiName" IS 'Human friendly name to be used by the UI when listing options.';


--
-- TOC entry 2891 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter."shortDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."shortDescription" IS 'Short summary description suitable for displaying as a tooltip. ';


--
-- TOC entry 2892 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter."completeDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."completeDescription" IS 'Complete description of the algorithm suitable for using in a manual/help file.  ';


--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter.flag; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter.flag IS 'Identifying character(s) to be sent to the web service if this optional parameter is to be invoked.
It could be the underlying code''s command line flag which identifies a value that follows it,  e.g. "-r " preceeds the record-name.
Or it could be a short word, specified by the web service writer, e.g. "record".';


--
-- TOC entry 2894 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter."defaultValue"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."defaultValue" IS 'If the parameter equals this value, don''t pass the parameter data to the web service.
Also, this is the value which the algorithm will use if no parameter value is set by the user.';


--
-- TOC entry 2895 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter."parameterTypeid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."parameterTypeid" IS 'Foreign Key to indicate which data type the parameter should be.
Options will be:
  1:text, 2:integer, 3:float, 4:boolean, 5:select, 
  6:drill_down, or 7:data_column ';


--
-- TOC entry 2896 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter.required; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter.required IS 'If true, this parameter must have a value.';


--
-- TOC entry 2897 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter."multipleSelect"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."multipleSelect" IS 'If true, allow multiple selections in a dropdown list.
Only relevent for select or data_column parameter types.';


--
-- TOC entry 2898 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN parameter."parameterValidationid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN parameter."parameterValidationid" IS 'Foreign Key to the validation table entry related to this parameter.';


--
-- TOC entry 170 (class 1259 OID 36851)
-- Dependencies: 2702 6
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
-- TOC entry 2899 (class 0 OID 0)
-- Dependencies: 170
-- Name: TABLE "parameterOption"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE "parameterOption" IS 'List of parameter options; only needed (or valid) when the parameter type is "select" or "drill_down" .
These options will be the items in a dropdown list or radio button control.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2900 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN "parameterOption"."uiText"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."uiText" IS 'Text for the UI to display in a drop down list, checkbox or radiobutton. ';


--
-- TOC entry 2901 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN "parameterOption"."uiValue"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."uiValue" IS 'Value to be sent to the web service if this option is selected.';


--
-- TOC entry 2902 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN "parameterOption"."isInitialSelection"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."isInitialSelection" IS 'If true this option the default for the parent parameter.';


--
-- TOC entry 2903 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN "parameterOption"."shortDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."shortDescription" IS 'Short summary description suitable for displaying as a tooltip.';


--
-- TOC entry 2904 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN "parameterOption"."completeDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."completeDescription" IS 'Complete description of the parameter’s option suitable for using in a manual/help file.  ';


--
-- TOC entry 2905 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN "parameterOption".parameteroptionid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption".parameteroptionid IS 'Primary Key for parameterOption table.';


--
-- TOC entry 2906 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN "parameterOption"."parentParameterID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterOption"."parentParameterID" IS 'Foreign Key of the parameter that this option pertains to. ';


--
-- TOC entry 171 (class 1259 OID 36858)
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
-- TOC entry 2907 (class 0 OID 0)
-- Dependencies: 171
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
-- TOC entry 2908 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN "parameterType"."parameterTypeid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterType"."parameterTypeid" IS 'Primary key of parameterType table.';


--
-- TOC entry 2909 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN "parameterType"."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterType"."uiName" IS 'Name of the parameter(control) type, suitable for displaying in the UI.';


--
-- TOC entry 2910 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN "parameterType"."shortDescription"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterType"."shortDescription" IS 'Short description of the parameter type, suitable for a tooltip.';


--
-- TOC entry 179 (class 1259 OID 37057)
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
-- TOC entry 2911 (class 0 OID 0)
-- Dependencies: 179
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
-- TOC entry 2912 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterValidator"."validatorType"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator"."validatorType" IS 'Can be of 3 types:
1 = regex - A javaScript regular expression which describes a valid entry for when type is "text". 
2 = in_range - Defines the minimum and maximum values that a numeric input (integer or float) can have.
3 = length -  Defines the minimum and maximum length that a text input can have.
';


--
-- TOC entry 2913 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterValidator".message; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator".message IS 'The message displayed if validation fails.';


--
-- TOC entry 2914 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterValidator".min; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator".min IS 'minimum parameter value; only valid when type is "integer" or "float"';


--
-- TOC entry 2915 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterValidator".max; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator".max IS 'maximum parameter value; only valid when type is "integer" or "float"';


--
-- TOC entry 2916 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterValidator".regex; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator".regex IS 'A JavaScript regular expression which describes a valid entry for when type is "text". ';


--
-- TOC entry 2917 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN "parameterValidator"."parameterValidationid"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN "parameterValidator"."parameterValidationid" IS 'Primary key of parameterValidation table.';


--
-- TOC entry 172 (class 1259 OID 36861)
-- Dependencies: 6 170
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
-- TOC entry 2918 (class 0 OID 0)
-- Dependencies: 172
-- Name: parameteroption_parameteroptionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE parameteroption_parameteroptionid_seq OWNED BY "parameterOption".parameteroptionid;


--
-- TOC entry 173 (class 1259 OID 36863)
-- Dependencies: 6 169
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
-- TOC entry 2919 (class 0 OID 0)
-- Dependencies: 173
-- Name: parameters_parameterid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE parameters_parameterid_seq OWNED BY parameter.parameterid;


--
-- TOC entry 174 (class 1259 OID 36865)
-- Dependencies: 171 6
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
-- TOC entry 2920 (class 0 OID 0)
-- Dependencies: 174
-- Name: parametertype_parametertypeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE parametertype_parametertypeid_seq OWNED BY "parameterType"."parameterTypeid";


--
-- TOC entry 180 (class 1259 OID 37065)
-- Dependencies: 6 179
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
-- TOC entry 2921 (class 0 OID 0)
-- Dependencies: 180
-- Name: parametervalidator_parametervalidationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE parametervalidator_parametervalidationid_seq OWNED BY "parameterValidator"."parameterValidationid";


--
-- TOC entry 175 (class 1259 OID 36867)
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
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE person; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE person IS 'Affiliated people who should be credited. (Optional)
Include a entry in this table for every person who contributed to an algorithm web service, who should to be credited.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN person.email; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN person.email IS 'Contact email for this person.';


--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN person.phonenumber; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN person.phonenumber IS 'Contact phone number for this person.';


--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN person."personID"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN person."personID" IS 'Unique ID for this person.';


--
-- TOC entry 176 (class 1259 OID 36870)
-- Dependencies: 175 6
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
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 176
-- Name: person_personid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE person_personid_seq OWNED BY person."personID";


--
-- TOC entry 177 (class 1259 OID 36872)
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
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE service; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON TABLE service IS 'Contains the connection information and description for a web service which has analysis algorithm methods which conform to the CVRG Type2 algorithm specification.

@author mshipwa1@jhu.edu
March 10, 2014';


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN service.serviceid; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN service.serviceid IS 'Primary key for the service table.';


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN service."uiName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN service."uiName" IS 'Human friendly name of the web service for displaying in the user interface.';


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN service."wsName"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN service."wsName" IS 'The web service’s name to be used in the URL when calling the service.   e.g. "physionetAnalysisService".  
';


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN service."wsUrl"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON COLUMN service."wsUrl" IS 'URL of the server containing the web services e.g. http://128.220.76.170:8080/axis2/services. 
This is used together with “service.wsName” and "algorithm.method”. e.g. http://128.220.76.170:8080/axis2/services/physionetAnalysisService/sqrsWrapperType2  
';


--
-- TOC entry 178 (class 1259 OID 36878)
-- Dependencies: 6 177
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
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 178
-- Name: service_serviceid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: liferay
--

ALTER SEQUENCE service_serviceid_seq OWNED BY service.serviceid;


--
-- TOC entry 2695 (class 2604 OID 36885)
-- Dependencies: 163 161
-- Name: algorithmid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithm ALTER COLUMN algorithmid SET DEFAULT nextval('algorithm_algorithmid_seq'::regclass);


--
-- TOC entry 2696 (class 2604 OID 36886)
-- Dependencies: 164 162
-- Name: algorithmPersonid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithmperson ALTER COLUMN "algorithmPersonid" SET DEFAULT nextval('algorithmperson_algorithmpersonid_seq'::regclass);


--
-- TOC entry 2708 (class 2604 OID 37245)
-- Dependencies: 182 181
-- Name: algorithmreferenceid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithmreference ALTER COLUMN algorithmreferenceid SET DEFAULT nextval('algorithmreference_algorithmreferenceid_seq'::regclass);


--
-- TOC entry 2697 (class 2604 OID 36887)
-- Dependencies: 167 165
-- Name: organizationID; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY organization ALTER COLUMN "organizationID" SET DEFAULT nextval('organization_organizationid_seq'::regclass);


--
-- TOC entry 2698 (class 2604 OID 36888)
-- Dependencies: 168 166
-- Name: organizationContactID; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "organizationContact" ALTER COLUMN "organizationContactID" SET DEFAULT nextval('organizationcontact_organizationcontactid_seq'::regclass);


--
-- TOC entry 2701 (class 2604 OID 36889)
-- Dependencies: 173 169
-- Name: parameterid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY parameter ALTER COLUMN parameterid SET DEFAULT nextval('parameters_parameterid_seq'::regclass);


--
-- TOC entry 2703 (class 2604 OID 36890)
-- Dependencies: 172 170
-- Name: parameteroptionid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "parameterOption" ALTER COLUMN parameteroptionid SET DEFAULT nextval('parameteroption_parameteroptionid_seq'::regclass);


--
-- TOC entry 2704 (class 2604 OID 36891)
-- Dependencies: 174 171
-- Name: parameterTypeid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "parameterType" ALTER COLUMN "parameterTypeid" SET DEFAULT nextval('parametertype_parametertypeid_seq'::regclass);


--
-- TOC entry 2707 (class 2604 OID 37067)
-- Dependencies: 180 179
-- Name: parameterValidationid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "parameterValidator" ALTER COLUMN "parameterValidationid" SET DEFAULT nextval('parametervalidator_parametervalidationid_seq'::regclass);


--
-- TOC entry 2705 (class 2604 OID 36892)
-- Dependencies: 176 175
-- Name: personID; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY person ALTER COLUMN "personID" SET DEFAULT nextval('person_personid_seq'::regclass);


--
-- TOC entry 2706 (class 2604 OID 36893)
-- Dependencies: 178 177
-- Name: serviceid; Type: DEFAULT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY service ALTER COLUMN serviceid SET DEFAULT nextval('service_serviceid_seq'::regclass);


--
-- TOC entry 2711 (class 2606 OID 36905)
-- Dependencies: 161 161 2849
-- Name: idAlgorithm; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY algorithm
    ADD CONSTRAINT "idAlgorithm" PRIMARY KEY (algorithmid);


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 2711
-- Name: CONSTRAINT "idAlgorithm" ON algorithm; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON CONSTRAINT "idAlgorithm" ON algorithm IS 'Primary Key for algorithm table.';


--
-- TOC entry 2715 (class 2606 OID 36907)
-- Dependencies: 162 162 2849
-- Name: idAlgorithmPerson; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY algorithmperson
    ADD CONSTRAINT "idAlgorithmPerson" PRIMARY KEY ("algorithmPersonid");


--
-- TOC entry 2717 (class 2606 OID 36909)
-- Dependencies: 165 165 2849
-- Name: idOrganization; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT "idOrganization" PRIMARY KEY ("organizationID");


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 2717
-- Name: CONSTRAINT "idOrganization" ON organization; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON CONSTRAINT "idOrganization" ON organization IS 'Primary Key of the organization table.';


--
-- TOC entry 2721 (class 2606 OID 36911)
-- Dependencies: 166 166 2849
-- Name: idOrganizationContact; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY "organizationContact"
    ADD CONSTRAINT "idOrganizationContact" PRIMARY KEY ("organizationContactID");


--
-- TOC entry 2725 (class 2606 OID 36913)
-- Dependencies: 169 169 2849
-- Name: idParameter; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT "idParameter" PRIMARY KEY (parameterid);


--
-- TOC entry 2727 (class 2606 OID 37056)
-- Dependencies: 170 170 2849
-- Name: idParameterOption; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY "parameterOption"
    ADD CONSTRAINT "idParameterOption" PRIMARY KEY (parameteroptionid);


--
-- TOC entry 2729 (class 2606 OID 36915)
-- Dependencies: 171 171 2849
-- Name: idParameterType; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY "parameterType"
    ADD CONSTRAINT "idParameterType" PRIMARY KEY ("parameterTypeid");


--
-- TOC entry 2731 (class 2606 OID 36917)
-- Dependencies: 175 175 2849
-- Name: idPerson; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT "idPerson" PRIMARY KEY ("personID");


--
-- TOC entry 2733 (class 2606 OID 36919)
-- Dependencies: 177 177 2849
-- Name: idService; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY service
    ADD CONSTRAINT "idService" PRIMARY KEY (serviceid);


--
-- TOC entry 2738 (class 2606 OID 37250)
-- Dependencies: 181 181 2849
-- Name: idalgorithmreference; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY algorithmreference
    ADD CONSTRAINT idalgorithmreference PRIMARY KEY (algorithmreferenceid);


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 2738
-- Name: CONSTRAINT idalgorithmreference ON algorithmreference; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON CONSTRAINT idalgorithmreference ON algorithmreference IS 'Primary Key for algorithmReference table.';


--
-- TOC entry 2735 (class 2606 OID 37387)
-- Dependencies: 179 179 2849
-- Name: parameterValidator_pkey; Type: CONSTRAINT; Schema: public; Owner: liferay; Tablespace: 
--

ALTER TABLE ONLY "parameterValidator"
    ADD CONSTRAINT "parameterValidator_pkey" PRIMARY KEY ("parameterValidationid");


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 2735
-- Name: CONSTRAINT "parameterValidator_pkey" ON "parameterValidator"; Type: COMMENT; Schema: public; Owner: liferay
--

COMMENT ON CONSTRAINT "parameterValidator_pkey" ON "parameterValidator" IS 'Primary key of parameterValidator';


--
-- TOC entry 2722 (class 1259 OID 36927)
-- Dependencies: 169 2849
-- Name: fki_idAlgorithm; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idAlgorithm" ON parameter USING btree (algorithmid);


--
-- TOC entry 2712 (class 1259 OID 36928)
-- Dependencies: 162 2849
-- Name: fki_idAlgorithmPersonAlg; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idAlgorithmPersonAlg" ON algorithmperson USING btree (algorithmid);


--
-- TOC entry 2713 (class 1259 OID 36929)
-- Dependencies: 162 2849
-- Name: fki_idAlgorithmPersonPerson; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idAlgorithmPersonPerson" ON algorithmperson USING btree (personid);


--
-- TOC entry 2718 (class 1259 OID 36930)
-- Dependencies: 166 2849
-- Name: fki_idOrganizationContactOrg; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idOrganizationContactOrg" ON "organizationContact" USING btree ("organizationID");


--
-- TOC entry 2719 (class 1259 OID 36931)
-- Dependencies: 166 2849
-- Name: fki_idOrganizationContactPerson; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idOrganizationContactPerson" ON "organizationContact" USING btree ("contactID");


--
-- TOC entry 2723 (class 1259 OID 36932)
-- Dependencies: 169 2849
-- Name: fki_idParameterType; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX "fki_idParameterType" ON parameter USING btree ("parameterTypeid");


--
-- TOC entry 2736 (class 1259 OID 37256)
-- Dependencies: 181 2849
-- Name: fki_idalgorithm; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX fki_idalgorithm ON algorithmreference USING btree (algorithmid);


--
-- TOC entry 2709 (class 1259 OID 36933)
-- Dependencies: 161 2849
-- Name: fki_service; Type: INDEX; Schema: public; Owner: liferay; Tablespace: 
--

CREATE INDEX fki_service ON algorithm USING btree (serviceid);


--
-- TOC entry 2739 (class 2606 OID 37020)
-- Dependencies: 161 2732 177 2849
-- Name: fkService; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithm
    ADD CONSTRAINT "fkService" FOREIGN KEY (serviceid) REFERENCES service(serviceid);


--
-- TOC entry 2744 (class 2606 OID 37129)
-- Dependencies: 169 161 2710 2849
-- Name: idAlgorithm; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT "idAlgorithm" FOREIGN KEY (algorithmid) REFERENCES algorithm(algorithmid);


--
-- TOC entry 2740 (class 2606 OID 37257)
-- Dependencies: 162 161 2710 2849
-- Name: idAlgorithmPersonAlg; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithmperson
    ADD CONSTRAINT "idAlgorithmPersonAlg" FOREIGN KEY (algorithmid) REFERENCES algorithm(algorithmid);


--
-- TOC entry 2741 (class 2606 OID 37262)
-- Dependencies: 162 175 2730 2849
-- Name: idAlgorithmPersonPerson; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithmperson
    ADD CONSTRAINT "idAlgorithmPersonPerson" FOREIGN KEY (personid) REFERENCES person("personID");


--
-- TOC entry 2742 (class 2606 OID 37035)
-- Dependencies: 165 166 2716 2849
-- Name: idOrganizationContactOrg; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "organizationContact"
    ADD CONSTRAINT "idOrganizationContactOrg" FOREIGN KEY ("organizationID") REFERENCES organization("organizationID");


--
-- TOC entry 2743 (class 2606 OID 37040)
-- Dependencies: 166 175 2730 2849
-- Name: idOrganizationContactPerson; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY "organizationContact"
    ADD CONSTRAINT "idOrganizationContactPerson" FOREIGN KEY ("contactID") REFERENCES person("personID");


--
-- TOC entry 2745 (class 2606 OID 37134)
-- Dependencies: 169 171 2728 2849
-- Name: idParameterType; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT "idParameterType" FOREIGN KEY ("parameterTypeid") REFERENCES "parameterType"("parameterTypeid");


--
-- TOC entry 2746 (class 2606 OID 37267)
-- Dependencies: 2710 181 161 2849
-- Name: idalgorithm; Type: FK CONSTRAINT; Schema: public; Owner: liferay
--

ALTER TABLE ONLY algorithmreference
    ADD CONSTRAINT idalgorithm FOREIGN KEY (algorithmid) REFERENCES algorithm(algorithmid);


-- Completed on 2014-07-09 17:18:08 EDT

--
-- PostgreSQL database dump complete
--

