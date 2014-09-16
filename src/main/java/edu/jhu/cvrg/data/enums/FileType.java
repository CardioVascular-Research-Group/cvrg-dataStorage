package edu.jhu.cvrg.data.enums;

/*
Copyright 2013 Johns Hopkins University Institute for Computational Medicine

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
/**
* @author Andre Vilardo
* 
*/
public enum FileType {
	
	/**  Indicates an ECG file used by GE Magellan 	 **/
	GE_MAGELLAN("GE Magellan", FileExtension.TXT),
	/**  Indicates an WFDB file format.  Requires both a header and a .dat file **/
	WFDB("WFDB", FileExtension.HEA, FileExtension.DAT),
	/**  Indicates an RDT file **/
	RDT("RDT", FileExtension.RDT), 
	/**  Indicates a Holter2 formatted file 	 **/
	HOLTER12("Holter 12", FileExtension.CSV),
	/**  Indicates a Holter13 formatted file 	 **/
	HOLTER3("Holter 3", FileExtension.CSV), 
	/** Indicates a GE Muse file	 **/
	GE_MUSE("GE Muse", FileExtension.TXT),
	/** Indicates an HL7 format	 **/
	HL7("HL7", FileExtension.HL7),
	/** Indicates an xyFile (which is has a .csv extension)	 **/
	XY_FILE("XY formatted CSV file", FileExtension.CSV),
	PHILIPS_103("Philips 1.03", FileExtension.XML),
	PHILIPS_104("Philips 1.04", FileExtension.XML),
	MUSE_XML("Muse", FileExtension.XML),
	/** Indicates a Schiller ECG file (which is has a .xml extension)	 **/
	SCHILLER("Schiller", FileExtension.XML);
	
	private String label;
	private FileExtension[] extension;
	
	private FileType(String label, FileExtension ... ext) {
		this.label = label;
		this.extension = ext;
	}
	
	public static FileType getTypeById(Integer id){
		
		if(id != null){
			for (FileType e : FileType.values()) {
				if(e.ordinal() == id){
					return e;
				}
			}
		}
		return null;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public FileExtension[] getExtension() {
		return extension;
	}

	public void setExtension(FileExtension[] extension) {
		this.extension = extension;
	}
}

