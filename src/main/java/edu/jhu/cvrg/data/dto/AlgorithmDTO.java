package edu.jhu.cvrg.data.dto;

import java.io.Serializable;
import java.util.ArrayList;

import edu.jhu.cvrg.analysis.vo.AnalysisType;



/** Data in this class describes a single analysis algorithm service method.
 * It also will generate an OMElement containing all this data, so that the User Interface code 
 * can auto-generate an invocation interface which will support all the required and optional input parameters.
 * It also specifies the output files, so the result interface can be auto-generated. 
 * @author mshipwa1@jhu.edu
 *
 */
public class AlgorithmDTO implements Serializable{
	
	private static final long serialVersionUID = -3816168513426452658L;
	
	public int id;
	// Descriptions and documentation
	private int serviceID = -1; // database id of the service.
	private String sServiceName = "n/a"; // name to be used in the URL when calling the service, should concatenate to Url with separating "/".
//	private String sUrl = "n/a"; // URL of the server containing the web service e.g. http://128.220.76.170:8080/axis2/services .
	private String sAnalysisServiceURL = "n/a"; // URL of the server containing the web services e.g. "http://128.220.76.170:8080/axis2/services" used together with sServiceName and sServiceMethod e.g. "http://128.220.76.170:8080/axis2/services/physionetAnalysisService/sqrsWrapperType2"
	private String sServiceMethod = "n/a"; // name of the method, with the webservice. e.g. "sqrsWrapperType2"
	private String sDisplayServiceName = "n/a"; // Human friendly name of the service to be used by the UI when listing services.
	private String sDisplayShortName = "n/a"; // Human friendly name of the Algorithm to be used by the UI when listing services.
	private String sToolTipDescription = "n/a"; // Short summary description (under 150 characters) suitable for displaying is a tooltip.
	private String sDisplayLongDescription = "n/a"; // Complete description suitable for using in a manual/help file.
	private String sVersionIdAlgorithm = "n/a"; // Version ID of the algorithm (e.g. "2.5" or "3.0 Beta" ) 
	private String sDateAlgorithm= "n/a"; // Date of this algorithm version.
	private String sVersionIdWebService = "n/a"; // Version ID of the web service wrapping the algorithm(e.g. "1.0")
	private String sDateWebService = "n/a"; // Date of the last web service update.
	private String sURLreference = "n/a"; // URL of a web page about this algorithm.
	private String sLicence = "n/a"; // license of this algorithm, or URL of license e.g. "GPL".
	
//	private People[] apAlgorithmProgrammers; // list of programmers and authors of the algorithm
//	private People[] apWebServiceProgrammers;// list of programmers and authors of the WebService
//	private Organization[] aoAffiliatedOrgs; // list of affiliated organizations.

	// input and output paramters and files
	private FileTypeDTO[] afInFileTypes; // all possible input data files
	private FileTypeDTO[] afOutFileTypes; // all possible output data files
	private ArrayList<AdditionalParametersDTO> aParameters; // Additional parameters (beyond input file names), required or optional.
	
	private AnalysisType type;
	private boolean wfdbAnnotationOutput;
	
	public AlgorithmDTO(){}
	
	public AlgorithmDTO(String serviceName){
		this.sServiceName = serviceName;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getServiceID() {
		return serviceID;
	}

	public void setServiceID(int serviceID) {
		this.serviceID = serviceID;
	}

	public String getServiceName() {
		return sServiceName;
	}
	public void setServiceName(String sServiceName) {
		this.sServiceName = sServiceName;
	}

//	public String getUrl() {
//		return sUrl;
//	}
//	public void setUrl(String url) {
//		sUrl = url;
//	}

	public String getDisplayServiceName() {
		return sDisplayServiceName;
	}
	public void setDisplayServiceName(String sDisplayServiceName) {
		this.sDisplayServiceName = sDisplayServiceName;
	}


	public String getDisplayShortName(){
		return sDisplayShortName;
	}
	public void setDisplayShortName(String sDisplayShortName) {
		this.sDisplayShortName = sDisplayShortName;
	}

	/** Returns the short description of the algorithm, 
	 * or if this is not set, the first 140 characters of the long description.
	 * 
	 * @return
	 */
	public String getToolTipDescription() {
		if(sToolTipDescription.contentEquals("n/a"))
			return getDisplayLongDescription().substring(0, 140) + " . . .";
		else
			return sToolTipDescription;
	}
	public void setToolTipDescription(String sToolTipDescription) {
		this.sToolTipDescription = sToolTipDescription;
	}

	public String getVersionIdAlgorithm() {
		return sVersionIdAlgorithm;
	}
	public void setVersionIdAlgorithm(String sVersionIdAlgorithm) {
		this.sVersionIdAlgorithm = sVersionIdAlgorithm;
	}

	public String getDateAlgorithm() {
		return sDateAlgorithm;
	}
	public void setDateAlgorithm(String sDateAlgorithm) {
		this.sDateAlgorithm = sDateAlgorithm;
	}

	public String getVersionIdWebService() {
		return sVersionIdWebService;
	}
	public void setVersionIdWebService(String sVersionIdWebService) {
		this.sVersionIdWebService = sVersionIdWebService;
	}

	public String getDateWebService() {
		return sDateWebService;
	}
	public void setDateWebService(String sDateWebService) {
		this.sDateWebService = sDateWebService;
	}

	public String getURLreference() {
		return sURLreference;
	}
	public void setURLreference(String sURLreference) {
		this.sURLreference = sURLreference;
	}

	public String getLicence() {
		return sLicence;
	}
	public void setLicence(String sLicence) {
		this.sLicence = sLicence;
	}

//	public People[] getApAlgorithmProgrammers() {
//		return apAlgorithmProgrammers;
//	}
//
//	public void setApAlgorithmProgrammers(People[] apAlgorithmProgrammers) {
//		this.apAlgorithmProgrammers = apAlgorithmProgrammers;
//	}
//
//	public People[] getApWebServiceProgrammers() {
//		return apWebServiceProgrammers;
//	}
//
//	public void setApWebServiceProgrammers(People[] apWebServiceProgrammers) {
//		this.apWebServiceProgrammers = apWebServiceProgrammers;
//	}
//
//	public Organization[] getAoAffiliatedOrgs() {
//		return aoAffiliatedOrgs;
//	}
//
//	public void setAoAffiliatedOrgs(Organization[] aoAffiliatedOrgs) {
//		this.aoAffiliatedOrgs = aoAffiliatedOrgs;
//	}

	public FileTypeDTO[] getAfInFileTypes() {
		return afInFileTypes;
	}
	public void setAfInFileTypes(FileTypeDTO[] afInFileTypes) {
		this.afInFileTypes = afInFileTypes;
	}

	public FileTypeDTO[] getAfOutFileTypes() {
		return afOutFileTypes;
	}
	public void setAfOutFileTypes(FileTypeDTO[] afOutFileTypes) {
		this.afOutFileTypes = afOutFileTypes;
	}

	public ArrayList<AdditionalParametersDTO> getParameters() {
		return aParameters;
	}
	public void setParameters(ArrayList<AdditionalParametersDTO> aParameters) {
		this.aParameters = aParameters;
	}

	public String getAnalysisServiceURL() {
		return sAnalysisServiceURL;
	}
	public void setAnalysisServiceURL(String sAnalysisServiceURL) {
		this.sAnalysisServiceURL = sAnalysisServiceURL;
	}

	public String getServiceMethod() {
		return sServiceMethod;
	}
	public void setServiceMethod(String sServiceMethod) {
		this.sServiceMethod = sServiceMethod;
	}


	public String getDisplayLongDescription() {
		return sDisplayLongDescription;
	}	
	public void setDisplayLongDescription(String sDisplayLongDescription) {
		this.sDisplayLongDescription = sDisplayLongDescription;
	}

	public AnalysisType getType() {
		return type;
	}
	public void setType(AnalysisType type) {
		this.type = type;
	}

	public boolean hasWfdbAnnotationOutput() {
		return wfdbAnnotationOutput;
	}
	public void setWfdbAnnotationOutput(boolean wfdbAnnotationOutput) {
		this.wfdbAnnotationOutput = wfdbAnnotationOutput;
	}
	
	public boolean getHasSettedParameters(){
		if(aParameters != null){
			for (AdditionalParametersDTO p : aParameters) {
				if(p.getParameterUserSpecifiedValue() != null){
					return true;
				}
			}
		}
		return false;
	}

}


