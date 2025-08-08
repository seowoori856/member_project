package com.example.practice.member;

import java.sql.Date;
import java.sql.Timestamp;

public class MemberDTO {
	private int idx; // 회원 고유 번호
	private String userType; // 사용자 유형 (normal, biz 등)
	private String name; // 이름
	private String email; // 이메일
	private String password; // 비밀번호
	private Date birth; // 생년월일
	private String bizNo; // 사업자 번호 (사업자인 경우)
	private String companyName; // 회사 이름 (사업자인 경우)
	private Timestamp createdAt; // 가입일자 (등록일)

	// 기본 생성자
	public MemberDTO() {
	}

	// 모든 필드를 포함한 생성자
	public MemberDTO(int idx, String userType, String name, String email, String password, Date birth, String bizNo,
			String companyName, Timestamp createdAt) {
		this.idx = idx;
		this.userType = userType;
		this.name = name;
		this.email = email;
		this.password = password;
		this.birth = birth;
		this.bizNo = bizNo;
		this.companyName = companyName;
		this.createdAt = createdAt;
	}

	// Getter & Setter
	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getBizNo() {
		return bizNo;
	}

	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	// toString
	@Override
	public String toString() {
		return "MemberDTO{" + "idx=" + idx + ", userType='" + userType + '\'' + ", name='" + name + '\'' + ", email='"
				+ email + '\'' + ", password='" + password + '\'' + ", birth=" + birth + ", bizNo='" + bizNo + '\''
				+ ", companyName='" + companyName + '\'' + ", createdAt=" + createdAt + '}';
	}
}
