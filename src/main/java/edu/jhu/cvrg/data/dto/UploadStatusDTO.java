package edu.jhu.cvrg.data.dto;

import java.io.Serializable;

import edu.jhu.cvrg.data.enums.UploadState;

public class UploadStatusDTO implements Serializable{

	private static final long serialVersionUID = -7889800188881558221L;
	
	private Long documentRecordId;
	private String recordName;
	private Long annotationTime;
	private Long transferReadTime;
	private Long validationTime;
	private Long writeTime;
	private Boolean status;
	private String message;
	
	
	public UploadStatusDTO() {
	}
	
	public UploadStatusDTO(Long documentRecordId, Long annotationTime,
			Long transferReadTime, Long validationTime, Long writeTime,
			Boolean status, String message) {
		super();
		this.documentRecordId = documentRecordId;
		this.annotationTime = annotationTime;
		this.transferReadTime = transferReadTime;
		this.validationTime = validationTime;
		this.writeTime = writeTime;
		this.status = status;
		this.message = message;
	}
	
	
	public Long getDocumentRecordId() {
		return documentRecordId;
	}
	public void setDocumentRecordId(Long documentRecordId) {
		this.documentRecordId = documentRecordId;
	}
	public Long getAnnotationTime() {
		return annotationTime;
	}
	public void setAnnotationTime(Long annotationTime) {
		this.annotationTime = annotationTime;
	}
	public Long getTransferReadTime() {
		return transferReadTime;
	}
	public void setTransferReadTime(Long transferReadTime) {
		this.transferReadTime = transferReadTime;
	}
	public Long getValidationTime() {
		return validationTime;
	}
	public void setValidationTime(Long validationTime) {
		this.validationTime = validationTime;
	}
	public Long getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(Long writeTime) {
		this.writeTime = writeTime;
	}
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
	public String getRecordName() {
		return recordName;
	}
	public void setRecordName(String recordName) {
		this.recordName = recordName;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	

	public UploadState getState(){
		
		UploadState actualPhase = UploadState.WAIT;
		
		if(annotationTime != null){
			actualPhase = UploadState.DONE;
		}else if(writeTime != null){
			actualPhase = UploadState.ANNOTATION;
		}else if(transferReadTime != null){
			actualPhase = UploadState.WRITE;
		}else if(validationTime != null){
			actualPhase = UploadState.TRANSFER_READ;
		}
		
		if(status != null){
			if(status){
				actualPhase = UploadState.DONE;
				if(this.getMessage() != null){
					actualPhase = UploadState.WARN;
				}
			}else{
				actualPhase = UploadState.ERROR;	
			}
		}
	
		return actualPhase;
	}
	
	
	public int getProgress(){
		int progress = 0;
		
		switch (getState()) {
			case WAIT: progress = 0; break;
			case VALIDATION: progress = 20; break;
			case TRANSFER_READ: progress = 40; break;
			case WRITE: progress = 60; break;
			case ANNOTATION: progress = 80; break;
			case DONE: progress = 100; break;
			case WARN: progress = 100; break;
			case ERROR: progress = 100; break;
		}

		return progress;
	}
	
	
	public void update(UploadStatusDTO newStatus){
		
		this.setAnnotationTime(newStatus.getAnnotationTime());
		this.setDocumentRecordId(newStatus.getDocumentRecordId());
		this.setRecordName(newStatus.getRecordName());
		this.setStatus(newStatus.getStatus());
		this.setTransferReadTime(newStatus.getTransferReadTime());
		this.setValidationTime(newStatus.getValidationTime());
		this.setWriteTime(newStatus.getWriteTime());
		this.setMessage(newStatus.getMessage());
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((recordName == null) ? 0 : recordName.hashCode());
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
		UploadStatusDTO other = (UploadStatusDTO) obj;
		if (recordName == null) {
			if (other.recordName != null)
				return false;
		} else if (!recordName.equals(other.recordName))
			return false;
		return true;
	}

}
