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
 * The persistent class for the Algorithm Web Service configuration "parameterValidator" database table.
 * 
 */
@Entity
@Table(name="\"parameterValidator\"")
public class ParameterValidator implements Serializable {
	
	private static final long serialVersionUID = -152501795826963209L;

	/**	 Primary key of parameterValidation table. **/
	@Id
	@SequenceGenerator(name="parametervalidator_parametervalidationid_seq_GENERATOR", sequenceName="parametervalidator_parametervalidationid_seq")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="parametervalidator_parametervalidationid_seq_GENERATOR")
	@Column(name="\"parameterValidationid\"")
	private Integer parameterValidationid;

	@Column(name="\"validatorType\"")
	private int validatorType;

	@Column(name="\"message\"")
	private String message;

	@Column(name="\"min\"")
	private float min;

	@Column(name="\"max\"")
	private float max;

	@Column(name="\"regex\"")
	private String regex;


	public ParameterValidator() {
	}
	
	/** Initializing constructor.
	 * 
	 * @param validatorType - Can be of 3 types:<BR>
	    ---1 = regex - A JavaScript regular expression which describes a valid entry for when type is "text".<BR> 
		---2 = in_range - Defines the minimum and maximum values that a numeric input (integer or float) can have.<BR>
		---3 = length -  Defines the minimum and maximum length that a text input can have.<BR>
<BR>
	 * @param message - The message displayed if validation fails. 200 characters max.
	 * @param min - Minimum parameter value; only valid when the parameterType is "integer" or "float" (types 2 or 3).
	 * @param max - Maximum parameter value; only valid when the parameterType is "integer" or "float" (types 2 or 3).
	 * @param regex -A JavaScript regular expression which describes a valid entry for when the parameterType is "text". (type 1).
	 */
	public ParameterValidator( 
			int validatorType,
			String message, 
			float min,
			float max,
			String regex) {
		setParameterValidationid(parameterValidationid);
		setValidatorType(validatorType);
		setMessage(message);
		setMin(min);
		setMax(max);
		setRegex(regex);
	}

	public Integer getParameterValidationid() {
		return this.parameterValidationid;
	}
	public void setParameterValidationid(Integer parameterValidationID) {
		this.parameterValidationid = parameterValidationID;
	}

	public int getValidatorType() {
		return validatorType;
	}
	public void setValidatorType(int validatorType) {
		this.validatorType = validatorType;
	}

	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	public float getMin() {
		return min;
	}
	public void setMin(float min) {
		this.min = min;
	}

	public float getMax() {
		return max;
	}
	public void setMax(float max) {
		this.max = max;
	}

	public String getRegex() {
		return regex;
	}
	public void setRegex(String regex) {
		this.regex = regex;
	}

}