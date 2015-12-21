package edu.jhu.cvrg.data.factory.hibernate;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the Algorithm Web Service configuration "algorithmReference" database table.
 * 
 */
@Entity
@Table(name = "algorithmperson", schema = "public")
public class AlgorithmPerson implements Serializable {
	
	private static final long serialVersionUID = -5180717846077955042L;

	@EmbeddedId
	private AlgorithmPersonId id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "\"algorithmid\"", nullable = false, insertable = false, updatable = false)
	private Algorithm algorithm;
	
	public AlgorithmPerson() {
	}

	public Algorithm getAlgorithm() {
		return algorithm;
	}

	public void setAlgorithm(Algorithm algorithm) {
		this.algorithm = algorithm;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		AlgorithmPerson other = (AlgorithmPerson) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}