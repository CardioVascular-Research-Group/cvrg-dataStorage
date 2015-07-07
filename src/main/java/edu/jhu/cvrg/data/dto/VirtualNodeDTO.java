package edu.jhu.cvrg.data.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class VirtualNodeDTO implements Serializable{

	private static final long serialVersionUID = -5873247825340296375L;
	
	private Long id;
	private String name;
	private String externalReference;
	private List<VirtualNodeDTO> children;
	private boolean folder;
	
	public VirtualNodeDTO(Long id, String name, String externalReference, boolean isFolder) {
		super();
		this.id = id;
		this.name = name;
		this.externalReference = externalReference;
		this.folder = isFolder;
	}
	
	public Long getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getExternalReference() {
		return externalReference;
	}
	public List<VirtualNodeDTO> getChildren() {
		return children;
	}
	public void addChild(VirtualNodeDTO dto) {
		if(children == null){
			children = new ArrayList<VirtualNodeDTO>();
		}
		children.add(dto);
	}

	public void setChildren(List<VirtualNodeDTO> children) {
		this.children = children;
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
		VirtualNodeDTO other = (VirtualNodeDTO) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	public boolean isFolder() {
		return folder;
	}
	
	
	
}
