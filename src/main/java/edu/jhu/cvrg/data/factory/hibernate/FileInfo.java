package edu.jhu.cvrg.data.factory.hibernate;

// Generated Dec 5, 2013 2:16:30 PM by Hibernate Tools 4.0.0
// Modified 30 July, 2015 to add timeseriesid field -CRJ
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * DatabaseFilesinfo generated by hbm2java
 */
@Entity
@Table(name = "Filesinfo", schema = "public")
public class FileInfo implements java.io.Serializable {

	private static final long serialVersionUID = -2190630573530553704L;
	
	private long fileId;
	private Long documentRecordId;
	private DocumentRecord documentRecord;
	private Long analysisJobId;
	private AnalysisJob analysisJob;
	private long timeseriesid;
	

	public FileInfo() {
	}

	public FileInfo(long fileid) {
		this.fileId = fileid;
	}
	
	public FileInfo(long fileid, Long documentrecordid) {
		this.fileId = fileid;
		this.documentRecordId = documentrecordid;
	}
	
	public FileInfo(long fileid, Long documentrecordid, Long analysisJobId, Long timeSeriesId) {
		this.fileId = fileid;
		this.documentRecordId = documentrecordid;
		this.analysisJobId = analysisJobId;
		this.timeseriesid = timeSeriesId;
	}
	
	@Id
	@Column(name = "fileid", unique = true, nullable = false)
	public long getFileId() {
		return this.fileId;
	}

	public void setFileId(long fileid) {
		this.fileId = fileid;
	}

	@Column(name = "documentrecordid", nullable = false)
	public Long getDocumentRecordId() {
		return this.documentRecordId;
	}

	public void setDocumentRecordId(Long documentrecordid) {
		this.documentRecordId = documentrecordid;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "documentrecordid", insertable = false, updatable = false)
	public DocumentRecord getDocumentRecord() {
		return this.documentRecord;
	}

	public void setDocumentRecord(DocumentRecord documentrecord) {
		this.documentRecord = documentrecord;
	}

	@Column(name = "analysisjobid")
	public Long getAnalysisJobId() {
		return analysisJobId;
	}

	public void setAnalysisJobId(Long analysisJobId) {
		this.analysisJobId = analysisJobId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "analysisjobid", insertable = false, updatable = false)
	public AnalysisJob getAnalysisJob() {
		return analysisJob;
	}

	public void setAnalysisJob(AnalysisJob analysisJob) {
		this.analysisJob = analysisJob;
	}

	public long getTimeseriesid() {
		return timeseriesid;
	}

	public void setTimeseriesid(long timeseriesid) {
		this.timeseriesid = timeseriesid;
	}

}
