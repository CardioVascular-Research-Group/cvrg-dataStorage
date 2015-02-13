package edu.jhu.cvrg.data.factory;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import edu.jhu.cvrg.data.dto.AdditionalParametersDTO;
import edu.jhu.cvrg.data.dto.AlgorithmDTO;
import edu.jhu.cvrg.data.dto.AnalysisJobDTO;
import edu.jhu.cvrg.data.dto.AnalysisStatusDTO;
import edu.jhu.cvrg.data.dto.AnnotationDTO;
import edu.jhu.cvrg.data.dto.DocumentRecordDTO;
import edu.jhu.cvrg.data.dto.FileInfoDTO;
import edu.jhu.cvrg.data.dto.ServiceDTO;
import edu.jhu.cvrg.data.dto.UploadStatusDTO;
import edu.jhu.cvrg.data.enums.DataStorageType;
import edu.jhu.cvrg.data.enums.UploadState;
import edu.jhu.cvrg.data.util.DataStorageException;
import edu.jhu.cvrg.data.util.DataStorageProperties;

public abstract class Connection {

	protected Logger log = null;
	protected DataStorageProperties props;
	
	private DataStorageType type;
	
	
	public Connection(DataStorageType type) throws DataStorageException {
		this.type = type;
		this.log = Logger.getLogger(this.getClass());
		this.props = DataStorageProperties.getInstance();
		init();
	}

	protected abstract void init() throws DataStorageException;
	public abstract void close();
	
	public abstract Long storeDocument(long userID, String recordName, String subjectID, int originalFormat, double samplingRate, String fileTreePath, int leadCount, int numPoints, Calendar dateUploaded, int age, String gender, Calendar dateRecorded, double aduGain, long[] filesId, String leadNames) throws DataStorageException;
	public abstract Long storeAnnotations(Set<AnnotationDTO> annotSet) throws DataStorageException;
	public abstract Long storeAnnotation(AnnotationDTO annotation) throws DataStorageException;
	public abstract boolean storeFilesInfo(long documentRecordId, long[] fileEntryId, Long analysisJobId) throws DataStorageException;
	public abstract AnalysisJobDTO storeAnalysisJob(long documentRecord, int fileCount, int parameterCount, String serviceUrl, String serviceName, String serviceMethod, Date dateOfAnalysis, long userId) throws DataStorageException;
	public abstract boolean updateUploadStatus(long documentRecordId, UploadState uploadPhase, Long time, Boolean status, String message) throws DataStorageException;
	public abstract boolean updateAnalysisStatus(long analysisJobId, Long analysisTime, String message) throws DataStorageException;
	public abstract boolean storeUploadStatus(UploadStatusDTO status) throws DataStorageException;
	public abstract List<UploadStatusDTO> getUploadStatusByUser(long userId) throws DataStorageException;
	public abstract List<UploadStatusDTO> getUploadStatusByUserAndDocId(long userId, Set<Long> docIds) throws DataStorageException;
	public abstract List<AnalysisStatusDTO> getAnalysisStatusByUserAndAnalysisId(long userId, Set<Long> analysisIds) throws DataStorageException;
	
	public abstract List<FileInfoDTO> getAllFilesByUser(long userId) throws DataStorageException;
	public abstract List<FileInfoDTO> getAllFilesByDocumentRecordId(long docId) throws DataStorageException;
	public abstract List<FileInfoDTO> getECGFilesByDocumentRecordId(long docId) throws DataStorageException;
	public abstract List<AnalysisJobDTO> getAnalysisJobByUser(long userId) throws DataStorageException;
	
	public abstract AnalysisJobDTO getAnalysisJobById(long jobId) throws DataStorageException;
	public abstract DocumentRecordDTO getDocumentRecordById(long documentRecordId) throws DataStorageException;
	public abstract int[][] getAnnotationCountPerLead(Long docId, int qtdLead) throws DataStorageException;
	public abstract List<AnnotationDTO> getLeadAnnotationNode(Long userId, Long docId, Integer leadIndex) throws DataStorageException;
	public abstract AnnotationDTO getAnnotationById(Long userId, Long annotationId) throws DataStorageException;
	
	public abstract boolean deleteDocumentRecord(long userId, long documentRecordId) throws DataStorageException;
	public abstract boolean deleteAllFilesByDocumentRecordId(long documentRecordId) throws DataStorageException;
	
	public DataStorageType getType() {
		return type;
	}
	
/*************************************************  Algorithm Web Services related methods *************************************/
	/** Gets a list of all web services found in the database.
	 * 	 
	 * @param userId - login id of the user, currently ignored but included because we are likely to need it here in the future.
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract List<ServiceDTO> getAvailableServiceList(long userId) throws DataStorageException;
	
	/** Gets, via Hibernate, a List of all the Algorithms the specified user has access to.
	 * @param userId - login id of the user, currently ignored but included because we are likely to need it here in the future.
	 * @return List of 'Algorithm' objects
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract List<AlgorithmDTO> getAvailableAlgorithmList(long userId) throws DataStorageException;
	
	/** Store a single Algorithm
	 * 
	 * @param uiName - Human friendly name to be used by the UI when listing services.
	 * @param serviceID - Foreign key to the "service" table, which will contain the URL and description meta-data for a single web service.  
	 * @param serviceMethod - Name of the method which executes the algorithm, within the webservice. e.g. "sqrsWrapperType2".
	 * @param shortDescription - Short summary description suitable for displaying as a tooltip.
	 * @param completeDescription - Complete description of the algorithm suitable for using in a manual/help file.
	 * @return New Algorithm's ID (Primary key in the database)
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract Integer storeAlgorithm(String uiName, Integer serviceID, String serviceMethod, String shortDescription, String completeDescription) throws DataStorageException;
	
	/** Update a single Algorithm
	 * 
	 * @param uiName - Human friendly name to be used by the UI when listing services.
	 * @param serviceID - Foreign key to the "service" table, which will contain the URL and description meta-data for a single web service.  
	 * @param serviceMethod - Name of the method which executes the algorithm, within the webservice. e.g. "sqrsWrapperType2".
	 * @param shortDescription - Short summary description suitable for displaying as a tooltip.
	 * @param completeDescription - Complete description of the algorithm suitable for using in a manual/help file.
	 * @return - primary key of the algorithm entry.
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract Integer updateAlgorithm(Integer algorithmid, String uiName, Integer serviceID, String serviceMethod, String shortDescription, String completeDescription) throws DataStorageException;

	/** Store a single Algorithm Parameter
	 * 
	 * @param param - Algorithm parameter to be stored in the database.
	 * @param iAlgorithmID - Primary key of the algorithm this parameter pertains to.
	 * @return  Algorithm Parameter's ID (Primary key in the database)
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract Integer storeAlgorithmParameter(AdditionalParametersDTO param, int iAlgorithmID) throws DataStorageException;
	
	/** Update a single Algorithm Parameter
	 * 
	 * @param param - Algorithm parameter to be stored in the database.
	 * @param iAlgorithmID - Primary key of the algorithm this parameter pertains to.
	 * @return Algorithm Parameter's ID (Primary key in the database)
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract Integer updateAlgorithmParameter(AdditionalParametersDTO param, int iAlgorithmID) throws DataStorageException; 



	/** Gets, via Hibernate, an ArrayList of all the Additional (optional) parameters which this specified algorithm can receive.
	 * @param algorithmId - primary key of the algorithm in the persistence database.
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract ArrayList<AdditionalParametersDTO> getAlgorithmParameterArray(int algorithmId) throws DataStorageException;

	/** Gets, via Hibernate, an ArrayList of all the Annotations of this document 
	 * which match the list of bioportalClassIds and where created by the specified createdBy.
	 * 
	 * @param userId - Id of the user who owns this data.
	 * @param docId - Document ID
	 * @param leadIndex - zero based lead index, as found in the original data file.
	 * @param createdBy - Either original file format identifier, algorithm identifier, or user ID in the case of manual annotations.
	 * @param bioportalOntologyID - Identifier of the Ontology, e.g. "ECGT"
	 * @param bioportalClassIdList - A List of bioportalClassId string, e.g. "ECGOntology:ECG_000000243".
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract List<AnnotationDTO> getLeadAnnotationListConceptIDList(Long userId,
			Long docId, Integer leadIndex, String createdBy,
			String bioportalOntologyID, List<String> bioportalClassIdList) throws DataStorageException;


	/** Gets, via Hibernate, an ArrayList of all the Annotations of this document 
	 * which match the list of annotation names and were created by the specified createdBy.
	 * 
	 * @param userId - Id of the user who owns this data.
	 * @param docId - Document ID
	 * @param leadIndex - zero based lead index, as found in the original data file.  If null, then it gets only whole record annotations.
	 * @param createdBy - Either original file format identifier, algorithm identifier, or user ID in the case of manual annotations.
	 * @param nameList - A List of display names of the annotation, e.g. "S-_AMPL" (node name from a Schiller file)
	 * 
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract List<AnnotationDTO> getLeadAnnotationbyNameList(Long userId,
			Long docId, Integer leadIndex, String createdBy,
			List<String> nameList) throws DataStorageException;
	

	/** Store a single Web Service
	 * 
	 * @param uiName - Human friendly name to be used by the UI when listing services.
	 * @param wsName - The web service’s name to be used in the URL when calling the service.   e.g. "physionetAnalysisService"
	 * @param url - URL of the server containing the web services e.g. http://128.220.76.170:8080/axis2/services. <BR>
	 *        This is used together with “service.wsName” and "algorithm.method”. <BR>
	 *        e.g. http://128.220.76.170:8080/axis2/services/physionetAnalysisService/sqrsWrapperType2
	 * @return - the primary key of the new entry in the service table.
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract Integer storeService(String uiName, String wsName, String url) throws DataStorageException;

	/** Update a single Web Service
	 * 
	 * @param service - Service to be Updated in the database.
	 * @return service id (Primary key in database)
	 * @author Michael Shipway
	 * @throws DataStorageException TODO
	 */
	public abstract Integer updateWebService(ServiceDTO service) throws DataStorageException;

	/***************************************************************************************************************************/
}
