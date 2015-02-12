cvrg-dataStorage
================
This project represents the cvrg data storage utilities classes.

With these classes you will manage the waveform 3 data, at the storage environments below:

	Relational data base with hibernate

Make sure that /opt/liferay/waveform3/tomcat-7.0.27/conf/dbutilities.properties contains the following line:
	"jdbc.default.url=jdbc:postgresql://localhost:5432/waveform3"
to tell it to use the "waveform3" database.

To create the waveform3 database, run the following script from the Unix command line:
su postgres

Creates the "waveform3" database.
psql -f (location of src/main/sql/CreateWaveform3Database.sql) 

To run configure the database, run the following three scripts from the Unix command line:
su postgres

Drops and then Adds the non-algorithm SEQUENCE, INDEX, and TABLE elements. 
psql -f (location of src/main/sql/DatabaseScript.sql) –d waveform3

Adds the algorithm specific SEQUENCE, INDEX, and TABLE elements, plus documentation.
psql -f (location of src/main/sql/Waveform3DatabaseAlgorithmOnly.sql) –d waveform3

Inserts the current algorithm description data, which is used by the Analysis portlet to build the UI and to execute analyses.
psql -f (location of src/main/sql/Waveform3DataAlgorithmOnly.sql) –d waveform3

Optional, drops algorithm specific TABLE elements. Used it database schema has been updated.
psql -f (location of src/main/sql/Waveform3DropAlgorithmOnly.sql) –d waveform3

## Dependencies

* log4j-1.2.17
* hibernate-core-4.2.8.Final
* postgresql-9.3
* cvrg-analysisHub-1.0SNAPSHOT
