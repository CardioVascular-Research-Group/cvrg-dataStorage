package edu.jhu.cvrg.data.dto;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Calendar;

public class AnnotationDTO implements Serializable, Cloneable{
	
	public static final String ELECTROCARDIOGRAPHY_ONTOLOGY = "ECG";
	public static final String ECG_TERMS_ONTOLOGY = "ECGT";

	private static final long serialVersionUID = 198688003623925166L;
	
	private Long annotationId;;
	private Long userID;
	private Long recordID;
	private String createdBy;
	private String annotationType;
	private String name;
	private String bioportalOntology;
	private String bioportalClassId;
	private String bioportalReferenceLink;
	private Integer lead;
	private String unitMeasurement;
	private String description;
	private String value;
	private Calendar timestamp;
	private Double startXcoord;
	private Double startYcoord;
	private Double endXcoord;
	private Double endYcoord;
	
	private Long analysisJobId;

	public AnnotationDTO() {
	}
	
	
	public AnnotationDTO(Long userID, Long recordID, String createdBy,
			String annotationType, String name, String bioportalOntologyID, String bioportalClassId, String bioportalReferenceLink,
			Integer lead, String unitMeasurement, String description,
			String value, Calendar timestamp, Double startXcoord,
			Double startYcoord, Double endXcoord, Double endYcoord) {
		super();
		this.userID = userID;
		this.recordID = recordID;
		this.createdBy = createdBy;
		this.annotationType = annotationType;
		this.name = name;
		this.bioportalOntology = bioportalOntologyID;
		this.bioportalClassId = bioportalClassId;
		
		if(bioportalReferenceLink == null){
			this.bioportalReferenceLink = AnnotationDTO.generateURL(bioportalOntologyID, bioportalClassId);
		}else{
			this.bioportalReferenceLink = bioportalReferenceLink;
		}
		
		this.lead = lead;
		this.unitMeasurement = unitMeasurement;
		this.description = description;
		this.value = value;
		this.timestamp = timestamp;
		this.startXcoord = startXcoord;
		this.startYcoord = startYcoord;
		this.endXcoord = endXcoord;
		this.endYcoord = endYcoord;
	}
	
	public Long getUserID() {
		return userID;
	}
	public void setUserID(Long userID) {
		this.userID = userID;
	}
	public Long getRecordID() {
		return recordID;
	}
	public void setRecordID(Long recordID) {
		this.recordID = recordID;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public String getAnnotationType() {
		return annotationType;
	}
	public void setAnnotationType(String annotationType) {
		this.annotationType = annotationType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBioportalReferenceLink() {
		return bioportalReferenceLink;
	}
	public void setBioportalReferenceLink(String bioportalReferenceLink) {
		this.bioportalReferenceLink = bioportalReferenceLink;
	}
	public Integer getLead() {
		return lead;
	}
	public void setLead(Integer lead) {
		this.lead = lead;
	}
	public String getUnitMeasurement() {
		return unitMeasurement;
	}
	public void setUnitMeasurement(String unitMeasurement) {
		this.unitMeasurement = unitMeasurement;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public Calendar getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(Calendar timestamp) {
		this.timestamp = timestamp;
	}
	public Double getStartXcoord() {
		return startXcoord;
	}
	public void setStartXcoord(Double startXcoord) {
		this.startXcoord = startXcoord;
	}
	public Double getStartYcoord() {
		return startYcoord;
	}
	public void setStartYcoord(Double startYcoord) {
		this.startYcoord = startYcoord;
	}
	public Double getEndXcoord() {
		return endXcoord;
	}
	public void setEndXcoord(Double endXcoord) {
		this.endXcoord = endXcoord;
	}
	public Double getEndYcoord() {
		return endYcoord;
	}
	public void setEndYcoord(Double endYcoord) {
		this.endYcoord = endYcoord;
	}
	public String getBioportalClassId() {
		return bioportalClassId;
	}

	public void setBioportalClassId(String bioportalClassId) {
		this.bioportalClassId = bioportalClassId;
	}

	public Long getAnnotationId() {
		return annotationId;
	}

	public void setAnnotationId(Long annotationId) {
		this.annotationId = annotationId;
	}

	public boolean isComment() {
		return "COMMENT".equals(this.getAnnotationType());
	}
	
	public boolean isSinglePoint(){
		boolean ret = false;
		
		if(this.getStartXcoord() != null && this.getStartYcoord() != null){
			if(this.getEndXcoord() != null && this.getEndYcoord() != null && (this.getStartXcoord().equals(this.getEndXcoord()) || this.getStartYcoord().equals(this.getEndYcoord()))){
				ret = true;
			}
		}
		
		return ret;
	}
	
	public boolean isWholeLead(){
		return this.getStartXcoord() == null && this.getStartYcoord() == null && this.getEndXcoord() == null && this.getEndYcoord() == null;
	}


	public Long getAnalysisJobId() {
		return analysisJobId;
	}


	public void setAnalysisJobId(Long analysisJobId) {
		this.analysisJobId = analysisJobId;
	}


	public String getBioportalOntology() {
		return bioportalOntology;
	}


	public void setBioportalOntology(String bioportalOntology) {
		this.bioportalOntology = bioportalOntology;
	}
	
	public double getDataYChange() {
		if(isSinglePoint()){
			return 0;
		}else{
			return this.getEndYcoord() - this.getStartYcoord();
		}
	}
	
	public double getDataXChange() {
		if(isSinglePoint()){
			return 0;
		}else{
			return this.getEndXcoord() - this.getStartXcoord();
		}
	}
	
	public AnnotationDTO clone(){
		
		try {
			return (AnnotationDTO) super.clone();
		} catch (CloneNotSupportedException e) {
			return null;
		}
	}

	public static String generateURL(String bioportalOntologyID, String bioportalClassId){
		String ret = null;
		if(bioportalOntologyID != null && bioportalClassId != null){
			String tmpClass = bioportalClassId;
			if(bioportalClassId.contains("http://")){
				try {
					tmpClass = URLEncoder.encode(bioportalClassId, "UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
			
			ret = "http://bioportal.bioontology.org/ontologies/" + bioportalOntologyID + "/?p=classes&conceptid=" + tmpClass;
		}
		return ret;
	}

	public int getExpTimeInSec(){
		int exponent=0;
		double miliSec = 0;
		if(this.getStartXcoord()!=null){
			miliSec = this.getStartXcoord();
		}else if(this.getEndXcoord() != null){
			miliSec = this.getEndXcoord();
		}
			
		if(miliSec>0){	
			double secMinTime = miliSec/1000;
			
			for (int i = 0; i < 10; i++) {
				if(secMinTime/Math.pow(10, i) < 10){
					exponent = i;
					break;
				}
			}
		}
		return exponent;
	}
	
}
