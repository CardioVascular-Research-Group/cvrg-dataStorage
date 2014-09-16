package edu.jhu.cvrg.data.factory.hibernate;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the Algorithm Web Service configuration "parameterOption" database table.
 * 
 */
@Entity
@Table(name="\"parameterOption\"")
public class ParameterOption implements Serializable {
	
	private static final long serialVersionUID = 3179000516103101111L;

	@Id
	@SequenceGenerator(name="PARAMETEROPTION_PARAMETEROPTIONID_GENERATOR", sequenceName="PARAMETEROPTION_PARAMETEROPTIONID_SEQ")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PARAMETEROPTION_PARAMETEROPTIONID_GENERATOR")
	@Column(name="\"parameterOptionID\"")
	private Integer parameterOptionID;

	@Column(name="\"completeDescription\"")
	private String completeDescription;

	@Column(name="\"isInitialSelection\"")
	private Boolean isInitialSelection;

	@Column(name="\"parentParameterID\"")
	private Integer parentParameterID;

	@Column(name="\"shortDescription\"")
	private String shortDescription;

	@Column(name="\"uiText\"")
	private String uiText;

	@Column(name="\"uiValue\"")
	private String uiValue;

	public ParameterOption() {
	}

	public String getCompleteDescription() {
		return this.completeDescription;
	}

	public void setCompleteDescription(String completeDescription) {
		this.completeDescription = completeDescription;
	}

	public Boolean getIsInitialSelection() {
		return this.isInitialSelection;
	}

	public void setIsInitialSelection(Boolean isInitialSelection) {
		this.isInitialSelection = isInitialSelection;
	}

	public Integer getParameterOptionID() {
		return this.parameterOptionID;
	}

	public void setParameterOptionID(Integer parameterOptionID) {
		this.parameterOptionID = parameterOptionID;
	}

	public Integer getParentParameterID() {
		return this.parentParameterID;
	}

	public void setParentParameterID(Integer parentParameterID) {
		this.parentParameterID = parentParameterID;
	}

	public String getShortDescription() {
		return this.shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getUiText() {
		return this.uiText;
	}

	public void setUiText(String uiText) {
		int size = 30;
		if(uiText.length()>(size-4)) uiText = uiText.substring(0, (size-4))+"...";

		this.uiText = uiText;
	}

	public String getUiValue() {
		return this.uiValue;
	}

	public void setUiValue(String uiValue) {
		this.uiValue = uiValue;
	}

}