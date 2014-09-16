package edu.jhu.cvrg.data.dto;

import java.io.Serializable;

public class FileTypeDTO implements Serializable{

	private static final long serialVersionUID = 3299583986395914122L;
	
	private int id;
	private String name; // name of the file type
	private String extension;
	private String displayShortName; // Human friendly name to be used by the UI when listing services.
	private String toolTipDescription; // Short summary description (under 150 characters) suitable for displaying is a tooltip.
	private String longDescription; // Complete description suitable for using in a manual/help file.
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public String getDisplayShortName() {
		return displayShortName;
	}
	public void setDisplayShortName(String displayShortName) {
		this.displayShortName = displayShortName;
	}
	public String getToolTipDescription() {
		return toolTipDescription;
	}
	public void setToolTipDescription(String toolTipDescription) {
		this.toolTipDescription = toolTipDescription;
	}
	public String getLongDescription() {
		return longDescription;
	}
	public void setLongDescription(String longDescription) {
		this.longDescription = longDescription;
	}
	
	
}
