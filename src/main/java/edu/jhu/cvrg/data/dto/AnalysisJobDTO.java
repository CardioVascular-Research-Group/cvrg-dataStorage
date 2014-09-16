package edu.jhu.cvrg.data.dto;

import java.io.Serializable;
import java.util.Date;


public class AnalysisJobDTO implements Serializable{

	private static final long serialVersionUID = 1299576684818750458L;
	
	private Long analysisJobId;
	private long documentRecordId;
	private int fileCount;
	private int parameterCount;
	private String serviceName;
	private String serviceUrl;
	private String serviceMethod;
	private Date dateOfAnalysis;
	private long userId;
	
	public AnalysisJobDTO(Long analysisJobId, long documentRecordId,
			int fileCount, int parameterCount, String serviceName,
			String serviceUrl, String serviceMethod, Date dateOfAnalysis, long userId) {
		super();
		this.analysisJobId = analysisJobId;
		this.documentRecordId = documentRecordId;
		this.fileCount = fileCount;
		this.parameterCount = parameterCount;
		this.serviceName = serviceName;
		this.serviceUrl = serviceUrl;
		this.serviceMethod = serviceMethod;
		this.userId = userId;
		this.dateOfAnalysis = dateOfAnalysis;
	}
	
	public Long getAnalysisJobId() {
		return analysisJobId;
	}
	public void setAnalysisJobId(Long analysisJobId) {
		this.analysisJobId = analysisJobId;
	}
	public long getDocumentRecordId() {
		return documentRecordId;
	}
	public void setDocumentRecordId(long documentRecordId) {
		this.documentRecordId = documentRecordId;
	}
	public int getFileCount() {
		return fileCount;
	}
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}
	public int getParameterCount() {
		return parameterCount;
	}
	public void setParameterCount(int parameterCount) {
		this.parameterCount = parameterCount;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getServiceUrl() {
		return serviceUrl;
	}
	public void setServiceUrl(String serviceUrl) {
		this.serviceUrl = serviceUrl;
	}
	public String getServiceMethod() {
		return serviceMethod;
	}
	public void setServiceMethod(String serviceMethod) {
		this.serviceMethod = serviceMethod;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public Date getDateOfAnalysis() {
		return dateOfAnalysis;
	}

	public void setDateOfAnalysis(Date dateOfAnalysis) {
		this.dateOfAnalysis = dateOfAnalysis;
	}
	
	
	
}
