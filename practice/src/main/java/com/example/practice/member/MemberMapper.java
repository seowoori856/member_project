package com.example.practice.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	// 회웑 정보 입력
//	<insert id="insertMember" parameterType="memberdto"> 결과에 대한값을 int
	void insertMember(MemberDTO memberDTO);

	// 회원 정보 조회
//	<select id="findMember" parameterType="memberdto" resultType="memberdto">
	MemberDTO findMember(MemberDTO memberDTO);

	// 회원 이메일 중복 처리 체크
//	<select id="findMemberByEmail" parameterType="memberdto" resultType="memberdto">
	MemberDTO findMemberByEmail(MemberDTO memberDTO);
//	MemberDTO findMemberByEmail(String email);

	// 회원 정보 수정
	void updateMember(MemberDTO memberDTO);

	// 회원 정보 삭제
	void deleteMember(String email);

}
