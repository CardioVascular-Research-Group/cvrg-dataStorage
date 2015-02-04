dbutility
=========
Make sure that /opt/liferay/waveform3/tomcat-7.0.27/conf/dbutilities.properties contains the following line:
	"jdbc.default.url=jdbc:postgresql://localhost:5432/waveform3"
to tell it to use the "waveform3" database.

To create the waveform3 database, run the following script from the Unix command line:
su postgres

psql -f (location of CreateWaveform3Database.sql) 

To run configure the database, run the following three scripts from the Unix command line:
su postgres

psql –f (location of DatabaseScript.sql) –d waveform3

psql –f (location of Waveform3DatabaseAlgorithmOnly.sql) –d waveform3

psql –f (location of Waveform3DataAlgorithmOnly.sql) –d waveform3

