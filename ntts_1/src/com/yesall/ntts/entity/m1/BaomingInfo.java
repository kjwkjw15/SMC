package com.yesall.ntts.entity.m1;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * BaomingInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "baoming_info", catalog = "student")
public class BaomingInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private BaseInfo baseInfo;
	private String firstKind;
	private String secondKind;
	private String whetherPay;
	private String whetherInformation;
	private String classInfo;
	private String remarkInfo;
	private Date baomingdate;

	// Constructors

	/** default constructor */
	public BaomingInfo() {
	}

	/** minimal constructor */
	public BaomingInfo(Integer id, BaseInfo baseInfo) {
		this.id = id;
		this.baseInfo = baseInfo;
	}

	/** full constructor */
	public BaomingInfo(Integer id, BaseInfo baseInfo, String firstKind,
			String secondKind, String whetherPay, String whetherInformation,
			String classInfo, String remarkInfo, Date baomingdate) {
		this.id = id;
		this.baseInfo = baseInfo;
		this.firstKind = firstKind;
		this.secondKind = secondKind;
		this.whetherPay = whetherPay;
		this.whetherInformation = whetherInformation;
		this.classInfo = classInfo;
		this.remarkInfo = remarkInfo;
		this.baomingdate = baomingdate;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idCard", nullable = false)
	public BaseInfo getBaseInfo() {
		return this.baseInfo;
	}

	public void setBaseInfo(BaseInfo baseInfo) {
		this.baseInfo = baseInfo;
	}

	@Column(name = "firstKind")
	public String getFirstKind() {
		return this.firstKind;
	}

	public void setFirstKind(String firstKind) {
		this.firstKind = firstKind;
	}

	@Column(name = "secondKind")
	public String getSecondKind() {
		return this.secondKind;
	}

	public void setSecondKind(String secondKind) {
		this.secondKind = secondKind;
	}

	@Column(name = "whetherPay")
	public String getWhetherPay() {
		return this.whetherPay;
	}

	public void setWhetherPay(String whetherPay) {
		this.whetherPay = whetherPay;
	}

	@Column(name = "whetherInformation")
	public String getWhetherInformation() {
		return this.whetherInformation;
	}

	public void setWhetherInformation(String whetherInformation) {
		this.whetherInformation = whetherInformation;
	}

	@Column(name = "classInfo")
	public String getClassInfo() {
		return this.classInfo;
	}

	public void setClassInfo(String classInfo) {
		this.classInfo = classInfo;
	}

	@Column(name = "remarkInfo")
	public String getRemarkInfo() {
		return this.remarkInfo;
	}

	public void setRemarkInfo(String remarkInfo) {
		this.remarkInfo = remarkInfo;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "baomingdate", length = 10)
	public Date getBaomingdate() {
		return this.baomingdate;
	}

	public void setBaomingdate(Date baomingdate) {
		this.baomingdate = baomingdate;
	}

}