package edu.jhu.cvrg.data.factory.hibernate;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the virtualdocument database table.
 * 
 */
@Entity
public class VirtualDocument implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="virtualDocument_sequence", sequenceName="virtualDocument_sequence")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="virtualDocument_sequence")
	private Long virtualDocumentId;
	
	private Long virtualNodeId;

	private Long documentRecordId;

	private Long userId;

	private String virtualDocumentName;

	//bi-directional many-to-one association to Documentrecord
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="documentRecordId", insertable = false, updatable = false)
	private DocumentRecord documentRecord;

	//bi-directional many-to-one association to Virtualnode
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="virtualNodeId", insertable = false, updatable = false)
	private VirtualNode virtualNode;

	public VirtualDocument() {
	}

	public VirtualDocument(Long virtualNodeId, Long documentRecordId, long userId, String virtualDocumentName) {
		super();
		this.virtualNodeId = virtualNodeId;
		this.documentRecordId = documentRecordId;
		this.userId = userId;
		this.virtualDocumentName = virtualDocumentName;
	}

	public Long getUserId() {
		return this.userId;
	}

	public void setUserId(Long userid) {
		this.userId = userid;
	}

	public String getVirtualDocumentName() {
		return this.virtualDocumentName;
	}

	public void setVirtualDocumentName(String virtualdocumentname) {
		this.virtualDocumentName = virtualdocumentname;
	}

	public DocumentRecord getDocumentRecord() {
		return this.documentRecord;
	}

	public void setDocumentRecord(DocumentRecord documentrecord) {
		this.documentRecord = documentrecord;
	}

	public VirtualNode getVirtualNode() {
		return this.virtualNode;
	}

	public void setVirtualNode(VirtualNode virtualnode) {
		this.virtualNode = virtualnode;
	}



	public Long getVirtualDocumentId() {
		return virtualDocumentId;
	}



	public void setVirtualDocumentId(Long virtualDocumentId) {
		this.virtualDocumentId = virtualDocumentId;
	}



	public Long getVirtualNodeId() {
		return virtualNodeId;
	}



	public void setVirtualNodeId(Long virtualNodeId) {
		this.virtualNodeId = virtualNodeId;
	}



	public Long getDocumentRecordId() {
		return documentRecordId;
	}



	public void setDocumentRecordId(Long documentRecordId) {
		this.documentRecordId = documentRecordId;
	}

}