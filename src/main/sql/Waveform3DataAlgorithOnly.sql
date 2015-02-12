--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.14
-- Dumped by pg_dump version 9.1.14
-- Started on 2015-02-12 14:50:09 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- TOC entry 2864 (class 0 OID 36872)
-- Dependencies: 177 2870
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: liferay
--

INSERT INTO service VALUES (2, 'icmv058', 'physionetAnalysisService', 'http://128.220.76.170:8080/axis2/services');
INSERT INTO service VALUES (3, 'QRS_Score', 'qrs_scoreAnalysisService', 'http://localhost:8080/axis2/services');
INSERT INTO service VALUES (4, 'BrandPhysionet', 'physionetAnalysisService', 'http://10.162.37.39:8080/axis2/services');
INSERT INTO service VALUES (1, 'LocalPhysionet', 'physionetAnalysisService', 'http://10.162.37.46:8080/axis2/services');


--
-- TOC entry 2848 (class 0 OID 36791)
-- Dependencies: 161 2864 2870
-- Data for Name: algorithm; Type: TABLE DATA; Schema: public; Owner: liferay
--

INSERT INTO algorithm VALUES (1, 'QT Screening', 'Chesnokov''s QT Screening algorithm.', 'This program analyses a WFDB formatted ECG file and finds Total Beat count, Ectopic Beat count, Corrected QT Interval, Log of the QTV. It also finds the Interval Count, Mean Interval, Variance and Standard Deviation for both RR and QT intervals.  Original code at: http://www.codeproject.com/Articles/20995/ECG-Annotation-C-Library', 'chesnokovWrapperType2', 45, NULL);
INSERT INTO algorithm VALUES (1, 'sqrs2csv', 'Attempts to locate QRS complexes in an ECG signal in the specified record. The detector algorithm is based on the length transform. Reads the ann...', 'Attempts to locate QRS complexes in an ECG signal in the specified record. The detector algorithm is based on the length transform. Reads the annotation file specified by record and annotator and writes a comma-separated-value format translation of it, one annotation per line.', 'sqrs2csvWrapperType2', 49, 'CSV');
INSERT INTO algorithm VALUES (1, 'rdsamp', 'reads a WFDB file and writes it in human readable format', 'rdsamp reads signal files for the specified record and writes the samples 
as decimal numbers on the standard output. If no options are provided, 
rdsamp starts at the beginning of the record and prints all samples. 
By default, each line of output contains the sample number and samples 
from each signal, beginning with channel 0, separated by tabs.', 'rdsampWrapperType2', 46, NULL);
INSERT INTO algorithm VALUES (1, 'sigamp', 'Measure signal amplitudes of a WFDB record.', 'sigamp measures either baseline-corrected RMS amplitudes or (for suitably annotated ECG signals)  
 normal QRS peak-to-peak amplitudes for all signals of the specified record.  
 It makes up to 300 measurements (but see -n below) for each signal and calculates trimmed means  
 (by discarding the largest and smallest 5% of the measurements and taking the mean of the remaining 90%).', 'sigampWrapperType2', 47, NULL);
INSERT INTO algorithm VALUES (1, 'sqrs4ihr', 'Produces an instantaneous heart rate signal from a Single-channel QRS detector.', 'Produces an instantaneous heart rate signal from a Single-channel QRS detector (from the reciprocals of the interbeat intervals.) Unlike tach(1) , however, ihr does not resample its output in order to obtain uniform time intervals between output samples. (If there is any variation whatsoever in heart rate, the intervals between output samples will be non-uniform.) This property makes the output of ihr unsuitable for conventional power spectral density estimation, but ideal for PSD estimation using the Lomb periodogram (see lomb(1) ).', 'sqrs4ihrWrapperType2', 50, NULL);
INSERT INTO algorithm VALUES (1, 'wqrs2csv', 'Attempts to locate QRS complexes in an ECG signal in the specified record and reads the annotation file specified by record and annotator and wri...', 'Attempts to locate QRS complexes in an ECG signal in the specified record and reads the annotation file specified by record and annotator and writes a comma-separated-value format translation of it, one annotation per line.', 'wqrs2csvWrapperType2', 53, 'CSV');
INSERT INTO algorithm VALUES (1, 'sqrs4pnnlist/pNNx', 'Calculates time domain measures of heart rate variability from a Single-channel QRS detector.', 'Calculates time domain measures of heart rate variability from a Single-channel QRS detector (from the reciprocals of the interbeat intervals). These programs derive pNNx, time domain measures of heart rate variability defined for any time interval x as the fraction of consecutive normal sinus (NN) intervals that differ by more than x.Conventionally, such measures have been applied to assess parasympathetic activity using x = 50 milliseconds (yielding the widely-cited pNN50 statistic).', 'sqrs4pnnlistWrapperType2', 51, 'CSV');
INSERT INTO algorithm VALUES (1, 'wqrs4pnnlist/pNNx', 'Calculates time domain measures of heart rate variability from a Single-channel QRS detector.', 'Calculates time domain measures of heart rate variability from a Single-channel QRS detector (from the reciprocals of the interbeat intervals). These programs derive pNNx, time domain measures of heart rate variability defined for any time interval x as the fraction of consecutive normal sinus (NN) intervals that differ by more than x.Conventionally, such measures have been applied to assess parasympathetic activity using x = 50 milliseconds (yielding the widely-cited pNN50 statistic).', 'wqrs4pnnlistWrapperType2', 55, 'CSV');
INSERT INTO algorithm VALUES (1, 'wqrs', 'single-channel QRS detector based on length transform.', 'wqrs attempts to locate QRS complexes in an ECG signal in the specified record. The detector algorithm is based on the length transform. The output of wqrs is an annotation file (with annotator name wqrs) in which all detected beats are labelled normal; the annotation file will also contain optional J-point annotations if the -j option (see below) is used. 
 wqrs can process records containing any number of signals, but it uses only one signal for QRS detection (signal 0 by default; this can be changed using the -s option, see below). wqrs is optimized for use with adult human ECGs. For other ECGs, it may be necessary to experiment with the sampling frequency as recorded in the input record''s header file (see header(5) ), the detector threshold (which can be set using the -m option), and the time constants indicated in the source file. 
 wqrs optionally uses the WFDB library''s setifreq function to resample the input signal at 120 or 150 Hz (depending on the mains frequency, which can be specified using the -p option). wqrs performs well using input sampled at a range of rates up to 360 Hz and possibly higher rates, but it has been designed and tested to work best on signals sampled at 120 or 150 Hz.', 'wqrsWrapperType2', 52, 'WFDBAnnotation');
INSERT INTO algorithm VALUES (3, 'QRS-Score', 'Strauss-Selvester QRS-Score', 'Strauss-Selvester QRS-Score', 'qrs_scoreWrapperType2', 56, 'CSV');
INSERT INTO algorithm VALUES (1, 'wqrs4ihr', 'Produces an instantaneous heart rate signal from a Single-channel QRS detector.', 'Produces an instantaneous heart rate signal from a Single-channel QRS detector (from the reciprocals of the interbeat intervals.) Unlike tach(1) , however, ihr does not resample its output in order to obtain uniform time intervals between output samples. (If there is any variation whatsoever in heart rate, the intervals between output samples will be non-uniform.) This property makes the output of ihr unsuitable for conventional power spectral density estimation, but ideal for PSD estimation using the Lomb periodogram (see lomb(1) ).', 'wqrs4ihrWrapperType2', 54, 'CSV');
INSERT INTO algorithm VALUES (1, 'Galaxy sqrs/wqrs', 'TEST of calling Galaxy workflow from Waveform', 'REPLACE', 'galaxy_sqrs_wqrsWrapperType3', 66, NULL);
INSERT INTO algorithm VALUES (1, 'sqrs', 'Single-channel QRS detector.', 'sqrs attempts to locate QRS complexes in an ECG signal in the specified record. The detector algorithm is based on example 10 in the WFDB Programmer''s Guide, which in turn is based on a Pascal program written by W.A.H. Engelse and C. Zeelenberg, "A single scan algorithm for QRS-detection and feature extraction", Computers in Cardiology 6:37-42 (1979). sqrs does not include the feature extraction capability of the Pascal program. The output of sqrs is an annotation file (with annotator name qrs) in which all detected beats are labelled normal; the annotation file may also contain "artifact" annotations at locations that sqrs believes are noise-corrupted.
 sqrs can process records containing any number of signals, but it uses only one signal for QRS detection (signal 0 by default; this can be changed using the -s option, see below). sqrs is optimized for use with adult human ECGs. For other ECGs, it may be necessary to experiment with the sampling frequency as recorded in the input record''s header file (see header(5) ) and the time constants indicated in the source file.
 sqrs uses the WFDB library''s setifreq function to resample the input signal at 250 Hz if a significantly different sampling frequency is indicated in the header file. sqrs125 is identical to sqrs except that its filter and time constants have been designed for 125 Hz input, so that its speed is roughly twice that of sqrs. If the input signal has been sampled at a frequency near 125 Hz, the quality of the outputs of sqrs and sqrs125 will be nearly identical. (Note that older versions of these programs did not resample their inputs; rather, they warned if the sampling frequency was significantly different than the ideal frequency, and suggested using xform(1) to resample the input.)
 This program is provided as an example only, and is not intended for any clinical application. At the time the algorithm was originally published, its performance was typical of state-of-the-art QRS detectors. Recent designs, particularly those that can analyze two or more input signals, may exhibit significantly better performance.', 'sqrsWrapperType2', 48, NULL);


--
-- TOC entry 2874 (class 0 OID 0)
-- Dependencies: 163
-- Name: algorithm_algorithmid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('algorithm_algorithmid_seq', 66, true);


--
-- TOC entry 2862 (class 0 OID 36867)
-- Dependencies: 175 2870
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: liferay
--



--
-- TOC entry 2849 (class 0 OID 36797)
-- Dependencies: 162 2848 2862 2870
-- Data for Name: algorithmperson; Type: TABLE DATA; Schema: public; Owner: liferay
--



--
-- TOC entry 2875 (class 0 OID 0)
-- Dependencies: 164
-- Name: algorithmperson_algorithmpersonid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('algorithmperson_algorithmpersonid_seq', 1, false);


--
-- TOC entry 2868 (class 0 OID 37240)
-- Dependencies: 181 2848 2870
-- Data for Name: algorithmreference; Type: TABLE DATA; Schema: public; Owner: liferay
--

INSERT INTO algorithmreference VALUES (1, 45, 'n/a', NULL, 'n/a', NULL, 'n/a', 'http://wiki.cvrgrid.org/index.php/ECG_Gadget_User_Guide#QT_Screening_Algorithm_Results_File_Example');
INSERT INTO algorithmreference VALUES (3, 46, 'n/a', NULL, '2.0', '2012-12-04', 'http://physionet.org/physiotools/wag/wag.htm', 'http://www.physionet.org/physiotools/wag/sigamp-1.htm');
INSERT INTO algorithmreference VALUES (4, 47, 'n/a', NULL, '2.0', '2012-12-04', 'http://physionet.org/physiotools/wag/wag.htm', 'http://www.physionet.org/physiotools/wag/sigamp-1.htm');
INSERT INTO algorithmreference VALUES (5, 48, 'n/a', NULL, '2.0', '2012-11-16', 'http://physionet.org/physiotools/wag/wag.htm', 'http://www.physionet.org/physiotools/wag/sqrs-1.htm');
INSERT INTO algorithmreference VALUES (6, 50, 'n/a', NULL, '2.0', '2014-02-10', 'http://physionet.org/physiotools/wag/wag.htm', 'http://www.physionet.org/physiotools/wag/ihr-1.htm');
INSERT INTO algorithmreference VALUES (8, 49, 'n/a', NULL, '2.0', '2014-02-03', 'http://physionet.org/physiotools/wag/wag.htm', 'http://www.physionet.org/physiotools/wag/sqrs-1.htm');
INSERT INTO algorithmreference VALUES (9, 51, 'n/a', NULL, '2.0', '2014-02-10', 'http://physionet.org/physiotools/wag/wag.htm', 'http://physionet.org/physiotools/wag/pnnlis-1.htm');
INSERT INTO algorithmreference VALUES (10, 52, 'n/a', NULL, '2.0', '2012-12-03', 'http://physionet.org/physiotools/wag/wag.htm', 'http://www.physionet.org/physiotools/wag/wqrs-1.htm');
INSERT INTO algorithmreference VALUES (11, 53, 'n/a', NULL, '2.0', '2014-02-03', 'http://physionet.org/physiotools/wag/wag.htm', 'http://www.physionet.org/physiotools/wag/wqrs-1.htm');
INSERT INTO algorithmreference VALUES (12, 54, 'n/a', NULL, '2.0', '2014-02-10', 'http://physionet.org/physiotools/wag/wag.htm', 'http://www.physionet.org/physiotools/wag/ihr-1.htm');
INSERT INTO algorithmreference VALUES (13, 55, 'n/a', NULL, '2.0', '2014-02-10', 'http://physionet.org/physiotools/wag/wag.htm', 'http://physionet.org/physiotools/wag/pnnlis-1.htm');
INSERT INTO algorithmreference VALUES (14, 56, 'n/a', NULL, 'n/a', NULL, 'n/a', 'n/a');
INSERT INTO algorithmreference VALUES (850, 66, 'n/a', NULL, 'n/a', NULL, 'n/a', 'n/a');


--
-- TOC entry 2876 (class 0 OID 0)
-- Dependencies: 182
-- Name: algorithmreference_algorithmreferenceid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('algorithmreference_algorithmreferenceid_seq', 17, true);


--
-- TOC entry 2852 (class 0 OID 36830)
-- Dependencies: 165 2870
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: liferay
--



--
-- TOC entry 2853 (class 0 OID 36836)
-- Dependencies: 166 2852 2862 2870
-- Data for Name: organizationContact; Type: TABLE DATA; Schema: public; Owner: liferay
--



--
-- TOC entry 2877 (class 0 OID 0)
-- Dependencies: 167
-- Name: organization_organizationid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('organization_organizationid_seq', 1, false);


--
-- TOC entry 2878 (class 0 OID 0)
-- Dependencies: 168
-- Name: organizationcontact_organizationcontactid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('organizationcontact_organizationcontactid_seq', 1, false);


--
-- TOC entry 2858 (class 0 OID 36858)
-- Dependencies: 171 2870
-- Data for Name: parameterType; Type: TABLE DATA; Schema: public; Owner: liferay
--

INSERT INTO "parameterType" VALUES (1, 'text', 'Can take on any text value.');
INSERT INTO "parameterType" VALUES (2, 'integer', 'Takes only an integer number value.');
INSERT INTO "parameterType" VALUES (3, 'float', 'Takes a real number value.');
INSERT INTO "parameterType" VALUES (4, 'boolean', 'Takes a true or false, e.g. a checkbox, true=checked');
INSERT INTO "parameterType" VALUES (5, 'select', 'Takes on one (or many) or a specific set of values. Requires a Parameter Option list below.');
INSERT INTO "parameterType" VALUES (6, 'drill down', 'Takes on one (or many) of a specific set of values. Creating a hierarchical select menu, which allows users to "drill down" a set of options.');
INSERT INTO "parameterType" VALUES (7, 'data_column', '');


--
-- TOC entry 2856 (class 0 OID 36843)
-- Dependencies: 169 2848 2858 2870
-- Data for Name: parameter; Type: TABLE DATA; Schema: public; Owner: liferay
--

INSERT INTO parameter VALUES (336, 46, 'Begin time(seconds)', 'Begin time(seconds)', 'Begin at the specified time in record (default: the beginning of record).', 'f', '0', 3, false, false, -1);
INSERT INTO parameter VALUES (337, 46, 'Stop Time(seconds)', 'Stop Time(seconds)', 'Stop at the specified time. By default, rdsamp stops at the end of the record.', 't', '-1', 3, false, false, -1);
INSERT INTO parameter VALUES (338, 46, 'Interval limit(seconds)', 'Interval limit(seconds)', 'Limit the amount of output to the specified time interval (in standard time format; default: no limit). If both -l and -t are used, rdsamp stops at the earlier of the two limits', 'l', '-1', 3, false, false, -1);
INSERT INTO parameter VALUES (339, 46, 'CSV Format', 'CSV Format', 'Produce output in CSV (comma-separated value) format (default: write output in tab-separated columns).', 'c', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (340, 46, 'High Res', 'High Res', 'Read the signal files in high-resolution mode (default: standard mode). These modes are identical for ordinary records. For multifrequency records, the standard decimation of oversampled signals to the frame rate is suppressed in high-resolution mode (rather, all other signals are resampled at the highest sampling frequency).', 'H', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (341, 46, 'Format output', 'Format output', 'Output times in the selected format and the values in physical units. By default, rdsamp prints times in sample intervals and values in A/D units.', 'format', '', 5, false, false, -1);
INSERT INTO parameter VALUES (342, 46, 'Signal List.', 'Signal List.', 'Print only the signals named in the signal-list (one or more input signal numbers or names, separated by spaces; default: print all signals). This option may be used to re-order or duplicate signals.', 's', '', 1, false, false, -1);
INSERT INTO parameter VALUES (343, 46, 'Signal', 'Signal', 'Search for the first valid sample of the specified signal (a signal name or number) at or following the time specified with -f (or the beginning of the record if the -f option is not present), and begin printing at that time.', 'S', '', 1, false, false, -1);
INSERT INTO parameter VALUES (344, 46, 'Column Headings', 'Column Headings', 'Print column headings (signal names on the first line, units on the second). The names of some signals are too wide to fit in the columns; such names are shortened by omitting the initial characters (since names of related signals often differ only at the end, this helps to make the columns identifiable). Names of units are shortened when necessary by omitting the final characters, since the initial characters are usually most important for distinguishing different units. ', 'v', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (345, 46, 'XML', 'XML', 'Produce output in WFDB-XML format (same as the CSV format produced using the -c option, but wrapped within an XML header and trailer). This format is recognized and parsed automatically by wrsamp.', 'X', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (346, 47, 'Begin time (sec)', 'Begin time (sec)', 'Begin at the specified time in record (default: the beginning of record).', 'f', '0', 3, false, false, -1);
INSERT INTO parameter VALUES (347, 47, 'End time (sec)', 'End time (sec)', 'Process until the specified time in record (default: the end of the record). ', 't', '-1', 3, false, false, -1);
INSERT INTO parameter VALUES (348, 47, 'High Res', 'High Res', 'Read the signal files in high-resolution mode (default: standard mode). These modes are identical for ordinary records. For multifrequency records, the standard decimation of oversampled signals to the frame rate is suppressed in high-resolution mode (rather, all other signals are resampled at the highest sampling frequency).', 'H', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (349, 47, 'annotator', 'annotator', 'Measure QRS peak-to-peak amplitudes based on normal QRS annotations from the specified annotator. Where this appears, substitute an annotator name. Annotator names are not file names! The suffix (extension) of the name of an annotation file is the annotator name for that file; so, for example, the annotator name for `e0104.atr'' is `atr''. The special annotator name `atr'' is used to name the set of reference annotations supplied by the database developers. Other annotation sets have annotator names that may contain letters, digits, and underscores, as for record names. ', 'a', '', 1, false, false, -1);
INSERT INTO parameter VALUES (350, 47, 'measurement window start d...', 'measurement window start delta', 'Set the measurement window start point relative to QRS annotations. Defaults: 0.05 (seconds before the annotation). ', 'dt1', '0.05', 3, false, false, -1);
INSERT INTO parameter VALUES (351, 47, 'measurement window end del...', 'measurement window end delta', 'Set the measurement window end point relative to QRS annotations. Defaults: 0.05 (seconds after the annotation). ', 'dt2', '0.05', 3, false, false, -1);
INSERT INTO parameter VALUES (352, 47, 'Set RMS amplitude measurem...', 'Set RMS amplitude measurement window.', 'Set RMS amplitude measurement window. Default: dtw = 1 (second)', 'w', '1', 3, false, false, -1);
INSERT INTO parameter VALUES (353, 47, 'Measurement count', 'Measurement count', 'Make up to nmax measurements on each signal (default: 300). ', 'n', '300', 2, false, false, -1);
INSERT INTO parameter VALUES (354, 47, 'Print results in physical ...', 'Print results in physical units.', 'Return physical units(default: ADC units) + elapsed time in seconds(same as -ps). (used with -q and -v when printing individual measurements);', 'p', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (355, 47, 'time of day and date', 'time of day and date', 'Return physical units + time of day and date if known', 'pd', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (356, 47, 'Elapsed time.', 'Elapsed time.', 'Return physical units + elapsed time as <hours>:<minutes>:<seconds>', 'pe', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (357, 47, 'Hours', 'Hours', 'Return physical units + elapsed time in hours.', 'ph', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (358, 47, 'Minutes', 'Minutes', 'Return physical units + elapsed time in minute', 'pm', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (359, 47, 'Seconds', 'Seconds', 'Return physical units + elapsed time in seconds(default, same as -p)', 'ps', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (360, 47, 'Samples', 'Samples', 'Return physical units + elapsed time in sample intervals.', 'pS', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (361, 47, 'Quick mode.', 'Quick mode.', 'Quick mode: print individual measurements only, not trimmed means.', 'q', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (362, 47, 'Verbose mode', 'Verbose mode', 'Verbose mode: print individual measurements as well as trimmed means.', 'v', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (363, 48, 'Begin time(seconds)', 'Begin time(seconds)', 'Begin at the specified time in record (default: the beginning of record).', 'f', '0', 3, false, false, -1);
INSERT INTO parameter VALUES (364, 48, 'End time(seconds)', 'End time(seconds)', 'Process until the specified time in record (default: the end of the record). ', 't', '-1', 3, false, false, -1);
INSERT INTO parameter VALUES (365, 48, 'High Res', 'High Res', 'Read the signal files in high-resolution mode (default: standard mode). These modes are identical for ordinary records. For multifrequency records, the standard decimation of oversampled signals to the frame rate is suppressed in high-resolution mode (rather, all other signals are resampled at the highest sampling frequency).', 'H', 'false', 4, true, false, -1);
INSERT INTO parameter VALUES (366, 48, 'Threshold', 'Threshold', 'Specify the detection threshold (default: 500 units); use higher values to reduce false detections, or lower values to reduce the number of missed beats.', 'm', '500', 2, false, false, -1);
INSERT INTO parameter VALUES (367, 48, 'Signal', 'Signal', 'Specify the signal (number or name) to be used for QRS detection (default: 0).', 's', '0', 2, true, false, -1);
INSERT INTO parameter VALUES (368, 52, 'Dump the raw', 'Dump the raw', 'Dump the raw and length-transformed input samples in text format on the standard output, but do not detect or annotate QRS complexes.', 'd', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (369, 52, 'Begin time (sec)', 'Begin time (sec)', 'Begin at the specified time in record (default: the beginning of record).', 'f', '0', 3, false, false, -1);
INSERT INTO parameter VALUES (370, 52, 'Print a brief usage (help)...', 'Print a brief usage (help) summary.', 'Print a brief usage (help) summary.', 'h', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (371, 52, 'High Res', 'High Res', 'Read the signal files in high-resolution mode (default: standard mode). These modes are identical for ordinary records. For multifrequency records, the standard decimation of oversampled signals to the frame rate is suppressed in high-resolution mode (rather, all other signals are resampled at the highest sampling frequency).', 'H', 'false', 4, true, false, -1);
INSERT INTO parameter VALUES (372, 52, 'Annotate J-points', 'Annotate J-points', 'Find and annotate J-points (QRS ends) as well as QRS onsets.', 'j', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (373, 52, 'Threshold', 'Threshold', 'Specify the detection threshold (default: 100 microvolts); use higher values to reduce false detections, or lower values to reduce the number of missed beats.', 'm', '100', 2, false, false, -1);
INSERT INTO parameter VALUES (374, 52, 'Power line frequency.', 'Power line frequency.', 'Specify the power line (mains) frequency used at the time of the recording, in Hz (default: 60). wqrs will apply a notch filter of the specified frequency to the input signal before length-transforming it.', 'p', '60', 2, false, false, -1);
INSERT INTO parameter VALUES (375, 52, 'Resample the input.', 'Resample the input.', 'Resample the input at 120 Hz if the power line frequency is 60 Hz, or at 150 Hz otherwise (default: do not resample).', 'R', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (376, 52, 'Signal', 'Signal', 'Specify the signal (number or name) to be used for QRS detection (default: 0).', 's', '0', 2, true, false, -1);
INSERT INTO parameter VALUES (377, 52, 'End time (sec)', 'End time (sec)', 'Process until the specified time in record (default: the end of the record).', 't', '-1', 3, false, false, -1);
INSERT INTO parameter VALUES (378, 52, 'Verbose mode', 'Verbose mode', 'Verbose mode: print information about the detector parameters.', 'v', 'false', 4, false, false, -1);
INSERT INTO parameter VALUES (501, 45, 'REPLACE 501', ' REPLACE 501', 'REPLACE 501', 'REPLACE', 'REPLACE', 1, true, false, 2);
INSERT INTO parameter VALUES (500, 45, 'REPLACE', 'REPLACE', 'REPLACE CCC', NULL, 'REPLACE', 1, true, false, 3);


--
-- TOC entry 2857 (class 0 OID 36851)
-- Dependencies: 170 2870
-- Data for Name: parameterOption; Type: TABLE DATA; Schema: public; Owner: liferay
--



--
-- TOC entry 2866 (class 0 OID 37057)
-- Dependencies: 179 2870
-- Data for Name: parameterValidator; Type: TABLE DATA; Schema: public; Owner: liferay
--

INSERT INTO "parameterValidator" VALUES (0, 'no validator', 0, 0, '""', -1);
INSERT INTO "parameterValidator" VALUES (2, 'Dummy range', 1, 10, '""', 2);
INSERT INTO "parameterValidator" VALUES (3, 'Dummy Text Length Limits', 5, 20, '""', 3);


--
-- TOC entry 2879 (class 0 OID 0)
-- Dependencies: 172
-- Name: parameteroption_parameteroptionid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parameteroption_parameteroptionid_seq', 1, false);


--
-- TOC entry 2880 (class 0 OID 0)
-- Dependencies: 173
-- Name: parameters_parameterid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parameters_parameterid_seq', 11, true);


--
-- TOC entry 2881 (class 0 OID 0)
-- Dependencies: 174
-- Name: parametertype_parametertypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parametertype_parametertypeid_seq', 6, true);


--
-- TOC entry 2882 (class 0 OID 0)
-- Dependencies: 180
-- Name: parametervalidator_parametervalidationid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('parametervalidator_parametervalidationid_seq', 3, true);


--
-- TOC entry 2883 (class 0 OID 0)
-- Dependencies: 176
-- Name: person_personid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('person_personid_seq', 1, false);


--
-- TOC entry 2884 (class 0 OID 0)
-- Dependencies: 178
-- Name: service_serviceid_seq; Type: SEQUENCE SET; Schema: public; Owner: liferay
--

SELECT pg_catalog.setval('service_serviceid_seq', 4, true);


-- Completed on 2015-02-12 14:50:09 EST

--
-- PostgreSQL database dump complete
--

