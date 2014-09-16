package edu.jhu.cvrg.data.dto;

import java.io.Serializable;

/** Data in this class describes a single web service which contains one or more analysis methods.
 * @author mshipwa1@jhu.edu
 */
public class ServiceDTO implements Serializable{
	
	private static final long serialVersionUID = 5665958014360462959L;
	
	public int id; // Primary key for the service table.
	// Descriptions and documentation
	private String wsName = "n/a"; // name to be used in the URL when calling the service, should concatenate to Url with separating "/".
	private String sUrl = "n/a"; // URL of the server containing the web service e.g. http://128.220.76.170:8080/axis2/services .
	private String uiName = "n/a"; // Human friendly name of the service to be used by the UI when listing services.
	
	public ServiceDTO(){}
	
	public ServiceDTO(String serviceName){
		this.wsName = serviceName;
	}
	
	
	/** Primary key for the service table in the database.
	 * @return - service.serviceID */
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	/** The web service’s name to be used in the URL when calling the service.   e.g. "physionetAnalysisService".
	 * @return - service.wsName */
	public String getServiceName() {
		return wsName;
	}
	public void setServiceName(String sServiceName) {
		this.wsName = sServiceName;
	}

	/** URL of the server containing the web services e.g. http://128.220.76.170:8080/axis2/services. 
	 * @return - service.wsURL  */
	public String getUrl() {
		return sUrl;
	}
	public void setUrl(String url) {
		sUrl = url;
	}

	/** Human friendly name of the service to be used by the UI when listing services.
	 * @return - service.uiName  */
	public String getDisplayServiceName() {
		return uiName;
	}
	public void setDisplayServiceName(String sDisplayServiceName) {
		this.uiName = sDisplayServiceName;
	}
}


