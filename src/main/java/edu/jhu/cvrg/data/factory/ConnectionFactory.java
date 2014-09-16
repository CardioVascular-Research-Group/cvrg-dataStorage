package edu.jhu.cvrg.data.factory;

import edu.jhu.cvrg.data.enums.DataStorageType;
import edu.jhu.cvrg.data.util.DataStorageException;

public class ConnectionFactory {

	public static Connection createConnection()  throws DataStorageException{
		return ConnectionFactory.createConnection(DataStorageType.RELATIONAL_DATABASE_HIBERNATE);
	}
	
	private static Connection createConnection(DataStorageType type)  throws DataStorageException{
		Connection con = null;
		
		switch (type) {
			case RELATIONAL_DATABASE_HIBERNATE:
				con = new HibernateConnection();
				break;
			default:
				throw new DataStorageException("Unspected data storage type. ["+type+"]");
		}
		
		return con;
	}
		
}
