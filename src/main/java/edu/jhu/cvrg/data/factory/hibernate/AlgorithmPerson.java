package edu.jhu.cvrg.data.factory.hibernate;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * The persistent class for the Algorithm Web Service configuration "algorithmReference" database table.
 * 
 */
@Entity
@Table(name = "algorithmperson", schema = "public")
public class AlgorithmPerson implements Serializable {
	
	private static final long serialVersionUID = -5180717846077955042L;

	@Id
	@SequenceGenerator(name="algorithm_person_generator", sequenceName="algorithm_person_generator_seq")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="algorithm_person_generator")
	@Column(name="\"algorithmpersonid\"")
	private Integer algorithmpersonid;

	@Column(name="\"personid\"")
	private Integer personid;

	@Column(name="\"algorithmid\"")
	private Integer algorithmid;
	
	public AlgorithmPerson() {
	}

	public Integer getAlgorithmPersonid() {
		return algorithmpersonid;
	}

	public void setAlgorithmPersonid(Integer algorithmPersonid) {
		this.algorithmpersonid = algorithmPersonid;
	}

	public Integer getPersonid() {
		return this.personid;
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

}