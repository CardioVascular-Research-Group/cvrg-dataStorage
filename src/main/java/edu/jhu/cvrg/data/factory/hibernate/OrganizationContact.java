package edu.jhu.cvrg.data.factory.hibernate;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the Algorithm Web Service configuration "organizationContact" database table.
 * 
 */
@Entity
@Table(name="\"organizationContact\"")
public class OrganizationContact implements Serializable {
	
	private static final long serialVersionUID = -7361600961519696373L;

	@Id
	@Column(name="\"organizationContactID\"")
	private Integer organizationContactID;

	@Column(name="\"contactID\"")
	private Integer contactID;

	@Column(name="\"organizationID\"")
	private Integer organizationID;

	public OrganizationContact() {
	}

	public Integer getOrganizationContactID() {
		return this.organizationContactID;
	}

	public void setOrganizationContactID(Integer organizationContactID) {
		this.organizationContactID = organizationContactID;
	}

	public Integer getContactID() {
		return this.contactID;
	}

	public void setContactID(Integer contactID) {
		this.contactID = contactID;
	}

	public Integer getOrganizationID() {
		return this.organizationID;
	}

	public void setOrganizationID(Integer organizationID) {
		this.organizationID = organizationID;
	}

}