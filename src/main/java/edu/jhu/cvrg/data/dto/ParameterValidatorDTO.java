package edu.jhu.cvrg.data.dto;

import java.io.Serializable;

public class ParameterValidatorDTO implements Serializable{
	
	private static final long serialVersionUID = 1027048530466303524L;
	
	private int id;
	private int type=-1; // 1=regex, 2=in_range, 3=length
	private String message=""; // The message displayed if validation fails.
	private float min; // 	a number, minimum parameter value; only valid when the parameter type is "integer" or "float"
	private float max;// 	a number, maximum parameter value; only valid when the parameter type is "integer" or "float"
	private String regex=""; // A javaScript regular expression which describes a valid entry for when the parameter type is "text". 
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	/** Can be of 3 types:<BR/>
			1 = regex - A javaScript regular expression which describes a valid entry for when type is "text".<BR/> 
			2 = in_range - Defines the minimum and maximum values that a numeric input (integer or float) can have.<BR/>
			3 = length -  Defines the minimum and maximum length that a text input can have.<BR/>
	 * @return - type string */
	public int getType() {
		return type;
	}
	public String getTypetext() {
		String text="no type";
		switch (type){
		case 1: 
			text="regex";
			break;
		case 2:
			text="in_range";
			break;
		case 3:
			text="length";
			break;
		default:
			text="n/a";		
		}
		
		return text;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	/** The message displayed if validation fails. 
	 * @return
	 */
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	/** a number, minimum parameter value; only valid when the parameter type is "integer" or "float"
	 * @return
	 */
	public float getMin() {
		return min;
	}
	public void setMin(float min) {
		this.min = min;
	}
	
	/** a number, maximum parameter value; only valid when the parameter type is "integer" or "float"
	 * 
	 * @return
	 */
	public float getMax() {
		return max;
	}
	public void setMax(float max) {
		this.max = max;
	}
	
	/** A javaScript regular expression which describes a valid entry for when the parameter type is "text".
	 * 
	 * @return
	 */
	public String getRegex() {
		return regex;
	}
	public void setRegex(String regex) {
		this.regex = regex;
	}
}
