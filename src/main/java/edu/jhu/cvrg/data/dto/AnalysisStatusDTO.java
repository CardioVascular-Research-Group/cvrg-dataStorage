package edu.jhu.cvrg.data.dto;

import java.io.Serializable;
import java.util.List;

public class AnalysisStatusDTO implements Serializable{

	private static final long serialVersionUID = 8211275632166807135L;

	private Long documentRecordId;
	private String recordName;
	private int totalAnalysis;
	private int doneAnalysis;
	private int errorAnalysis;
	
	private List<Long> analysisIds;
	private List<String> messages;
	
	public AnalysisStatusDTO(Long documentRecordId, String recordName,int totalAnalysis, int doneAnalysis, int errorAnalysis) {
		super();
		this.documentRecordId = documentRecordId;
		this.recordName = recordName;
		this.totalAnalysis = totalAnalysis;
		this.doneAnalysis = doneAnalysis;
		this.errorAnalysis = errorAnalysis;
	}
	
	public Long getDocumentRecordId() {
		return documentRecordId;
	}
	public void setDocumentRecordId(Long documentRecordId) {
		this.documentRecordId = documentRecordId;
	}
	public String getRecordName() {
		return recordName;
	}
	public void setRecordName(String recordName) {
		this.recordName = recordName;
	}
	public int getTotalAnalysis() {
		return totalAnalysis;
	}
	public void setTotalAnalysis(int totalAnalysis) {
		this.totalAnalysis = totalAnalysis;
	}
	public int getDoneAnalysis() {
		return doneAnalysis;
	}
	public void setDoneAnalysis(int doneAnalysis) {
		this.doneAnalysis = doneAnalysis;
	}

	public int getErrorAnalysis() {
		return errorAnalysis;
	}

	public void setErrorAnalysis(int errorAnalysis) {
		this.errorAnalysis = errorAnalysis;
	}
	
	public List<String> getMessages() {
		return messages;
	}

	public void setMessages(List<String> messages) {
		this.messages = messages;
	}
	
	public void update(AnalysisStatusDTO newObj){
		if(this.equals(newObj)){
			this.setDoneAnalysis(newObj.getDoneAnalysis());
			this.setErrorAnalysis(newObj.getErrorAnalysis());
			this.setTotalAnalysis(newObj.getTotalAnalysis());
			this.setMessages(newObj.getMessages());
			this.setAnalysisIds(newObj.getAnalysisIds());
			
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime
				* result
				+ ((documentRecordId == null) ? 0 : documentRecordId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AnalysisStatusDTO other = (AnalysisStatusDTO) obj;
		if (documentRecordId == null) {
			if (other.documentRecordId != null)
				return false;
		} else if (!documentRecordId.equals(other.documentRecordId))
			return false;
		return true;
	}

	public List<Long> getAnalysisIds() {
		return analysisIds;
	}

	public void setAnalysisIds(List<Long> analysisIds) {
		this.analysisIds = analysisIds;
	}
	
	public boolean isCompleted(){
		return (doneAnalysis + errorAnalysis == totalAnalysis);
	} 
	
	public String getState(){
		if(doneAnalysis == totalAnalysis){
			return "DONE";
		}else if(errorAnalysis == totalAnalysis){
			return "ERROR";
		}else if(errorAnalysis > 0){
			return "WARN";
		}else{
			return "";
		}
	}
}
