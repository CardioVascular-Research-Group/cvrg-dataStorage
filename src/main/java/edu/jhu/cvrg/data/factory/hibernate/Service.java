package edu.jhu.cvrg.data.factory.hibernate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import edu.jhu.cvrg.data.dto.ServiceDTO;


/**
 * The persistent class for the Algorithm Web Service configuration "service" database table.
 * 
 */
@Entity
@Table(name = "service", schema = "public")
public class Service implements java.io.Serializable  {
	
	private static final long serialVersionUID = -5244454565031593052L;

	@Id
	@SequenceGenerator(name="service_serviceID_seq_GENERATOR", sequenceName="service_serviceID_seq")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="service_serviceID_seq_GENERATOR")
	@Column(name="\"serviceid\"")
	private Integer serviceid;

	@Column(name="\"uiName\"")
	private String uiName;

	@Column(name="\"wsName\"")
	private String wsName;

	@Column(name="\"wsUrl\"")
	private String url;

	//bi-directional many-to-one association to Algorithm
//	@OneToMany(mappedBy="service")
//	private List<AWS_Algorithm> algorithms;

	public Service() {
	}

	public Service(String UIName, String WSName, String URL){
		setUiName(UIName);
		setWsName(WSName);
		setUrl(URL);
	}
	
	
	public Service(ServiceDTO s){
		setUiName(s.getDisplayServiceName());
		setWsName(s.getServiceName());
		setUrl(s.getUrl());
		if(s.id != (-1)){
			setServiceid(s.id);
		}
	}
	
	public Integer getServiceid() {
		return this.serviceid;
	}

	public void setServiceid(Integer serviceID) {
		this.serviceid = serviceID;
	}

	public String getWsName() {
		return this.wsName;
	}

	public void setWsName(String name) {
		this.wsName = name;
	}

	public String getUiName() {
		return this.uiName;
	}

	public void setUiName(String uiName) {
		this.uiName = uiName;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
//
//	public List<AWS_Algorithm> getAlgorithms() {
//		return this.algorithms;
//	}
//
//	public void setAlgorithms(List<AWS_Algorithm> algorithms) {
//		this.algorithms = algorithms;
//	}

	/** returns the contents of this persistance class as "Service" bean for use by the program external to the dbUtility jar.
	 * 
	 * @return - "Service" bean
	 */
	public ServiceDTO getServiceBean(){
		ServiceDTO s = new ServiceDTO();
		s.setId(getServiceid());
		s.setServiceName(getWsName());
		s.setDisplayServiceName(getUiName());
		s.setUrl(getUrl());
		
		return s;
	}
}