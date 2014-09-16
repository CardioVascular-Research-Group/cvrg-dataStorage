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
 * The persistent class for the Algorithm Web Service configuration "parameterType" database table.
 * 
 */
@Entity
@Table(name="\"parameterType\"")
public class ParameterType implements Serializable {
	
	private static final long serialVersionUID = 4044744762175415217L;

	@Id
	@SequenceGenerator(name="PARAMETERTYPE_PARAMETERTYPEID_GENERATOR", sequenceName="PARAMETERTYPE_PARAMETERTYPEID_SEQ")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PARAMETERTYPE_PARAMETERTYPEID_GENERATOR")
	@Column(name="\"parameterTypeid\"")
	private Integer parameterTypeid;

	@Column(name="\"shortDescription\"")
	private String shortDescription;

	@Column(name="\"uiName\"")
	private String uiName;

	//bi-directional many-to-one association to Parameter
//	@OneToMany(mappedBy="parameterType")
//	private List<AWS_Parameter> parameterList;

	public ParameterType() {
	}

	public Integer getParameterTypeid() {
		return this.parameterTypeid;
	}

	public void setParameterTypeid(Integer parameterTypeID) {
		this.parameterTypeid = parameterTypeID;
	}

	public String getShortDescription() {
		return this.shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getUiName() {
		return this.uiName;
	}

	public void setUiName(String uiName) {
		this.uiName = uiName;
	}

//	public List<AWS_Parameter> getParameters() {
//		return this.parameterList;
//	}
//
//	public void setParameters(List<AWS_Parameter> parameters) {
//		this.parameterList = parameters;
//	}

}