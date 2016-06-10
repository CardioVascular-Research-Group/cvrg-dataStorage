package edu.jhu.cvrg.data.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;

import edu.jhu.cvrg.data.enums.FileType;

/** Document Record, Data Transfer Object **/
public class DocumentRecordDTO implements Serializable{

	private static final long serialVersionUID = 2261268385587096394L;
	
	private Long documentRecordId;
	private long timeSeriesId;
	private String recordName;
	private Long userId;
	private String subjectId;
	private FileType originalFormat;
	private Double samplingRate;
	private String fileTreePath;
	private Integer leadCount;
	private Integer numberOfPoints;
	private Date dateOfUpload;
	private Integer age;
	private String gender;
	private Date dateOfRecording;
	private Double aduGain;
	private String leadNames;
	
	public DocumentRecordDTO(Long documentRecordId, String recordName,
			Long userId, String subjectId, FileType originalFormat,
			Double samplingRate, String fileTreePath, Integer leadCount,
			Integer numberOfPoints, Date dateOfUpload, Integer age,
			String gender, Date dateOfRecording, Double aduGain, String leadNames, long timeseriesId) {
		super();
		this.documentRecordId = documentRecordId;
		this.recordName = recordName;
		this.userId = userId;
		this.subjectId = subjectId;
		this.originalFormat = originalFormat;
		this.samplingRate = samplingRate;
		this.fileTreePath = fileTreePath;
		this.leadCount = leadCount;
		this.numberOfPoints = numberOfPoints;
		this.dateOfUpload = dateOfUpload;
		this.age = age;
		this.gender = gender;
		this.dateOfRecording = dateOfRecording;
		this.aduGain = aduGain;
		this.leadNames = leadNames;
		this.timeSeriesId = timeseriesId;
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
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}
	public FileType getOriginalFormat() {
		return originalFormat;
	}
	public void setOriginalFormat(FileType originalFormat) {
		this.originalFormat = originalFormat;
	}
	public Double getSamplingRate() {
		return samplingRate;
	}
	public void setSamplingRate(Double samplingRate) {
		this.samplingRate = samplingRate;
	}
	public String getFileTreePath() {
		return fileTreePath;
	}
	public void setFileTreePath(String fileTreePath) {
		this.fileTreePath = fileTreePath;
	}
	public Integer getLeadCount() {
		return leadCount;
	}
	public void setLeadCount(Integer leadCount) {
		this.leadCount = leadCount;
	}
	public Integer getNumberOfPoints() {
		return numberOfPoints;
	}
	public void setNumberOfPoints(Integer numberOfPoints) {
		this.numberOfPoints = numberOfPoints;
	}
	public Date getDateOfUpload() {
		return dateOfUpload;
	}
	public void setDateOfUpload(Date dateOfUpload) {
		this.dateOfUpload = dateOfUpload;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Date getDateOfRecording() {
		return dateOfRecording;
	}
	public void setDateOfRecording(Date dateOfRecording) {
		this.dateOfRecording = dateOfRecording;
	}
	public Double getAduGain() {
		return aduGain;
	}
	public void setAduGain(Double aduGain) {
		this.aduGain = aduGain;
	}
	
	/** Calculated ECG duration time in seconds.
	   * 
	   * @return
	   */
	public double getDurationSec(){
		return new BigDecimal(getSamplesPerChannel()/this.samplingRate).setScale(3, RoundingMode.HALF_EVEN).doubleValue();
	}
	
	/** Calculated number of milliseconds in full ECG file, based on getNumberOfPoints and getSamplingRate.
	 * 
	 * @return
	 */
	public int getMsecDuration(){
		int duration = (int)((getSamplesPerChannel()/getSamplingRate())*1000.0); // number of milliseconds in full ECG file.
		return duration;
	}
	
	public int getSamplesPerChannel(){
		return this.numberOfPoints / this.leadCount;
	}

	public String getLeadNames() {
		return leadNames;
	}

	public long getTimeSeriesId() {
		return Long.valueOf(timeSeriesId);
	}

	public void setTimeSeriesId(long timeSeriesId) {
		this.timeSeriesId = timeSeriesId;
	}

}
