package edu.jhu.cvrg.data.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;

public class DataStorageProperties {

	private static String PROPERTIES_PATH = "/conf/dbutility.properties";
	private static Properties prop;
	private static DataStorageProperties singleton;
	private static File propertiesFile = null;
	private static long lastChange = 0;
	private static Logger log = Logger.getLogger(DataStorageProperties.class);

	private DataStorageProperties() {
		prop = new Properties();
		
		String catalinaHome = System.getProperty("catalina.home");
		if(catalinaHome == null){
			catalinaHome = "/opt/liferay/waveform3/tomcat-7.0.27";
			log.warn("catalina.home not found, using the default value \""+catalinaHome+"\"");
		}
		
		propertiesFile = new File(catalinaHome+PROPERTIES_PATH);
		loadProperties();
	}
	
	public static DataStorageProperties getInstance(){
		if(singleton == null){
			singleton = new DataStorageProperties();
		}
		return singleton;
	}
	
	public String getProperty(String propertyName){
		loadProperties();
		return prop.getProperty(propertyName);
	}
	
	private void loadProperties(){
		try {
			if(hasChanges()){
				prop.clear();
				prop.load(new FileReader(propertiesFile));
				lastChange = propertiesFile.lastModified();
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public boolean hasChanges() {
		return propertiesFile.lastModified() > lastChange;
	}
	
	
	public static final String EXISTS_DB_USER = "dbUser";
	public static final String EXISTS_DB_PASSWORD = "dbPassword";
	public static final String EXISTS_DB_URI = "dbURI";
	public static final String EXISTS_DB_MAIN_DATABASE = "dbMainDatabase";
	public static final String EXISTS_DB_ANALYSIS_DATABASE_NAME = "dbAnalysisDatabase";
	public static final String EXISTS_DB_ANALYSIS_RESULTS = "dbAnalysisResults";
	public static final String EXISTS_DB_DRIVER = "dbDriver";
	public static final String HIBERNATE_DRIVER_CLASS = "jdbc.default.driverClassName";
	public static final String HIBERNATE_DB_URL = "jdbc.default.url";
	public static final String HIBERNATE_DB_PASSWORD = "jdbc.default.password";
	public static final String HIBERNATE_DB_USERNAME = "jdbc.default.username";
	public static final String HIBERNATE_SHOW_SQL = "hibernate.show_sql";
	public static final String HIBERNATE_C3P0_MIN_SIZE = "hibernate.c3p0.minPoolSize";
	public static final String HIBERNATE_C3P0_MAX_SIZE = "hibernate.c3p0.maxPoolSize";
	public static final String HIBERNATE_C3P0_TIMEOUT = "hibernate.c3p0.checkoutTimeout";
	public static final String HIBERNATE_C3P0_MAX_STATEMENTS = "hibernate.c3p0.maxStatementsPerConnection";
	public static final String HIBERNATE_C3P0_MAX_IDLE_TIME = "hibernate.c3p0.maxIdleTime";
}
