package edu.jhu.cvrg.data.factory.hibernate;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class AlgorithmPersonId implements Serializable {

	private static final long serialVersionUID = -6254721821742811491L;

	@Column(name="\"personid\"")
	private Integer personid;

	@Column(name="\"algorithmid\"")
	private Integer algorithmid;

	public Integer getPersonid() {
		return personid;
	}

	public void setPersonid(Integer personid) {
		this.personid = personid;
	}

	public Integer getAlgorithmid() {
		return algorithmid;
	}

	public void setAlgorithmid(Integer algorithmid) {
		this.algorithmid = algorithmid;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((algorithmid == null) ? 0 : algorithmid.hashCode());
		result = prime * result
				+ ((personid == null) ? 0 : personid.hashCode());
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
		AlgorithmPersonId other = (AlgorithmPersonId) obj;
		if (algorithmid == null) {
			if (other.algorithmid != null)
				return false;
		} else if (!algorithmid.equals(other.algorithmid))
			return false;
		if (personid == null) {
			if (other.personid != null)
				return false;
		} else if (!personid.equals(other.personid))
			return false;
		return true;
	}
	
	
	
}
