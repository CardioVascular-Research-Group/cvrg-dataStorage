--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.12
-- Dumped by pg_dump version 9.1.12
-- Started on 2014-04-25 13:07:58 EDT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

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
-- TOC entry 2889 (class 0 OID 36791)
-- Dependencies: 161 2914 2920
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
-- TOC entry 2912 (class 0 OID 36867)
-- Dependencies: 184 2920
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY person (firstname, lastname, middlename, email, phonenumber, "personID") FROM stdin;
\.


--
-- TOC entry 2890 (class 0 OID 36797)
-- Dependencies: 162 2889 2912 2920
-- Data for Name: algorithmPerson; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY "algorithmPerson" ("algorithmID", "personID", "algorithmPersonID") FROM stdin;
\.


--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 163
-- Name: algorithm_algorithmid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('algorithm_algorithmid_seq', 55, true);


--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 164
-- Name: algorithmperson_algorithmpersonid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('algorithmperson_algorithmpersonid_seq', 1, false);


--
-- TOC entry 2899 (class 0 OID 36822)
-- Dependencies: 171 2920
-- Data for Name: documentrecord; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY documentrecord (documentrecordid, recordname, userid, subjectid, originalformat, samplingrate, filetreepath, leadcount, numberofpoints, dateofupload, age, gender, dateofrecording, adugain) FROM stdin;
\.


--
-- TOC entry 2893 (class 0 OID 36804)
-- Dependencies: 165 2899 2920
-- Data for Name: analysisjob; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY analysisjob (analysisjobid, filecount, documentrecordid, parametercount, serviceurl, servicename, servicemethod, userid, dateofanalysis) FROM stdin;
\.


--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 166
-- Name: analyzejob_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('analyzejob_sequence', 1, false);


--
-- TOC entry 2897 (class 0 OID 36817)
-- Dependencies: 169 2920
-- Data for Name: coordinate; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY coordinate (coordinateid, xcoordinate, ycoordinate) FROM stdin;
\.


--
-- TOC entry 2895 (class 0 OID 36809)
-- Dependencies: 167 2893 2899 2897 2897 2920
-- Data for Name: annotationinfo; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY annotationinfo (annotationid, createdby, annotationtype, name, bioportalreferencelink, bioportalclassid, bioportalontology, leadindex, startingcoordinateid, endingcoordinateid, unitofmeasurement, description, value, documentrecordid, "timestamp", analysisjobid) FROM stdin;
\.


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 168
-- Name: annotationinfo_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('annotationinfo_sequence', 28646, false);


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 170
-- Name: coordinate_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('coordinate_sequence', 61353, false);


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 172
-- Name: documentrecord_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('documentrecord_sequence', 1966, false);


--
-- TOC entry 2901 (class 0 OID 36827)
-- Dependencies: 173 2893 2899 2920
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
-- Dependencies: 175 2902 2912 2920
-- Data for Name: organizationContact; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY "organizationContact" ("organizationContactID", "organizationID", "contactID") FROM stdin;
\.


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 176
-- Name: organization_organizationid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('organization_organizationid_seq', 1, false);


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 177
-- Name: organizationcontact_organizationcontactid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('organizationcontact_organizationcontactid_seq', 1, false);


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
-- TOC entry 2906 (class 0 OID 36843)
-- Dependencies: 178 2889 2908 2920
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
-- TOC entry 2918 (class 0 OID 37057)
-- Dependencies: 190 2920
-- Data for Name: parameterValidator; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY "parameterValidator" ("validatorType", message, min, max, regex, "parameterValidationid") FROM stdin;
0	no validator	\N	\N	\N	-1
\.


--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 181
-- Name: parameteroption_parameteroptionid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parameteroption_parameteroptionid_seq', 1, false);


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 182
-- Name: parameters_parameterid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parameters_parameterid_seq', 7, true);


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 183
-- Name: parametertype_parametertypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parametertype_parametertypeid_seq', 6, true);


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 191
-- Name: parametervalidator_parametervalidationid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parametervalidator_parametervalidationid_seq', 1, false);


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 185
-- Name: person_personid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('person_personid_seq', 1, false);


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 187
-- Name: service_serviceid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('service_serviceid_seq', 2, true);


--
-- TOC entry 2916 (class 0 OID 36880)
-- Dependencies: 188 2899 2920
-- Data for Name: uploadstatus; Type: TABLE DATA; Schema: public; Owner: liferay
--

COPY uploadstatus (uploadstatusid, filetransfer, fileconversion, recordcreation, annotationcreation, documentrecordid) FROM stdin;
\.


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 189
-- Name: uploadstatus_sequence; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('uploadstatus_sequence', 1, false);


-- Completed on 2014-04-25 13:07:58 EDT

--
-- PostgreSQL database dump complete
--

