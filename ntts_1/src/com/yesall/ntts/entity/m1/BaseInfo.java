package com.yesall.ntts.entity.m1;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * BaseInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "base_info", catalog = "student")
public class BaseInfo implements java.io.Serializable {

	// Fields

	private String idCard;
	private String name;
	private Integer age;
	private String birthdate;
	private String sex;
	private String companyName;
	private String phone;
	private Date writedate;
	private Set<BaomingInfo> baomingInfos = new HashSet<BaomingInfo>(0);

	// Constructors

	/** default constructor */
	public BaseInfo() {
	}

	/** minimal constructor */
	public BaseInfo(String idCard) {
		this.idCard = idCard;
	}

	/** full constructor */
	public BaseInfo(String idCard, String name, Integer age, String birthdate,
			String sex, String companyName, String phone, Date writedate,
			Set<BaomingInfo> baomingInfos) {
		this.idCard = idCard;
		this.name = name;
		this.age = age;
		this.birthdate = birthdate;
		this.sex = sex;
		this.companyName = companyName;
		this.phone = phone;
		this.writedate = writedate;
		this.baomingInfos = baomingInfos;
	}

	// Property accessors
	@Id
	@Column(name = "idCard", unique = true, nullable = false)
	public String getIdCard() {
		return this.idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "age")
	public Integer getAge() {
		return this.age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	@Column(name = "birthdate")
	public String getBirthdate() {
		return this.birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	@Column(name = "sex")
	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "companyName")
	public String getCompanyName() {
		return this.companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	@Column(name = "phone")
	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "writedate", length = 10)
	public Date getWritedate() {
		return this.writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "baseInfo")
	public Set<BaomingInfo> getBaomingInfos() {
		return this.baomingInfos;
	}

	public void setBaomingInfos(Set<BaomingInfo> baomingInfos) {
		this.baomingInfos = baomingInfos;
	}

}