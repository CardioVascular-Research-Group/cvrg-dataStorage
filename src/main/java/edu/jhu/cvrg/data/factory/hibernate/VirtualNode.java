package edu.jhu.cvrg.data.factory.hibernate;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;


/**
 * The persistent class for the virtualnode database table.
 * 
 */
@Entity
public class VirtualNode implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="virtualNode_sequence", sequenceName="virtualNode_sequence")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="virtualNode_sequence")
	private Long nodeId;

	private String externalReference;

	private String nodeName;

	private Long userId;
	
	private Long parentnodeId;

	//bi-directional many-to-one association to Virtualdocument
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "virtualNode", cascade={CascadeType.REMOVE})
	private List<VirtualDocument> virtualDocuments;
	
	//bi-directional many-to-one association to VirtualNode
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "parentNode", cascade={CascadeType.REMOVE})
	private List<VirtualNode> virtualSubNodes;

	//bi-directional many-to-one association to Virtualnode
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="parentnodeId", insertable = false, updatable = false)
	private VirtualNode parentNode;
	

	public VirtualNode() {
	}
	
	public VirtualNode(String externalReference, String nodeName, Long userId, Long parentnodeId) {
		super();
		this.externalReference = externalReference;
		this.nodeName = nodeName;
		this.userId = userId;
		this.parentnodeId = parentnodeId;
	}

	public Long getNodeId() {
		return this.nodeId;
	}

	public void setNodeId(Long nodeid) {
		this.nodeId = nodeid;
	}

	public String getExternalReference() {
		return this.externalReference;
	}

	public void setExternalReference(String externalreference) {
		this.externalReference = externalreference;
	}

	public String getNodeName() {
		return this.nodeName;
	}

	public void setNodeName(String nodename) {
		this.nodeName = nodename;
	}

	public Long getUserId() {
		return this.userId;
	}

	public void setUserId(Long userid) {
		this.userId = userid;
	}

	public List<VirtualDocument> getVirtualDocuments() {
		return this.virtualDocuments;
	}

	public void setVirtualDocuments(List<VirtualDocument> virtualdocuments) {
		this.virtualDocuments = virtualdocuments;
	}

	public VirtualDocument addVirtualDocument(VirtualDocument virtualdocument) {
		getVirtualDocuments().add(virtualdocument);
		virtualdocument.setVirtualNode(this);

		return virtualdocument;
	}

	public VirtualDocument removeVirtualDocument(VirtualDocument virtualdocument) {
		getVirtualDocuments().remove(virtualdocument);
		virtualdocument.setVirtualNode(null);

		return virtualdocument;
	}

	public Long getParentnodeId() {
		return parentnodeId;
	}

	public void setParentnodeId(Long parentNode) {
		this.parentnodeId = parentNode;
	}

	public List<VirtualNode> getVirtualSubNodes() {
		return virtualSubNodes;
	}

	public void setVirtualSubNodes(List<VirtualNode> virtualSubNodes) {
		this.virtualSubNodes = virtualSubNodes;
	}

	public VirtualNode getParentNode() {
		return parentNode;
	}

	public void setParentNode(VirtualNode parentNode) {
		this.parentNode = parentNode;
	}

}