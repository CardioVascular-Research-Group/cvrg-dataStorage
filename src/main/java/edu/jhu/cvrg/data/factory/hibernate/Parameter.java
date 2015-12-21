package edu.jhu.cvrg.data.factory.hibernate;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * The persistent class for the Algorithm Web Service configuration "parameter" database table.
 * 
 */
@Entity
@Table(name="parameter", schema = "public") 
@Inheritance(strategy=InheritanceType.JOINED)
public class Parameter implements Serializable {
	
	private static final long serialVersionUID = -4045646042080813801L;


	@Id
	@SequenceGenerator(name="parameters_parameterid_seq", sequenceName="parameters_parameterid_seq")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="parameters_parameterid_seq")
	@Column(name="\"parameterid\"")
	private Integer parameterid;
	

	@Column(name="\"uiName\"")
	private String uiName;

	@Column(name="\"shortDescription\"")
	private String shortDescription;

	@Column(name="\"completeDescription\"")
	private String completeDescription;

	@Column(name="\"flag\"")
	private String flag;

	@Column(name="\"defaultValue\"")
	private String defaultValue;

	@Column(name="\"parameterTypeid\"")
	private Integer parameterTypeid;

	@Column(name="\"required\"")
	private Boolean required;

	@Column(name="\"multipleSelect\"")
	private Boolean multipleSelect;

	//------------
	@Column(name="\"algorithmid\"")
	private Integer algorithmid;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "\"algorithmid\"", nullable = false, insertable = false, updatable = false)
	private Algorithm algorithm;

	@OneToOne(fetch = FetchType.EAGER, cascade={CascadeType.REMOVE})
	@JoinColumn(name = "\"parameterValidationid\"", nullable = true)
	private ParameterValidator validator;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "\"parameterTypeid\"", nullable = false, insertable = false, updatable = false)
	private ParameterType type;
	
	/** Foreign Key of the algorithm this parameter pertains to. **/
	public Integer getAlgorithmid() {
		return this.algorithmid;
	}
	public void setAlgorithmid(Integer algorithmID) {
		this.algorithmid = algorithmID;
	}

	/** default constructor **/
	public Parameter() {
	}
	
	/** Initialization constructor.
	 * 
	 * @param uiName - Human friendly name to be used by the UI when listing services.
	 * @param iAlgorithmID - Foreign key to the "algorithm" table.  
	 * @param parameterValidationID - Foreign Key to the validation table entry related to this parameter.
	 * @param shortDescription - Short summary description suitable for displaying as a tooltip.
	 * @param completeDescription - Complete description of the algorithm suitable for using in a manual/help file.
	 * @param flag - Identifying character(s) to be sent to the web service if this optional parameter is to be invoked.<BR>
			It could be the underlying code''s command line flag which identifies a value that follows it,  <BR>
			e.g. "-r " preceeds the record-name.<BR>
			Or it could be a short word, specified by the web service writer, e.g. "record".'<BR>
	 * @param defaultValue - -If the parameter equals this value, don''t pass the parameter data to the web service.<BR>
			Also, this is the value which the algorithm will use if no parameter value is set by the user.'
	 * @param iParameterTypeID - Foreign Key to indicate which data type the parameter should be.<BR>
			Options will be:<BR>
   			1:text, 2:integer, 3:float, 4:boolean, 5:select, or 6:drill_down;
	 * @param required - If true, this parameter must have a value.
	 * @param multipleSelect - If true, allow multiple selections in a dropdown list.<BR>
			Only relevent for select or data_column parameter types.
	 */
	public Parameter(String uiName, 
			Integer iAlgorithmID, 
			String shortDescription,
			String completeDescription,
			String flag,
			String defaultValue,
			int iParameterTypeID,
			boolean bRequired,
			boolean bMutipleSelect) {
		setUiName(uiName);
		setAlgorithmid(iAlgorithmID);
		setShortDescription(shortDescription);
		setCompleteDescription(completeDescription);
		setFlag(flag);
		setDefaultValue(defaultValue);
		setParameterTypeID(iParameterTypeID);
		setRequired(bRequired);
		setMultipleSelect(bMutipleSelect);
	}
//********************************** columns ******************
	/** Primary Key for this parameter. **/
	public Integer getParameterID() {
		return this.parameterid;
	}
	public void setParameterID(Integer parameterID) {
		this.parameterid = parameterID;
	}
	//------------
	/** Human friendly name to be used by the UI when listing options. 30 char max. **/
	public String getUiName() {
		return this.uiName;
	}
	public void setUiName(String uiName) {
		int size = 30;
		if(uiName.length()>(size-4)) uiName = uiName.substring(0, (size-4))+"...";
		this.uiName = uiName;
	}
	//------------
	/** Short summary description suitable for displaying as a tooltip. 150 char max**/
	public String getShortDescription() {
		return this.shortDescription;
	}
	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}
	//------------
	/** Complete description of the algorithm suitable for using in a manual/help file. max char 2000 **/
	public String getCompleteDescription() {
		return this.completeDescription;
	}
	public void setCompleteDescription(String completeDescription) {
		this.completeDescription = completeDescription;
	}
	//------------
	/** flag - Identifying character(s) to be sent to the web service if this optional parameter is to be invoked.
		It could be the underlying code''s command line flag which identifies a value that follows it,  e.g. "-r " preceeds the record-name.
		Or it could be a short word, specified by the web service writer, e.g. "record". 
		Max char 10 **/
	public String getFlag() {
		return this.flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	//------------
	/** defaultValue - If the parameter equals this value, don''t pass the parameter data to the web service.
		Also, this is the value which the algorithm will use if no parameter value is set by the user. max char 25 **/
	public String getDefaultValue() {
		return this.defaultValue;
	}
	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}
	//------------
	/** parameterTypeID - Foreign Key to indicate which data type the parameter should be.
		Options will be:
		   text, integer, float, boolean, select, data_column, or drill_down' **/
	public Integer getParameterTypeID() {
		return this.parameterTypeid;
	}
	public void setParameterTypeID(Integer parameterTypeID) {
		this.parameterTypeid = parameterTypeID;
	}
	//-----------
	/** required - If true, this parameter must have a value. **/
	public Boolean getRequired(){
		return this.required;
	}
	public void setRequired(Boolean bRequired){
		this.required = bRequired;
	}
	//------------
	/** mulitipleSelect - If true, allow multiple selections in a dropdown list.
		Only relevent for select or data_column parameter types.**/
	public Boolean getMultipleSelect(){
		return this.multipleSelect;
	}
	public void setMultipleSelect(Boolean bmutipleSelect){
		this.multipleSelect = bmutipleSelect;
	}
	public Algorithm getAlgorithm() {
		return algorithm;
	}
	public void setAlgorithm(Algorithm algorithm) {
		this.algorithm = algorithm;
	}
	public ParameterValidator getValidator() {
		return validator;
	}
	public void setValidator(ParameterValidator validator) {
		this.validator = validator;
	}
	public ParameterType getType() {
		return type;
	}
	public void setType(ParameterType type) {
		this.type = type;
	}

	
}