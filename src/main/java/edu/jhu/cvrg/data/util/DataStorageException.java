package edu.jhu.cvrg.data.util;

import org.apache.log4j.Logger;

public class DataStorageException extends Exception {
	
	private static final long serialVersionUID = 4558455767594315866L;
	
	private Logger log = Logger.getLogger(DataStorageException.class);
	
	public DataStorageException() {
	}

	public DataStorageException(String message) {
		super(message);
	}

	public DataStorageException(Throwable cause) {
		super(cause);
	}

	public DataStorageException(String message, Throwable cause) {
		super(message, cause);
		log.error(message + " - " + cause.getMessage());
	}

}



