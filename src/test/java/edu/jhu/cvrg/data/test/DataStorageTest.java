package edu.jhu.cvrg.data.test;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.junit.Assert;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

import edu.jhu.cvrg.data.dto.AdditionalParametersDTO;
import edu.jhu.cvrg.data.dto.AlgorithmDTO;
import edu.jhu.cvrg.data.dto.AnalysisJobDTO;
import edu.jhu.cvrg.data.dto.AnalysisStatusDTO;
import edu.jhu.cvrg.data.dto.AnnotationDTO;
import edu.jhu.cvrg.data.dto.DocumentRecordDTO;
import edu.jhu.cvrg.data.dto.FileInfoDTO;
import edu.jhu.cvrg.data.dto.ServiceDTO;
import edu.jhu.cvrg.data.dto.UploadStatusDTO;
import edu.jhu.cvrg.data.enums.FileType;
import edu.jhu.cvrg.data.enums.UploadState;
import edu.jhu.cvrg.data.factory.Connection;
import edu.jhu.cvrg.data.factory.ConnectionFactory;
import edu.jhu.cvrg.data.util.DataStorageException;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DataStorageTest{
	
	private static Connection dataStorage = null;
	private static AlgorithmDTO algorithm = null;
	
	private static DocumentRecordDTO document = null;
	
	private long fileId = 900000L;
	private long userId = 999999999L;
	private static AnalysisJobDTO analysisJob;
	private static Long annotationId;
	
	@Before
	public void setup() {
		try {
			if(dataStorage == null){
				dataStorage = ConnectionFactory.createConnection();
				document = new DocumentRecordDTO(null, "testRecord.xml", userId, "testSubject", FileType.PHILIPS_104, 125.00, "/999999999/testFolder/testRecord", 12, 13400874, new Date(), 71, "Unknown", null, 200.00);
			}
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
	}
	
	
	@Test
	public void test01getAvailableAlgorithmList() {
		List<AlgorithmDTO> dtos =  null;
		
		try {
			dtos =  dataStorage.getAvailableAlgorithmList(0L);
			
			if(dtos != null && !dtos.isEmpty()){
				algorithm = dtos.get(0);	
			}
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		
		Assert.assertTrue(dtos != null && !dtos.isEmpty());
 	}
	
	@Test
	public void test02getAlgorithmParameterArray() {
		List<AdditionalParametersDTO> params = null;
		
		try {
			if(algorithm != null){
				params = dataStorage.getAlgorithmParameterArray(algorithm.getId());
			}
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		
		Assert.assertTrue(params != null && !params.isEmpty());
	}
	
	@Test
	public void test03getAvailableServiceList() {
		List<ServiceDTO> services = null;
		
		try {
			services = dataStorage.getAvailableServiceList(0L);
			
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		
		Assert.assertTrue(services != null && !services.isEmpty());
	}
	
	@Test
	public void test0400StoreDocument() {
		Long documentRecordId = null;
		try {
			long[] filesId = new long[]{fileId};
			
			documentRecordId = dataStorage.storeDocument(document.getUserId(), document.getRecordName(), document.getSubjectId(), document.getOriginalFormat().ordinal(), document.getSamplingRate(), document.getFileTreePath(), document.getLeadCount(), document.getNumberOfPoints(), null, document.getAge(), document.getGender(), null, document.getAduGain(), filesId);
			document.setDocumentRecordId(documentRecordId);
			
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		
		Assert.assertTrue(documentRecordId != null);
	}
	
	
	@Test
	public void test0401StoreAnnotation() {
		try {
			AnnotationDTO annotation = new AnnotationDTO(userId, document.getDocumentRecordId(), null, 
														 "ANNOTATION", "testName", "ECGT", "ECGTermsv1:ECG_000001091", 
														 "http://purl.bioontology.org/ontology/ECGT/ECGTermsv1:ECG_000001091", 
														 0, null, null, "57.00000", new GregorianCalendar(), null, null, null, null);
			
			annotationId = dataStorage.storeAnnotation(annotation);
			
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		
		Assert.assertTrue(annotationId != null);
	}
	
	@Test
	public void test0402StoreAnnotations() {
		Long count = null;
		try {
			Set<AnnotationDTO> annSet = new HashSet<AnnotationDTO>();
			
			AnnotationDTO annotation = new AnnotationDTO(userId, document.getDocumentRecordId(), null, 
														 "ANNOTATION", "testWholeLeadAnnotation", "ECGT", "ECGTermsv1:ECG_000001091", 
														 "http://purl.bioontology.org/ontology/ECGT/ECGTermsv1:ECG_000001091", 
														 0, null, null, "57.00000", new GregorianCalendar(), 0.1, 0.1, 0.1, 0.1);
			
			annSet.add(annotation);
			
			annotation = new AnnotationDTO(userId, document.getDocumentRecordId(), null, 
					 "ANNOTATION", "testName", "ECGT", "ECGTermsv1:ECG_000001091", 
					 "http://purl.bioontology.org/ontology/ECGT/ECGTermsv1:ECG_000001091", 
					 0, null, null, "57.00000", new GregorianCalendar(), 0.2, 0.2, null, null);
			
			annSet.add(annotation);
			
			count = dataStorage.storeAnnotations(annSet);
			
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		
		Assert.assertTrue(count != null && count > 0);
	}

	@Test
	public void test0403StoreAnalysis() {
		try {
			analysisJob = dataStorage.storeAnalysisJob(document.getDocumentRecordId(), 2, 0, "http://localhost:8080/axis2/services", "physionetAnalysisService", "chesnokovWrapperType2", new Date(), userId);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(analysisJob != null);
	}
	@Test
	public void test0404StoreAnalysisFile() {
		boolean ret = false;
		try {
			ret = dataStorage.storeFilesInfo(document.getDocumentRecordId(), new long[]{fileId+1,fileId+2}, analysisJob.getAnalysisJobId());
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret);
	}

	@Test
	public void test0405getECGFilesByDocumentRecordId() {
		List<FileInfoDTO> ret = null;
		try {
			ret = dataStorage.getECGFilesByDocumentRecordId(document.getDocumentRecordId());
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null && ret.size() == 1);
	}
	
	@Test
	public void test0406getAllFilesByDocumentRecordId() {
		List<FileInfoDTO> ret = null;
		try {
			ret = dataStorage.getAllFilesByUser(userId);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null && ret.size() == 3);
	}
	
	@Test
	public void test0407getAnalysisJobById() {
		AnalysisJobDTO ret = null;
		try {
			ret = dataStorage.getAnalysisJobById(analysisJob.getAnalysisJobId());
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null);
	}
	
	@Test
	public void test0408getDocumentRecordById() {
		DocumentRecordDTO ret = null;
		try {
			ret = dataStorage.getDocumentRecordById(document.getDocumentRecordId());
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null);
	}
	
	@Test
	public void test0409getAnalysisJobById() {
		int[][] ret = null;
		try {
			ret = dataStorage.getAnnotationCountPerLead(document.getDocumentRecordId(), 12);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null && ret[0][1] == 3);
	}
	
	@Test
	public void test0410getAnnotationById() {
		AnnotationDTO ret = null;
		try {
			ret = dataStorage.getAnnotationById(userId, annotationId);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null);
	}
	
	@Test
	public void test0411getLeadAnnotationNode() {
		List<AnnotationDTO> ret = null;
		try {
			ret = dataStorage.getLeadAnnotationNode(userId, document.getDocumentRecordId(), 0);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null && ret.size() == 3);
	}

	@Test
	public void test0412getUploadStatusByUser() {
		boolean ret = false;
		try {
			ret = dataStorage.updateUploadStatus(document.getDocumentRecordId(), UploadState.VALIDATION, 200L, null, null);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret);
	}
	
	@Test
	public void test0413getUploadStatusByUser() {
		List<UploadStatusDTO> ret = null;
		try {
			ret = dataStorage.getUploadStatusByUser(userId);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null);
	}
	
	@Test
	public void test0414getUploadStatusByUserAndDocId() {
		List<UploadStatusDTO> ret = null;
		try {
			Set<Long> docs = new HashSet<Long>();
			docs.add(document.getDocumentRecordId());
			ret = dataStorage.getUploadStatusByUserAndDocId(userId, docs);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		Assert.assertTrue(ret != null);
	}
	
	
	@Test
	public void test05DeleteDocument() {
		boolean ret = false; 
		try {
			ret = dataStorage.deleteDocumentRecord(userId, document.getDocumentRecordId());
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		
		Assert.assertTrue(ret);
	}
	
	public void test06getAnalysisStatusByUserAndAnalysisId(){
		List<AnalysisStatusDTO> ret = null; 
		try {
			ret = dataStorage.getAnalysisStatusByUserAndAnalysisId(10405, null);
		} catch (DataStorageException e) {
			e.printStackTrace();
		}
		
		if(ret != null){
			
			for (AnalysisStatusDTO analysisStatusDTO : ret) {
				System.out.println(analysisStatusDTO.getDocumentRecordId() + " - " + analysisStatusDTO.getRecordName() + " ("+analysisStatusDTO.getDoneAnalysis()+"/"+analysisStatusDTO.getTotalAnalysis()+")");
			}
		}
	}

	
	@Test
	public void testClose(){
		dataStorage.close();
	}
	
	public static void main(String[] args) throws DataStorageException {
		DataStorageTest test = new DataStorageTest();
		test.setup();
		test.test06getAnalysisStatusByUserAndAnalysisId();
		
	}
}
