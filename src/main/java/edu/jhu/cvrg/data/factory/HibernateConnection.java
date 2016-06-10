package edu.jhu.cvrg.data.factory;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Set;
import java.util.TreeMap;

import org.hibernate.HibernateException;
import org.hibernate.ObjectNotFoundException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

import edu.jhu.cvrg.data.dto.AdditionalParametersDTO;
import edu.jhu.cvrg.data.dto.AlgorithmDTO;
import edu.jhu.cvrg.data.dto.AnalysisJobDTO;
import edu.jhu.cvrg.data.dto.AnalysisStatusDTO;
import edu.jhu.cvrg.data.dto.AnnotationDTO;
import edu.jhu.cvrg.data.dto.DocumentRecordDTO;
import edu.jhu.cvrg.data.dto.FileInfoDTO;
import edu.jhu.cvrg.data.dto.ParameterValidatorDTO;
import edu.jhu.cvrg.data.dto.ServiceDTO;
import edu.jhu.cvrg.data.dto.UploadStatusDTO;
import edu.jhu.cvrg.data.dto.VirtualNodeDTO;
import edu.jhu.cvrg.data.enums.DataStorageType;
import edu.jhu.cvrg.data.enums.FileType;
import edu.jhu.cvrg.data.enums.UploadState;
import edu.jhu.cvrg.data.factory.hibernate.Algorithm;
import edu.jhu.cvrg.data.factory.hibernate.AlgorithmPerson;
import edu.jhu.cvrg.data.factory.hibernate.AlgorithmReference;
import edu.jhu.cvrg.data.factory.hibernate.AnalysisJob;
import edu.jhu.cvrg.data.factory.hibernate.AnnotationInfo;
import edu.jhu.cvrg.data.factory.hibernate.Coordinate;
import edu.jhu.cvrg.data.factory.hibernate.DocumentRecord;
import edu.jhu.cvrg.data.factory.hibernate.FileInfo;
import edu.jhu.cvrg.data.factory.hibernate.Organization;
import edu.jhu.cvrg.data.factory.hibernate.OrganizationContact;
import edu.jhu.cvrg.data.factory.hibernate.Parameter;
import edu.jhu.cvrg.data.factory.hibernate.ParameterOption;
import edu.jhu.cvrg.data.factory.hibernate.ParameterType;
import edu.jhu.cvrg.data.factory.hibernate.ParameterValidator;
import edu.jhu.cvrg.data.factory.hibernate.Person;
import edu.jhu.cvrg.data.factory.hibernate.Service;
import edu.jhu.cvrg.data.factory.hibernate.UploadStatus;
import edu.jhu.cvrg.data.factory.hibernate.VirtualDocument;
import edu.jhu.cvrg.data.factory.hibernate.VirtualNode;
import edu.jhu.cvrg.data.util.DataStorageException;
import edu.jhu.cvrg.data.util.DataStorageProperties;

public class HibernateConnection extends Connection {

	private static SessionFactory sessionFactory;
	
	
	public HibernateConnection() throws DataStorageException{
		super(DataStorageType.RELATIONAL_DATABASE_HIBERNATE);
	}
	
	@Override
	protected void init() throws DataStorageException {
		try {
			if(sessionFactory == null || props.hasChanges()){
				
				if(sessionFactory != null){
					sessionFactory.close();
				}
				
				Configuration cfg = new Configuration();
				
				cfg.addAnnotatedClass(DocumentRecord.class);
				cfg.addAnnotatedClass(AnnotationInfo.class);
				cfg.addAnnotatedClass(Coordinate.class);
				cfg.addAnnotatedClass(FileInfo.class);
				cfg.addAnnotatedClass(UploadStatus.class);
				cfg.addAnnotatedClass(AnalysisJob.class);
				cfg.addAnnotatedClass(VirtualNode.class);
				cfg.addAnnotatedClass(VirtualDocument.class);

				cfg.addAnnotatedClass(Service.class);
				cfg.addAnnotatedClass(Parameter.class);
				cfg.addAnnotatedClass(Algorithm.class);
				cfg.addAnnotatedClass(AlgorithmPerson.class);
				cfg.addAnnotatedClass(Organization.class);
				cfg.addAnnotatedClass(OrganizationContact.class);
				cfg.addAnnotatedClass(ParameterOption.class);
				cfg.addAnnotatedClass(ParameterType.class);
				cfg.addAnnotatedClass(ParameterValidator.class);
				cfg.addAnnotatedClass(Person.class);
				cfg.addAnnotatedClass(AlgorithmReference.class);
				

				
				cfg.setProperty(Environment.DIALECT, "org.hibernate.dialect.PostgreSQL82Dialect");
				cfg.setProperty(Environment.USER, props.getProperty(DataStorageProperties.HIBERNATE_DB_USERNAME));
				cfg.setProperty(Environment.PASS, props.getProperty(DataStorageProperties.HIBERNATE_DB_PASSWORD));
				cfg.setProperty(Environment.DRIVER, props.getProperty(DataStorageProperties.HIBERNATE_DRIVER_CLASS));
				cfg.setProperty(Environment.URL, props.getProperty(DataStorageProperties.HIBERNATE_DB_URL));
				
				cfg.setProperty(Environment.SHOW_SQL, props.getProperty(DataStorageProperties.HIBERNATE_SHOW_SQL));
				
				cfg.setProperty(Environment.C3P0_MIN_SIZE, props.getProperty(DataStorageProperties.HIBERNATE_C3P0_MIN_SIZE));
				cfg.setProperty(Environment.C3P0_MAX_SIZE, props.getProperty(DataStorageProperties.HIBERNATE_C3P0_MAX_SIZE));
				cfg.setProperty(Environment.C3P0_TIMEOUT, props.getProperty(DataStorageProperties.HIBERNATE_C3P0_TIMEOUT));
				cfg.setProperty(Environment.C3P0_MAX_STATEMENTS, props.getProperty(DataStorageProperties.HIBERNATE_C3P0_MAX_STATEMENTS));
				
				ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(cfg.getProperties()).buildServiceRegistry();        
			    sessionFactory = cfg.buildSessionFactory(serviceRegistry);
			}
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException("Error on data storage initialization", e);
		}
	}
	
	public void close(){
		sessionFactory.close();
	}

	/** 
	 * @param originalFormat - based on the enumeration "fileFormat" in ECGformatCoverter.jar
	 */
	@Override
	public Long initalDocumentStore(long userID, String recordName, String subjectID, int originalFormat,
			 						String fileTreePath, Calendar dateUploaded, Collection<Long> filesId) throws DataStorageException {
		
		Long documentId = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			DocumentRecord record = new DocumentRecord(null, recordName, userID, subjectID, originalFormat,
					 									null, fileTreePath, null, null, 
														dateUploaded != null ? dateUploaded.getTime() : null, 
														null, null, null, null, null, null);
			
			session.save(record);
			
			_storeFilesInfo(record.getDocumentRecordId(), filesId, null, session);
			
			session.getTransaction().commit();
			session.close();
			
			documentId = record.getDocumentRecordId();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return documentId;
	}
	
	
	public Long updateDocument(long documentId, double samplingRate, int leadCount, int numPoints, int age, 
							   String gender, Calendar dateRecorded, double aduGain, String leadNames, long timeseriesId) throws DataStorageException {
		
		
		try {
			Session session = sessionFactory.openSession();
		
			session.beginTransaction();
			
			DocumentRecord doc = (DocumentRecord) session.get(DocumentRecord.class, documentId);
			
			
			doc.setSamplingRate(samplingRate);
			doc.setLeadCount(leadCount);
			doc.setNumberOfPoints(numPoints);
			doc.setAge(age);
			doc.setGender(gender);
			doc.setDateOfRecording(dateRecorded != null ? dateRecorded.getTime():null);
			doc.setAduGain(aduGain);
			doc.setLeadNames(leadNames);
			doc.setTimeSeriesId(timeseriesId);
			
			session.save(doc);
			
			session.getTransaction().commit();
			
			session.close();
			
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return documentId;
	}
	
	public void markDocumentToDelete(long documentId) throws DataStorageException {
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			
			DocumentRecord doc = (DocumentRecord) session.get(DocumentRecord.class, documentId);
			
			doc.setDeleteFlag(true);
			
			session.save(doc);
			
			session.getTransaction().commit();
			
			session.close();
		
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
	}
	
	
	public Long storeDocument(long userID, String recordName, String subjectID, int originalFormat,
			double samplingRate, String fileTreePath, int leadCount,
			int numPoints, Calendar dateUploaded, int age, String gender,
			Calendar dateRecorded, double aduGain, Collection<Long> filesId, String leadNames, long timeseriesId) throws DataStorageException {
		
		Long documentId = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			DocumentRecord record = new DocumentRecord(null, recordName, userID, subjectID, originalFormat,
					 									samplingRate, fileTreePath, leadCount, numPoints, 
														dateUploaded != null ? dateUploaded.getTime() : null, 
														age, gender, 
														dateRecorded != null ? dateRecorded.getTime():null, 
														aduGain, leadNames, timeseriesId);
			
			session.save(record);
			
			_storeFilesInfo(record.getDocumentRecordId(), filesId, null, session);
			
			session.getTransaction().commit();
			session.close();
			
			documentId = record.getDocumentRecordId();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return documentId;
	}
	
	
	@Override
	public Long storeAnnotations(Set<AnnotationDTO> annotSet) throws DataStorageException {
		
		Session session = sessionFactory.openSession();
		session.beginTransaction();

		Long counter = 0L;
		
		try{
			
			for (AnnotationDTO annotationInfo : annotSet) {
				AnnotationInfo ret = _storeAnnotation(annotationInfo, session);
				
				if(ret != null){
					counter++;
					if(counter % 100 == 0){
						session.flush();
						session.clear();
					}
				}
			}
			session.getTransaction().commit();
			
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}finally{
			session.close();
		}
		
		return counter;
	}

	@Override
	public Long storeAnnotation(AnnotationDTO annotation) throws DataStorageException {
		
		Long annotationId = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			
			AnnotationInfo ann = _storeAnnotation(annotation, session);
			
			session.getTransaction().commit();
			session.close();
			
			annotationId = ann.getAnnotationId();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		} 
		
		return annotationId;
		
	}

	private AnnotationInfo _storeAnnotation(AnnotationDTO annotation,Session session) {
		
		Long startCoordId = null; 
		Long endCoordId = null;
		if(annotation.getStartXcoord() != null && annotation.getStartYcoord() != null){
			
			startCoordId = addCoordinate(session, annotation.getStartXcoord(), annotation.getStartYcoord());
			endCoordId = startCoordId;
			
			if(annotation.getEndXcoord() != null && annotation.getEndYcoord() != null && (!annotation.getStartXcoord().equals(annotation.getEndXcoord()) || !annotation.getStartYcoord().equals(annotation.getEndYcoord()))){
				endCoordId = addCoordinate(session, annotation.getEndXcoord(), annotation.getEndYcoord());
			}
		}
		
		AnnotationInfo ann = new AnnotationInfo(null, annotation.getRecordID(), startCoordId, endCoordId, annotation.getCreatedBy(), annotation.getAnnotationType(), annotation.getName(), annotation.getBioportalReferenceLink(), 
													  annotation.getBioportalOntology(), annotation.getBioportalClassId(), annotation.getLead(), annotation.getUnitMeasurement(), annotation.getDescription(), 
													  annotation.getValue(), annotation.getAnalysisJobId(), annotation.getUserID());
		session.save(ann);
		
		annotation.setAnnotationId(ann.getAnnotationId());
		
		return ann;
	}

	private void _storeFilesInfo(long documentRecordId, Collection<Long> fileEntryId, Long analysisJobId, Session session) {
		
		if(fileEntryId != null){
			for (Long id : fileEntryId) {
				FileInfo file = new FileInfo(id, documentRecordId, analysisJobId);
				session.save(file);
			}
		}
		
	}
	
	private Long addCoordinate(Session session, Double x, Double y) {
		
		Coordinate coord = new Coordinate(null, x, y);
		
		session.save(coord);
		
		return coord.getCoordinateId();
	}

	@Override
	public boolean storeFilesInfo(long documentRecordId, Collection<Long> fileEntryId, Long analysisJobId) throws DataStorageException {
		
		boolean ret = false;
		try{
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			_storeFilesInfo(documentRecordId, fileEntryId, analysisJobId, session);
			
			session.getTransaction().commit();
			session.close();
			ret = true;
		}catch (HibernateException e){
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}

	@Override
	public List<FileInfoDTO> getAllFilesByUser(long userId) throws DataStorageException {
		
		List<FileInfoDTO> ret = new ArrayList<FileInfoDTO>();
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select d.filesInfo from DocumentRecord d where d.userId = :userid and d.timeseriesId is not null and d.deleteFlag is null");
			
			q.setParameter("userid", userId);
			
			@SuppressWarnings("unchecked")
			List<FileInfo> l = q.list();
			
			for (int i = 0; i < l.size(); i++) {
				FileInfo entity = l.get(i);
				ret.add(new FileInfoDTO(entity.getDocumentRecordId(), entity.getFileId(), entity.getAnalysisJobId()));
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	@Override
	public List<FileInfoDTO> getAllFilesReferenceByUser(long userId) throws DataStorageException {
		
		List<FileInfoDTO> ret = new ArrayList<FileInfoDTO>();
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select d.documentRecord.filesInfo from VirtualDocument d where d.userId = :userid and d.documentRecord.deleteFlag is null");
			
			q.setParameter("userid", userId);
			
			@SuppressWarnings("unchecked")
			List<FileInfo> l = q.list();
			
			for (int i = 0; i < l.size(); i++) {
				FileInfo entity = l.get(i);
				ret.add(new FileInfoDTO(entity.getDocumentRecordId(), entity.getFileId(), entity.getAnalysisJobId()));
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	
	@Override
	public List<FileInfoDTO> getECGFilesByDocumentRecordId(long docId) throws DataStorageException {
		
		List<FileInfoDTO> ret = new ArrayList<FileInfoDTO>();
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select f from FileInfo f where f.documentRecordId = :docId and f.analysisJobId is null");
			
			q.setParameter("docId", docId);
			
			@SuppressWarnings("unchecked")
			List<FileInfo> l = q.list();
			
			for (int i = 0; i < l.size(); i++) {
				FileInfo entity = l.get(i);
				ret.add(new FileInfoDTO(entity.getDocumentRecordId(), entity.getFileId(), entity.getAnalysisJobId()));
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	@Override
	public List<FileInfoDTO> getAllFilesByDocumentRecordId(long docId) throws DataStorageException {
		
		List<FileInfoDTO> ret = new ArrayList<FileInfoDTO>();
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select f from FileInfo f where f.documentRecordId = :docId");
			
			q.setParameter("docId", docId);
			
			@SuppressWarnings("unchecked")
			List<FileInfo> l = q.list();
			
			for (int i = 0; i < l.size(); i++) {
				FileInfo entity = l.get(i);
				ret.add(new FileInfoDTO(entity.getDocumentRecordId(), entity.getFileId(), entity.getAnalysisJobId()));
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	@Override
	public List<FileInfoDTO> getAllFilesByTimeSeriesId(long timeseriesId) throws DataStorageException {
		
		List<FileInfoDTO> ret = new ArrayList<FileInfoDTO>();
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select f from FileInfo f where f.timeSeriesId = :timeseriesId");
			
			q.setParameter("timeseriesId", timeseriesId);
			
			@SuppressWarnings("unchecked")
			List<FileInfo> l = q.list();
			
			for (int i = 0; i < l.size(); i++) {
				FileInfo entity = l.get(i);
				ret.add(new FileInfoDTO(entity.getDocumentRecordId(), entity.getFileId(), entity.getAnalysisJobId()));
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	
	@Override
	public AnalysisJobDTO storeAnalysisJob(long documentRecord, int fileCount, int parameterCount, String serviceUrl, String serviceName, String serviceMethod, Date dateOfAnalysis, long userId) throws DataStorageException{
		
		AnalysisJobDTO job = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			
			AnalysisJob entity = new AnalysisJob(null, documentRecord, fileCount, parameterCount, serviceUrl, serviceName, serviceMethod, dateOfAnalysis, userId);
			
			session.save(entity);
			
			session.getTransaction().commit();
			session.close();
			
			job = new AnalysisJobDTO(entity.getAnalysisJobId(), entity.getDocumentRecordId(), entity.getFileCount(), entity.getParameterCount(), entity.getServiceName(), entity.getServiceUrl(), entity.getServiceMethod(), entity.getDateOfAnalysis(), entity.getUserId(), entity.getAnalysisTime(), entity.getMessage());
			
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return job;
	}

	@Override
	public AnalysisJobDTO getAnalysisJobById(long jobId) throws DataStorageException {
		
		AnalysisJobDTO ret = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select a from AnalysisJob a where a.analysisJobId = :jobId");
			
			q.setParameter("jobId", jobId);
			
			@SuppressWarnings("unchecked")
			List<AnalysisJob> l = q.list();
			
			if(l.size() > 0){
				AnalysisJob entity = l.get(0);
				ret = new AnalysisJobDTO(entity.getAnalysisJobId(), entity.getDocumentRecordId(), entity.getFileCount(), entity.getParameterCount(), entity.getServiceName(), entity.getServiceUrl(), entity.getServiceMethod(), entity.getDateOfAnalysis(), entity.getUserId(), entity.getAnalysisTime(), entity.getMessage());
			}
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	@Override
	public DocumentRecordDTO getDocumentRecordById(long documentRecordId) throws DataStorageException {
		
		DocumentRecordDTO ret = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select d from DocumentRecord d where d.documentRecordId = :documentRecordId");
			
			q.setParameter("documentRecordId", documentRecordId);
			
			@SuppressWarnings("unchecked")
			List<DocumentRecord> l = q.list();
			
			if(l.size() > 0){
				DocumentRecord entity = l.get(0);
				ret = new DocumentRecordDTO(entity.getDocumentRecordId(), entity.getRecordName(), entity.getUserId(), entity.getSubjectId(), FileType.getTypeById(entity.getOriginalFormat()), entity.getSamplingRate(), entity.getFileTreePath(),entity.getLeadCount(), entity.getNumberOfPoints(), entity.getDateOfUpload(), entity.getAge(), entity.getGender(), entity.getDateOfRecording(), entity.getAduGain(), entity.getLeadNames(), entity.getTimeSeriesId());
			}
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	@Override
	public List<DocumentRecordDTO> getDocumentsToDelete() throws DataStorageException {
		
		List<DocumentRecordDTO> ret = new ArrayList<DocumentRecordDTO>();
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select d from DocumentRecord d where d.timeseriesId is not null and d.deleteFlag is not null");
			
			@SuppressWarnings("unchecked")
			List<DocumentRecord> l = q.list();
			
			for (int i = 0; i < l.size(); i++) {
				DocumentRecord entity = l.get(i);
				ret.add(new DocumentRecordDTO(entity.getDocumentRecordId(), entity.getRecordName(), entity.getUserId(), entity.getSubjectId(), FileType.getTypeById(entity.getOriginalFormat()), entity.getSamplingRate(), entity.getFileTreePath(),entity.getLeadCount(), entity.getNumberOfPoints(), entity.getDateOfUpload(), entity.getAge(), entity.getGender(), entity.getDateOfRecording(), entity.getAduGain(), entity.getLeadNames(), entity.getTimeSeriesId()));
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	
	/**
	 * Gets an array of the counts of annotations from the metadata storage
	 * database on a per lead basis.
	 * 
	 * @return - a comma separated list with the following columns<BR>
	 *         Lead number(term), Total annotation count, Manual annotations
	 *         count, Automated annotation count..
	 * @author Michael Shipway
	 */
	@Override
	public int[][] getAnnotationCountPerLead(Long docId, Long userId, int qtdLead) throws DataStorageException{
		int[][] annPerLead ;
		
		try {
			Session session = sessionFactory.openSession();
			
			int[][] annPerLeadManual = _getAnnotationCount(docId, userId, session);
			int[][] annPerLeadAuto = _getAnnotationCount(docId, null, session);
			
			annPerLead = new int[qtdLead][4];
			
			for(int i = 0; i < annPerLead.length; i++){
				
				int leadName = i + 1;
				
				if(annPerLeadAuto != null){
					for (int j = 0; j < annPerLeadAuto.length; j++) {
						if(annPerLeadAuto[j][0] == leadName){
							annPerLead[i][3] = annPerLeadAuto[j][1];
							break;
						}
					}
				}
				
				if(annPerLeadManual != null){
					for (int j = 0; j < annPerLeadManual.length; j++) {
						if(annPerLeadManual[j][0] == leadName){
							annPerLead[i][2] = annPerLeadManual[j][1];
							break;
						}
					}	
				}
							
				annPerLead[i][1] = annPerLead[i][3] + annPerLead[i][2];
				annPerLead[i][0] = leadName;
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return annPerLead;
	}
	
	
	private int[][] _getAnnotationCount(Long docId, Long userId, Session session){
		int[][] annPerLead  = null;
		
		StringBuilder hql = new StringBuilder();
		
		hql.append("select leadIndex, count(annotationId) from AnnotationInfo where documentRecordId = :docId and leadindex is not null and ");
		
		if(userId != null){
			hql.append(" createdBy = 'manual' and userId = :userId ");
		}else{
			hql.append(" (createdBy <> 'manual' or createdBy is null) ");
		}
		
		hql.append(" group by leadIndex order by 1");
		
		Query q = session.createQuery(hql.toString()).setParameter("docId", docId);
		
		if(userId != null){
			q.setParameter("userId", userId);
		}
		
		@SuppressWarnings("unchecked")
		List<Object[]> result = q.list();
		
		if(result != null && result.size() > 0){
			annPerLead = new int[result.size()][2];
			int i  = 0;
			for (Object[] objects : result) {
				annPerLead[i][0] = ((Integer)objects[0]) + 1;
				annPerLead[i][1] = ((Long)objects[1]).intValue();
				i++;
			}
		}
		return annPerLead;	
	}
	
	@Override
	public List<AnnotationDTO> getLeadAnnotationNode(Long userId, Long docId, Integer leadIndex) throws DataStorageException{
		List<AnnotationDTO> annotations = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			StringBuilder hql = new StringBuilder();
			
			hql.append("select a from DocumentRecord d ")
				.append("inner join d.annotationInfos as a ")
				.append("left  join a.startCoordinate as cStart ")
				.append("where d.documentRecordId = :docId and (a.userId = :userId or a.userId is null) and a.leadIndex ");
			
			if(leadIndex != null){
				hql.append(" = :leadIndex ");	
			}else{
				hql.append(" is null ");
			}
			
			hql.append("order by cStart.xCoordinate ");
			
			Query q = session.createQuery(hql.toString());
			
			q.setParameter("docId", docId);
			q.setParameter("userId", userId);
			
			if(leadIndex != null){
				q.setParameter("leadIndex", leadIndex);
			}
			
			@SuppressWarnings("unchecked")
			List<AnnotationInfo> result = q.list();
			
			if(result != null && result.size() > 0 ){
				annotations = new ArrayList<AnnotationDTO>();
				
				for (AnnotationInfo entity : result) {
					annotations.add(this.annotation2DTO(entity));	
				}
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return annotations;
	}
	
	/** Gets, via Hibernate, an ArrayList of all the Annotations of this document 
	 * which match the list of bioportalClassIds and were created by the specified createdBy.
	 * 
	 * @param userId - Id of the user who owns this data.
	 * @param docId - Document ID
	 * @param leadIndex - zero based lead index, as found in the original data file.  If null, then it gets only whole record annotations.
	 * @param createdBy - Either original file format identifier, algorithm identifier, or user ID in the case of manual annotations.
	 * @param bioportalOntologyID - Identifier of the Ontology, e.g. "ECGT"
	 * @param bioportalClassIdList - A List of bioportalClassId string, e.g. "ECGOntology:ECG_000000243".
	 * 
	 * @author Michael Shipway
	 */
	@Override
	public List<AnnotationDTO> getLeadAnnotationListConceptIDList(Long userId, Long docId, Integer leadIndex, 
			String createdBy, String bioportalOntologyID, List<String> bioportalClassIdList) throws DataStorageException{
		
		List<AnnotationDTO> annotationsRet = new ArrayList<AnnotationDTO>();
		
		for(String s:bioportalClassIdList){
			AnnotationDTO annotation = getLeadAnnotationbyBioportal(userId, docId, leadIndex, 
					createdBy, bioportalOntologyID, s);
			
			if(annotation!=null){
				annotationsRet.add(annotation);
			}else{
				annotationsRet.add(null); // marks the empty result in the result set.
			}
		}
		
		return annotationsRet;
	}

	/** returns the single annotation that meets these parameters, returns null if more than one are found or if none are found.
	 * 
	 * @param userId - Id of the user who owns this data.
	 * @param docId - Document ID
	 * @param leadIndex - zero based lead index, as found in the original data file.
	 * @param createdBy - Either original file format identifier, algorithm identifier, or user ID in the case of manual annotations.
	 * @param bioportalOntologyID - Identifier of the Ontology, e.g. "ECGT"
	 * @param bioportalClassId - A single bioportalClassId string, e.g. "ECGOntology:ECG_000000243".
	 * 
	 * @author Michael Shipway
	 * @return a single annotation or null
	 * @throws DataStorageException 
	 */
	private AnnotationDTO getLeadAnnotationbyBioportal(Long userId, Long docId, Integer leadIndex,
			String createdBy, String bioportalOntologyID, String bioportalClassId) throws DataStorageException{
		
		AnnotationDTO annotationRet = null;
			
		try {
			Session session = sessionFactory.openSession();
			
			StringBuilder hql = new StringBuilder();
			System.out.println("getLeadAnnotationbyBioportal() leadIndex: " + leadIndex);
			hql.append("select a from DocumentRecord d ")
				.append("inner join d.annotationInfos as a ") // HashSet of AnnotationInfo class in DocumentRecord
				.append("where d.documentRecordId = :docId ")
				.append("  and d.userId = :userId ")
				.append("  and a.createdBy  = :createdBy ")	
				.append("  and a.bioportalOntology  = :bioportalOntologyID ")	
				.append("  and a.bioportalClassId  = :bioportalClassId ")	;
			if(leadIndex != null){
				hql.append("  and a.annotationtype  = :annotationtype ");
				hql.append("  and a.leadIndex  = :leadIndex ");
			}else{
			}
			
			Query q = session.createQuery(hql.toString());
			
			q.setParameter("docId", docId);
			q.setParameter("userId", userId);		
			q.setParameter("createdBy", createdBy);
			q.setParameter("bioportalOntologyID", bioportalOntologyID);
			q.setParameter("bioportalClassId", bioportalClassId);
			if(leadIndex != null){
				q.setParameter("leadIndex", leadIndex);
				q.setParameter("annotationtype", "ANNOTATION");
			}else{
				// q.setParameter("annotationType", "COMMENT");
			}
			
			@SuppressWarnings("unchecked")
			List<AnnotationInfo> result = q.list();
			
			if(result != null && result.size() > 0 ){
				if(result.size() != 1){
					annotationRet = null; // multiple results are not allow.
				}else{
					annotationRet = this.annotation2DTO(result.get(0));
				}
			}else{
				annotationRet = null;
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return annotationRet;
	}
	
	
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
	 */
	@Override
	public List<AnnotationDTO> getLeadAnnotationbyNameList(Long userId, Long docId, Integer leadIndex, String createdBy, List<String> nameList) throws DataStorageException{
		List<AnnotationDTO> annotationsRet = new ArrayList<AnnotationDTO>();
		
		for(String name:nameList){
			AnnotationDTO annotation = getLeadAnnotationbyName(userId, docId, leadIndex, 
					createdBy, name);
			
			if(annotation!=null){
				annotationsRet.add(annotation);
			}else{
				annotationsRet.add(null); // marks the empty result in the result set.
			}
		}
		
		return annotationsRet;
	}

	/** returns the single annotation that meets these parameters, returns null if more than one are found or if none are found.
	 * 
	 * @param userId - Id of the user who owns this data.
	 * @param docId - Document ID
	 * @param leadIndex - zero based lead index, as found in the original data file.
	 * @param createdBy - Either original file format identifier, algorithm identifier, or user ID in the case of manual annotations.
	 * @param name - display name of the annotation, e.g. "S-_AMPL" (node name from a Schiller file)
	 * 
	 * @author Michael Shipway
	 * @return a single annotation or null
	 * @throws DataStorageException 
	 */
	private AnnotationDTO getLeadAnnotationbyName(Long userId, Long docId, Integer leadIndex,
			String createdBy, String name) throws DataStorageException{
		
		AnnotationDTO annotationRet = null;
		try{
			Session session = sessionFactory.openSession();
			
			StringBuilder hql = new StringBuilder();
			System.out.println("getLeadAnnotationbyBioportal() leadIndex: " + leadIndex);
			hql.append("select a from DocumentRecord d ")
				.append("inner join d.annotationInfos as a ") // HashSet of AnnotationInfo class in DocumentRecord
				.append("where d.documentRecordId = :docId ")
				.append("  and d.userId = :userId ")
				.append("  and a.createdBy  = :createdBy ")	
				.append("  and a.name  = :name ")	;
			if(leadIndex != null){
				hql.append("  and a.annotationtype  = :annotationtype ");
				hql.append("  and a.leadIndex  = :leadIndex ");
			}else{
			}
			
			Query q = session.createQuery(hql.toString());
			
			q.setParameter("docId", docId);
			q.setParameter("userId", userId);		
			q.setParameter("createdBy", createdBy);
			q.setParameter("name", name);
			if(leadIndex != null){
				q.setParameter("leadIndex", leadIndex);
				q.setParameter("annotationtype", "ANNOTATION");
			}else{
				// q.setParameter("annotationType", "COMMENT");
			}
			
			@SuppressWarnings("unchecked")
			List<AnnotationInfo> result = q.list();
			
			if(result != null && result.size() > 0 ){
				if(result.size() != 1){
					annotationRet = null; // multiple results are not allow.
				}else{
					annotationRet = this.annotation2DTO(result.get(0));
				}
			}else{
				annotationRet = null;
			}
			
			session.close();
		}catch(HibernateException e){
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		return annotationRet;
	}
	
	@Override
	public AnnotationDTO getAnnotationById(Long userId, Long annotationId) throws DataStorageException{
		AnnotationDTO annotation = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select a from AnnotationInfo a where a.annotationId = :annotationId and a.userId = :userId ");
			
			q.setParameter("annotationId", annotationId);
			q.setParameter("userId", userId);
			
			@SuppressWarnings("unchecked")
			List<AnnotationInfo> result = q.list();
			
			if(result != null && result.size() > 0 ){
				for (AnnotationInfo entity : result) {
					annotation = this.annotation2DTO(entity);
					break;
				}
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return annotation;
	}
	
	@Override
	public boolean updateUploadStatus(long documentRecordId, UploadState uploadPhase, Long time, Boolean status, String message) throws DataStorageException {
		System.out.println("documentRecordID is " + documentRecordId);
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			
			UploadStatus entity = null;
			try{
				entity = (UploadStatus) session.load(UploadStatus.class, documentRecordId);
				if(uploadPhase!= null){
					switch (uploadPhase) {
						case VALIDATION: 	entity.setValidationTime(time); break;
						case TRANSFER_READ: entity.setTransferReadTime(time); break;
						case WRITE: 		entity.setWriteTime(time); 		break;
						case ANNOTATION: 	entity.setAnnotationTime(time); break;
						default: break;
					}	
				}
			}catch(ObjectNotFoundException e){
				entity = new UploadStatus();
				entity.setDocumentRecordId(documentRecordId);
				if(uploadPhase!= null){
					switch (uploadPhase) {
						case VALIDATION: 	entity.setValidationTime(time); break;
						case TRANSFER_READ: 	entity.setTransferReadTime(time); break;
						case WRITE: 		entity.setWriteTime(time); 		break;
						case ANNOTATION: 	entity.setAnnotationTime(time); break;
						default: break;
					}
				}
			}
			
			if(status != null){
				entity.setStatus(status);
			}
			
			if(message != null){
				entity.setMessage(message);
			}
			
			session.persist(entity);
			
			session.getTransaction().commit();
			session.close();
			
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		
	}
	
	public List<UploadStatusDTO> getUploadStatusByUser(long userId) throws DataStorageException{
		
		List<UploadStatusDTO> ret = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select u from DocumentRecord d inner join d.uploadStatus u where d.userId = :userId and u.status is null order by u.documentRecordId desc");
			
			q.setParameter("userId", userId);
			
			List<UploadStatus> entities = q.list();
			
			if(entities != null && !entities.isEmpty()){
				ret = new ArrayList<UploadStatusDTO>();
				
				for (UploadStatus uploadStatus : entities) {
					UploadStatusDTO dto = new UploadStatusDTO(uploadStatus.getDocumentRecordId(), uploadStatus.getAnnotationTime(), uploadStatus.getTransferReadTime(), uploadStatus.getValidationTime(), uploadStatus.getWriteTime(), uploadStatus.getStatus(), uploadStatus.getMessage());
					dto.setRecordName(uploadStatus.getDocumentRecord().getRecordName());
					ret.add(dto);
				}
			}
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}

	public List<UploadStatusDTO> getUploadStatusByUserAndDocId(long userId, Set<Long> docIds) throws DataStorageException{
		
		List<UploadStatusDTO> ret = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			StringBuilder hql = new StringBuilder();
			hql.append("select u from DocumentRecord d inner join d.uploadStatus u where d.userId = :userId ");
			
			if(docIds != null){
				hql.append(" and d.documentRecordId in (:docIds) ");
			}
			
			hql.append(" order by u.documentRecordId desc ");

			Query q = session.createQuery(hql.toString());
			q.setParameter("userId", userId);
			
			if(docIds != null){
				q.setParameterList("docIds", docIds);	
			}
			
			List<UploadStatus> entities = q.list();
			
			if(entities != null && !entities.isEmpty()){
				ret = new ArrayList<UploadStatusDTO>();
				
				for (UploadStatus uploadStatus : entities) {
					UploadStatusDTO dto = new UploadStatusDTO(uploadStatus.getDocumentRecordId(), uploadStatus.getAnnotationTime(), uploadStatus.getTransferReadTime(), uploadStatus.getValidationTime(), uploadStatus.getWriteTime(), uploadStatus.getStatus(), uploadStatus.getMessage());
					dto.setRecordName(uploadStatus.getDocumentRecord().getSubjectId());
					ret.add(dto);
				}
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		return ret;
	}
	
	@Override
	public boolean storeUploadStatus(UploadStatusDTO status) throws DataStorageException {
		
		boolean ret = false;
		UploadStatus entity = null;
		
		try {
			if(status != null){
				Session session = sessionFactory.openSession();
				
				session.beginTransaction();
				
				
				
				try{
					entity = (UploadStatus) session.load(UploadStatus.class, status.getDocumentRecordId());
					entity.setValidationTime(status.getValidationTime());
					entity.setTransferReadTime(status.getTransferReadTime());
					
					if(status.getWriteTime() != null){
						entity.setWriteTime(status.getWriteTime());
					}
					
					if(status.getAnnotationTime() != null){
						entity.setAnnotationTime(status.getAnnotationTime());
					}
					
					if(status.getStatus() != null){
						entity.setStatus(status.getStatus());
					}
					
//					if(status.getMessage() != null){
//						entity.setMessage(status.getMessage());
//					}
					
				}catch(ObjectNotFoundException e){
					e.printStackTrace();
//					entity = new UploadStatus(status.getDocumentRecordId(), status.getAnnotationTime(), 
//							status.getTransferReadTime(), status.getValidationTime(), status.getWriteTime(), 
//							status.getStatus(), status.getMessage());
				}
				
				session.persist(entity);
				ret = true;
				
				session.getTransaction().commit();
				session.close();
				
			}
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
	
		return ret;
	}

	//*********** Algorithm database interaction methods **********************
	/** Gets a list of all web services found in the database.
	 * 	 
	 * @param userId - login id of the user, currently ignored but included because we are likely to need it here in the future.
	 * @author Michael Shipway
	 */
	@Override
	public List<ServiceDTO> getAvailableServiceList(long userId) throws DataStorageException {
		
		List<ServiceDTO> ret = new ArrayList<ServiceDTO>();
		try{
			Session session = sessionFactory.openSession();
			Query qs = session.createQuery(
					 "SELECT w "
					+"FROM  "
					+"  Service w "
					+"ORDER BY  "
					+"  w.serviceid");
			
			@SuppressWarnings("unchecked")
			List<Service> servList = qs.list();
			for (Service aws_S : servList) {
				ServiceDTO serv = aws_S.getServiceBean();
				ret.add(serv);
			}
	
			session.close();
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		return ret;
	}
	

	/** Gets, via Hibernate, an Array of all the Algorithms the specified user has access to.
	 * @param userId - login id of the user, currently ignored but included because we are likely to need it here in the future.
	 * @author Michael Shipway
	 */
	@Override
	public List<AlgorithmDTO> getAvailableAlgorithmList(long userId) throws DataStorageException {
		
		List<AlgorithmDTO> ret = new ArrayList<AlgorithmDTO>();
		try{
			Session session = sessionFactory.openSession();
			Query qa = session.createQuery(
					 "SELECT "
					+"  a.algorithmid,  "
					+"  a.serviceid,  "
					+"  a.serviceMethod,  "
					+"  a.uiName, "
					+"  a.shortDescription, "
					+"  a.completeDescription,  "
					+"  w.serviceid,  "
					+"  w.uiName,  "
					+"  w.wsName,  "
					+"  w.url, "
					+"  r.referenceurl, "
					+"  r.licence, "			
					+"  r.versionAlgorithm, "
					+"  r.versionWebService, "
					+"	a.resultformat "
					+"FROM  "
					+"  Algorithm a,"
					+"  Service w, "
					+"  AlgorithmReference r "
					+"WHERE  "
					+"  a.serviceid = w.serviceid "
					+"  AND " 
					+"  a.algorithmid = r.algorithmid "
					+"ORDER BY  "
					+"  a.algorithmid");
								
			@SuppressWarnings("unchecked")
			List<Object> l = qa.list();
			
			for (int i = 0; i < l.size(); i++) {
				Object[] obj = (Object[]) l.get(i);						
				AlgorithmDTO alg = new AlgorithmDTO();
				
				alg.setId((Integer)obj[0]);
				alg.setServiceID((Integer)obj[1]);
				alg.setServiceMethod((String) obj[2]);
				alg.setDisplayShortName((String) obj[3]);
				alg.setToolTipDescription((String) obj[4]);
				alg.setDisplayLongDescription((String)obj[5]);
				// obj[6] should be the same as obj[1]
				alg.setDisplayServiceName((String)obj[7]);
				alg.setServiceName((String)obj[8]);
				alg.setAnalysisServiceURL((String)obj[9]);
				alg.setURLreference((String)obj[10]);
				alg.setLicence((String)obj[11]);
				alg.setVersionIdAlgorithm((String)obj[12]);
				alg.setVersionIdWebService((String)obj[13]);
				alg.setResultType((String)obj[14]);
				alg.setParameters(getAlgorithmParameterArray(alg.getId()));
				ret.add(alg);
			}
			
			session.close();
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		return ret;
	}

	
	/** Gets, via Hibernate, an ArrayList of all the Additional (optional) parameters which this specified algorithm can receive.<BR>
	 * NOTE: the "parameterValidator" table is expected to have an entry with an id of (null) to deal with parameters which don't have any validator.
	 * @param algorithmId - primary key of the algorithm in the persistence database.
	 * @author Michael Shipway
	 */
	@Override
	public ArrayList<AdditionalParametersDTO> getAlgorithmParameterArray(int algorithmId) throws DataStorageException {
		
		ArrayList<AdditionalParametersDTO> ret = new ArrayList<AdditionalParametersDTO>();
		try{
			Session session = sessionFactory.openSession();
			
			Algorithm algEntity = (Algorithm) session.get(Algorithm.class, Long.valueOf(algorithmId).intValue());
			
			for (Parameter param : algEntity.getParameters()) {
				AdditionalParametersDTO paramDTO = new AdditionalParametersDTO();
				paramDTO.setId(param.getParameterID());
				paramDTO.setDisplayShortName(param.getUiName());
				paramDTO.setToolTipDescription(param.getShortDescription());
				paramDTO.setLongDescription(param.getCompleteDescription());
				paramDTO.setParameterDefaultValue(param.getDefaultValue());
				paramDTO.setOptional(!Boolean.parseBoolean(param.getDefaultValue()));
				paramDTO.setMultipleSelect(param.getMultipleSelect()); // If true, allow multiple selections in a dropdown list. Only relevent for select or data_column parameter types.'
				paramDTO.setType(param.getType().getUiName());
				paramDTO.setParameterFlag(param.getFlag());
				
				if(param.getValidator() != null){
					ParameterValidatorDTO val = new ParameterValidatorDTO();
					val.setId(param.getValidator().getParameterValidationid());
					val.setMessage(param.getValidator().getMessage());
					val.setMin(param.getValidator().getMin());
					val.setMax(param.getValidator().getMax());
					val.setRegex(param.getValidator().getRegex());
					val.setType(param.getValidator().getValidatorType());
					paramDTO.setValidator(val);
				}
				
				ret.add(paramDTO);
			}
			
			session.close();
			
		}catch(HibernateException hex){
			hex.printStackTrace();
			throw new DataStorageException(hex);
		}
		
		return ret;
	}
	


	
	/** Store a single Algorithm
	 * 
	 * @param uiName - Human friendly name to be used by the UI when listing services.
	 * @param serviceID - Foreign key to the "service" table, which will contain the URL and description meta-data for a single web service.  
	 * @param serviceMethod - Name of the method which executes the algorithm, within the webservice. e.g. "sqrsWrapperType2".
	 * @param shortDescription - Short summary description suitable for displaying as a tooltip.
	 * @param completeDescription - Complete description of the algorithm suitable for using in a manual/help file.
	 * @return New Algorithm's ID (Primary key in the database)
	 * @author Michael Shipway
	 */
	@Override
	public Integer storeAlgorithm(String uiName, Integer serviceID, String serviceMethod, 
			String shortDescription,
			String completeDescription) throws DataStorageException {
			
		int algID=-1;
		
		try{
			Session session = sessionFactory.openSession();		
			session.beginTransaction();
			
			Algorithm alg = new Algorithm(uiName, serviceID, serviceMethod, shortDescription, completeDescription);
			session.persist(alg);
			algID = alg.getAlgorithmid();

			AlgorithmReference ref = new AlgorithmReference(algID);
			session.persist(ref);

			session.getTransaction().commit();
			session.close();			
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return algID;
	}
	
	@Override
	public boolean deleteAlgorithm(long algorithmId) throws DataStorageException{
		
		boolean ret = false;
		
		try{
			Session session = sessionFactory.openSession();		
			
			Algorithm docEntity = (Algorithm) session.get(Algorithm.class, Long.valueOf(algorithmId).intValue());
			
			if(docEntity != null && Long.valueOf(docEntity.getAlgorithmid()).equals(algorithmId)){
				session.beginTransaction();
				
				session.delete(docEntity);
				
				session.getTransaction().commit();
				session.close();
				ret = true;
			}else{
				throw new DataStorageException("Algorithm does not exist");	
			}
						
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return ret;
	}

	/** Update a single Algorithm
	 * 
	 * @param uiName - Human friendly name to be used by the UI when listing services.
	 * @param serviceID - Foreign key to the "service" table, which will contain the URL and description meta-data for a single web service.  
	 * @param serviceMethod - Name of the method which executes the algorithm, within the webservice. e.g. "sqrsWrapperType2".
	 * @param shortDescription - Short summary description suitable for displaying as a tooltip.
	 * @param completeDescription - Complete description of the algorithm suitable for using in a manual/help file.
	 * @return - primary key of the algorithm entry.
	 * @author Michael Shipway
	 */
	@Override
	public Integer updateAlgorithm(Integer algorithmid, String uiName, Integer serviceID, String serviceMethod, 
			String shortDescription,
			String completeDescription, String resultformat) throws DataStorageException {
			
		int algID=-1;
		
		try{
			Session session = sessionFactory.openSession();		
			session.beginTransaction();
			
			Algorithm alg = new Algorithm(uiName, serviceID, serviceMethod, shortDescription, completeDescription);
			alg.setAlgorithmid(algorithmid);
			alg.setResultformat(resultformat);
			session.update(alg);
			
			session.getTransaction().commit();
			session.close();
			
			algID = alg.getAlgorithmid();
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return algID;
	}


	/** Store a single Algorithm Parameter
	 * 
	 * @param paramDTO - Algorithm parameter to be stored in the database.
	 * @param algorithmID - Primary key of the algorithm this parameter pertains to.
	 * @return Algorithm Parameter's ID (Primary key in the database)
	 * @author Michael Shipway
	 */
	@Override
	public Integer storeAlgorithmParameter(AdditionalParametersDTO paramDTO, int algorithmID) throws DataStorageException {
			
		int paramID=-1;
		
		try{
			
			ParameterValidatorDTO validatorDTO = paramDTO.getValidator();
			
			ParameterValidator validator = null;
			if(validatorDTO != null && validatorDTO.getType() != 0){
				Session session = sessionFactory.openSession();		
				session.beginTransaction();
				
				validator = new ParameterValidator(validatorDTO.getType(), validatorDTO.getMessage(), validatorDTO.getMin(), validatorDTO.getMax(), validatorDTO.getRegex());
				
				session.persist(validator);
				session.getTransaction().commit();
				session.close();
			}
			
			int paramType = this.getParameterTypeId(paramDTO.getType());
			
			Session session = sessionFactory.openSession();		
			session.beginTransaction();
			
			Parameter param = new Parameter(paramDTO.getDisplayShortName(), 
							algorithmID, 
							paramDTO.getDisplayShortName(), 
							paramDTO.getLongDescription(), 
							paramDTO.getParameterFlag(), 
							paramDTO.getParameterDefaultValue(), 
							paramType, 
							!paramDTO.getOptional(), 
							false);
			
			param.setValidator(validator);
			
			session.persist(param);
			session.getTransaction().commit();
			System.out.println("Algorithm parameter database entry " + paramDTO.getDisplayShortName() + " wasCommitted(): " + session.getTransaction().wasCommitted());
			session.close();
			
			paramID = param.getParameterID();
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return paramID;
	}
	
	
	/** Update a single Algorithm Parameter
	 * 
	 * @param paramDTO - Algorithm parameter to be stored in the database.
	 * @param iAlgorithmID - Primary key of the algorithm this parameter pertains to.
	 * @return
	 * @author Michael Shipway
	 */
	@Override
	public Integer updateAlgorithmParameter(AdditionalParametersDTO paramDTO, int iAlgorithmID) throws DataStorageException {
			
		int algID=-1;
		
		try{
			
			Session session = sessionFactory.openSession();
			
			Parameter paramEntity = (Parameter) session.get(Parameter.class, paramDTO.getId());
			
			ParameterValidator validator = null;
			if(paramDTO.getValidator() != null){
				session.beginTransaction();
				
				validator = paramEntity.getValidator();
				validator.setMax(paramDTO.getValidator().getMax());
				validator.setMessage(paramDTO.getValidator().getMessage());
				validator.setMin(paramDTO.getValidator().getMin());
				validator.setRegex(paramDTO.getValidator().getRegex());
				validator.setValidatorType(paramDTO.getValidator().getType());
				
				session.update(validator);
				session.getTransaction().commit();
				session.close();
			}
			
			session = sessionFactory.openSession();
			
			Parameter param = this.buildParameter(paramDTO, iAlgorithmID, validator);
					
			session.beginTransaction();
			session.update(param);
			session.getTransaction().commit();
			
			System.out.println("Algorithm parameter database entry " + paramDTO.getDisplayShortName() + " wasCommitted(): " + session.getTransaction().wasCommitted());
			session.close();
			
			algID = param.getAlgorithmid();
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return algID;
	}
	
	@Override
	public boolean deleteParameter(long parameterId) throws DataStorageException{
		
		boolean ret = false;
		
		try{
			Session session = sessionFactory.openSession();		
			
			Parameter entity = (Parameter) session.get(Parameter.class, Long.valueOf(parameterId).intValue());
			
			if(entity != null && Long.valueOf(entity.getParameterID()).equals(parameterId)){
				session.beginTransaction();
				
				session.delete(entity);
				
				session.getTransaction().commit();
				session.close();
				ret = true;
			}else{
				throw new DataStorageException("Parameter does not exist");	
			}
						
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return ret;
	}
	private int updateParameterValidator(ParameterValidatorDTO paramVal){
		int valID = -1;
		if((paramVal != null) && (paramVal.getId() != -1)){
			ParameterValidator aws_val = new ParameterValidator(paramVal.getType(), paramVal.getMessage(), paramVal.getMin(), paramVal.getMax(), paramVal.getRegex());
			aws_val.setParameterValidationid(paramVal.getId());
			Session session = sessionFactory.openSession();		
			session.beginTransaction();
			session.update(aws_val);
			session.getTransaction().commit();
			valID = aws_val.getParameterValidationid();
			session.close();
		}

		return valID;
	}

	private Parameter buildParameter(AdditionalParametersDTO paramDTO, int iAlgorithmID, ParameterValidator validator){
		
		int paramType = getParameterTypeId(paramDTO.getType());
		
		Parameter param = new Parameter(paramDTO.getDisplayShortName(), 
						iAlgorithmID, 
						paramDTO.getDisplayShortName(), 
						paramDTO.getLongDescription(), 
						paramDTO.getParameterFlag(), 
						paramDTO.getParameterDefaultValue(), 
						paramType, 
						!paramDTO.getOptional(), 
						false);
		
		param.setValidator(validator);
		
		param.setParameterID(paramDTO.getId());
		return param;
	}

	private int getParameterTypeId(String type) {
		
		int paramType = 1; // text type parameter
		if(type.contains("text")) {
			paramType = 1;
		}else if(type.contains("integer")){
			paramType = 2;
		}else if(type.contains("float")){
			paramType = 3;
		}else if(type.contains("boolean")){
			paramType = 4;
		}else if(type.contains("select")){
			paramType = 5;
		}else if(type.contains("drill_down")){
			paramType = 6;
		}else if(type.contains("data_column")){
			paramType = 7;
		}
		
		return paramType;
	}

	/** Store a single Web Service
	 * 
	 * @param uiName - Human friendly name to be used by the UI when listing services.
	 * @param wsName - The web service’s name to be used in the URL when calling the service.   e.g. "physionetAnalysisService"
	 * @param url - URL of the server containing the web services e.g. http://128.220.76.170:8080/axis2/services. <BR>
	 *        This is used together with “service.wsName” and "algorithm.method”. <BR>
	 *        e.g. http://128.220.76.170:8080/axis2/services/physionetAnalysisService/sqrsWrapperType2
	 * @return - the primary key of the new entry in the service table.
	 * @author Michael Shipway
	 */
	@Override
	public Integer storeService(String uiName, String wsName, String url) throws DataStorageException {
			
		int serviceID=-1;
		
		try{
			Session session = sessionFactory.openSession();		
			session.beginTransaction();
			
			Service serv = new Service(uiName, wsName, url);
			session.persist(serv);
			serviceID = serv.getServiceid();

			session.getTransaction().commit();
			session.close();			
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return serviceID;
	}

	
	/** Update a single Web Service
	 * 
	 * @param service - Service to be Updated in the database.
	 * @return service id (Primary key in database)
	 * @author Michael Shipway
	 */
	@Override
	public Integer updateWebService(ServiceDTO service) throws DataStorageException {
			
		int serviceID=-1;
		
		try{
			Session session = sessionFactory.openSession();		
			session.beginTransaction();
			
			Service serv_aws = new Service(service);
			session.saveOrUpdate(serv_aws);
			serviceID = serv_aws.getServiceid();

			session.getTransaction().commit();
			session.close();			
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return serviceID;
	}
	
	@Override
	public boolean deleteservice(Integer serviceId) throws DataStorageException{
		
		boolean ret = false;
		
		try{
			Session session = sessionFactory.openSession();		
			
			Service docEntity = (Service) session.get(Service.class, serviceId);
			
			if(docEntity != null && serviceId.equals(docEntity.getServiceid())){
				session.beginTransaction();
				
				session.delete(docEntity);
				
				session.getTransaction().commit();
				session.close();
				ret = true;
			}else{
				throw new DataStorageException("Service does not exist");	
			}
						
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return ret;
	}
	

	private AnnotationDTO annotation2DTO(AnnotationInfo entity){
		AnnotationDTO dto = new AnnotationDTO(entity.getDocumentRecord().getUserId(), entity.getDocumentRecordId(), entity.getCreatedBy(), entity.getAnnotationtype(), entity.getName(), entity.getBioportalOntology(), entity.getBioportalClassId(), 
				entity.getBioportalReferenceLink(), entity.getLeadIndex(), entity.getUnitOfMeasurement(), entity.getDescription(), entity.getValue(), null, null,null, null, null);
	
		if(entity.getStartCoordinate() != null){
			dto.setStartXcoord(entity.getStartCoordinate().getxCoordinate());
			dto.setStartYcoord(entity.getStartCoordinate().getyCoordinate());
		}
		
		if(entity.getEndCoordinate() != null){
			dto.setEndXcoord(entity.getEndCoordinate().getxCoordinate());
			dto.setEndYcoord(entity.getEndCoordinate().getyCoordinate());
		}
		
		Calendar cal = new GregorianCalendar();
		cal.setTime( entity.getTimestamp());
		dto.setTimestamp(cal);
		dto.setAnnotationId(entity.getAnnotationId());
		
		return dto;
	}

	@Override
	public boolean deleteDocumentRecord(long userId, long documentRecordId) throws DataStorageException{
		
		boolean ret = false;
		
		try{
			Session session = sessionFactory.openSession();		
			
			DocumentRecord docEntity = (DocumentRecord) session.get(DocumentRecord.class, documentRecordId);
			
			if(docEntity != null && docEntity.getUserId().equals(userId)){
				session.beginTransaction();
				
				session.delete(docEntity);
				
				session.getTransaction().commit();
				session.close();
				ret = true;
			}else{
				throw new DataStorageException("Document Record not exist for this user");	
			}
						
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return ret;
	}
	
	@Override
	public boolean deleteAllFilesByDocumentRecordId(long documentRecordId) throws DataStorageException{
		
		boolean ret = false;
		
		try{
			Session session = sessionFactory.openSession();		
			
			DocumentRecord docEntity = (DocumentRecord) session.get(DocumentRecord.class, documentRecordId);
			
			if(docEntity != null && docEntity.getDocumentRecordId().equals(documentRecordId)){
				session.beginTransaction();
				
				for (FileInfo f : docEntity.getFilesInfo()) {
					session.delete(f);	
				}
				
				session.getTransaction().commit();
				session.close();
				ret = true;
			}else{
				throw new DataStorageException("Document Record not exist");	
			}
						
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return ret;
	}

	@Override
	public List<AnalysisJobDTO> getAnalysisJobByUser(long userId) throws DataStorageException {
		List<AnalysisJobDTO> ret = new ArrayList<AnalysisJobDTO>();
		
		try {
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select a from AnalysisJob a where a.userId = :userid and a.analysisTime is null order by a.analysisJobId desc");
			
			q.setParameter("userid", userId);
			
			@SuppressWarnings("unchecked")
			List<AnalysisJob> l = q.list();
			
			for (int i = 0; i < l.size(); i++) {
				AnalysisJob entity = l.get(i);
				ret.add(new AnalysisJobDTO(entity.getAnalysisJobId(), entity.getDocumentRecordId(), entity.getFileCount(), entity.getParameterCount(), entity.getServiceName(), entity.getServiceUrl(), entity.getServiceMethod(), entity.getDateOfAnalysis(), entity.getUserId(), entity.getAnalysisTime(), entity.getMessage()));
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	@Override
	public boolean updateAnalysisStatus(long analysisJobId, Long analysisTime, String message) throws DataStorageException {
		
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			
			AnalysisJob entity = null;
			
			entity = (AnalysisJob) session.load(AnalysisJob.class, analysisJobId);
			
			if(analysisTime != null){
				entity.setAnalysisTime(analysisTime);	
			}
			
			if(message != null){
				if (message.length()>300) {
					message = message.substring(0, 295) + "...";
				}
				entity.setMessage(message);
			}
			
			session.persist(entity);
			
			session.getTransaction().commit();
			session.close();
			
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		
	}
	
	public List<AnalysisStatusDTO> getAnalysisStatusByUserAndAnalysisId(long userId, Set<Long> analysisIds) throws DataStorageException{
		
		List<AnalysisStatusDTO> ret = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			StringBuilder hql = new StringBuilder();
			hql.append(" select d.documentRecordId, d.recordName, count(a.analysisJobId), count( a.analysisTime ), count( a.message ) from DocumentRecord d inner join d.analysisJobs a with ( a.userId = :userId ");
			
			
			if(analysisIds != null){
				hql.append(" and a.analysisJobId in (:analysisIds) ");
			}
			
			hql.append(") group by d.documentRecordId, d.recordName order by d.recordName ");

			Query q = session.createQuery(hql.toString());
			q.setParameter("userId", userId);
			
			if(analysisIds != null){
				q.setParameterList("analysisIds", analysisIds);	
			}
			
			List<Object[]> entities = q.list();
			
			if(entities != null && !entities.isEmpty()){
				ret = new ArrayList<AnalysisStatusDTO>();
				
				hql = new StringBuilder();
				hql.append("select a from AnalysisJob a where a.userId = :userId and a.documentRecordId = :docId ");
				if(analysisIds != null){
					hql.append(" and a.analysisJobId in (:analysisIds) ");
				}
				q = session.createQuery(hql.toString());
				q.setParameter("userId", userId);
				if(analysisIds != null){
					q.setParameterList("analysisIds", analysisIds);	
				}
								
				for (Object[] entity : entities) {
					AnalysisStatusDTO dto = new AnalysisStatusDTO((Long) entity[0], entity[1].toString(), ((Long) entity[2]).intValue(), ((Long) entity[3]).intValue(), ((Long) entity[4]).intValue());
					
					q.setParameter("docId", dto.getDocumentRecordId());
					List<AnalysisJob> analysis = q.list();
					if(analysis != null && analysis.size() > 0){
						List<String> messages = new ArrayList<String>();
						List<Long> ids = new ArrayList<Long>();
						for (AnalysisJob a : analysis) {
							messages.add(a.getMessage());
							ids.add(a.getAnalysisJobId());
							
						}
						dto.setMessages(messages);
						dto.setAnalysisIds(ids);
					}
				
					ret.add(dto);
				}
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		return ret;
	}

	@Override
	public Long storeVirtualNode(long userId, String nodeName, String externalReference, Long parentNode) throws DataStorageException {
		Long nodeId = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			VirtualNode record = new VirtualNode(externalReference, nodeName, userId, parentNode);
			
			session.save(record);
			
			session.getTransaction().commit();
			session.close();
			
			nodeId = record.getNodeId();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return nodeId;
	}
	
	@Override
	public Long storeVirtualDocument(long userId, long documentRecordId, long virtualNodeId, String virtualDocumentName) throws DataStorageException {
		Long virtalDocId = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			VirtualDocument record = new VirtualDocument(virtualNodeId, documentRecordId, userId, virtualDocumentName);
			
			session.save(record);
			
			session.getTransaction().commit();
			session.close();
			
			virtalDocId = record.getVirtualDocumentId();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return virtalDocId;
	}

	public void updateVirtualDocumentReferences(long documentRecordId, String virtualDocumentName) throws DataStorageException {
		try {
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			
			Query q = session.createQuery("select n from VirtualNode n left outer join n.virtualDocuments d where n.nodeName = :nodeName and n.parentnodeId is not null and d.virtualDocumentId is null");
			
			q.setParameter("nodeName", virtualDocumentName);
			
			List<VirtualNode> nodes = q.list();
			
			for (VirtualNode virtualNode : nodes) {
				List<VirtualDocument> docs = virtualNode.getVirtualDocuments();
				if(docs == null || docs.isEmpty()){
					session.save(new VirtualDocument(virtualNode.getNodeId(), documentRecordId, virtualNode.getUserId(), virtualDocumentName));		
				}
			}
			
			session.getTransaction().commit();
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
	}
	
	
	
	@Override
	public Collection<VirtualNodeDTO> getAllVirtualNodesByUser(long userId) throws DataStorageException {
		Collection<VirtualNodeDTO> ret = null;
		
		try {
			
			TreeMap<Long, VirtualNodeDTO> mapNodes = new TreeMap<Long, VirtualNodeDTO>();
			
			Session session = sessionFactory.openSession();
			
			Query q = session.createQuery("select n from VirtualNode n where n.userId = :userid order by n.parentnodeId desc");
			
			q.setParameter("userid", userId);
			
			List<VirtualNode> l = q.list();
			
			for (int i = 0; i < l.size(); i++) {
				VirtualNode entity = l.get(i);
				VirtualNodeDTO dto = new VirtualNodeDTO(entity.getNodeId(), entity.getNodeName(), entity.getExternalReference(), true);
				
				if(entity.getParentnodeId() != null){
					VirtualNodeDTO parentNode = mapNodes.get(entity.getParentnodeId());
					parentNode.addChild(dto);
					
					dto.setChildren(this.getVirtualDocuments(entity.getNodeId(), userId));
					
				}else{
					mapNodes.put(entity.getNodeId(), dto);
				}
			}
			
			ret = mapNodes.values();
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}


	private List<VirtualNodeDTO> getVirtualDocuments(Long virtualNodeId, long userId)throws DataStorageException {
		List<VirtualNodeDTO> ret = null;
		
		try {
			Session session = sessionFactory.openSession();
			
			String hql = "select n from VirtualDocument n where n.userId = :userid";
			
			if(virtualNodeId != null){
				hql += " and n.id.virtualNodeId = :virtualNodeId";
			}
			
			Query q = session.createQuery(hql);
			
			q.setParameter("userid", userId);
			
			if(virtualNodeId != null){
				q.setParameter("virtualNodeId", virtualNodeId);	
			}
			
			List<VirtualDocument> l = q.list();
			
			if(!l.isEmpty()){
				ret = new ArrayList<VirtualNodeDTO>();
				for (int i = 0; i < l.size(); i++) {
					VirtualDocument entity = l.get(i);
					ret.add(new VirtualNodeDTO(entity.getDocumentRecordId(), entity.getVirtualDocumentName(), null, false));
				}
			}
			
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			log.error("Error on retrive the Virtual Documents for user " + userId + ". Message: " + e.getMessage());
			return null;
		}
		
		return ret;
	}

	@Override
	public DocumentRecordDTO getDocumentRecordBySubjectId(String subjectId, boolean shared) throws DataStorageException {
		
		DocumentRecordDTO ret = null;
		
		try {
			String hql = "select d from DocumentRecord d where d.subjectId = :subjectId";
			
			if(shared){
				hql += " and d.fileTreePath = :treepath";
			}else{
				hql += " and d.fileTreePath != :treepath";
			}
			
			Session session = sessionFactory.openSession();
			Query q = session.createQuery(hql);
			
			q.setParameter("subjectId", subjectId);
			q.setParameter("treepath", "Eureka");
			
			@SuppressWarnings("unchecked")
			List<DocumentRecord> l = q.list();
			
			if(l.size() > 0){
				DocumentRecord entity = l.get(0);
				ret = new DocumentRecordDTO(entity.getDocumentRecordId(), entity.getRecordName(), entity.getUserId(), entity.getSubjectId(), FileType.getTypeById(entity.getOriginalFormat()), entity.getSamplingRate(), entity.getFileTreePath(),entity.getLeadCount(), entity.getNumberOfPoints(), entity.getDateOfUpload(), entity.getAge(), entity.getGender(), entity.getDateOfRecording(), entity.getAduGain(), entity.getLeadNames(), entity.getTimeSeriesId());
			}
			session.close();
		} catch (HibernateException e) {
			e.printStackTrace();
			throw new DataStorageException(e);
		}
		
		return ret;
	}
	
	@Override
	public boolean deleteVirtualNode(long userId, long nodeId) throws DataStorageException{
		
		boolean ret = false;
		
		try{
			Session session = sessionFactory.openSession();		
			
			VirtualNode entity = (VirtualNode) session.get(VirtualNode.class, nodeId);
			
			if(entity != null && entity.getUserId().equals(userId)){
				session.beginTransaction();
				
				session.delete(entity);
				
				session.getTransaction().commit();
				session.close();
				ret = true;
			}else{
				throw new DataStorageException("The Node("+nodeId+") not exist for this user");	
			}
						
		}catch(HibernateException ex){
			ex.printStackTrace();
			throw new DataStorageException(ex);
		}
		
		return ret;
	}
	
	
}
