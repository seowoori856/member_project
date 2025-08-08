package com.example.practice.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	private final MemberMapper memberMapper;
	private final BCryptPasswordEncoder passwordEncoder;

	@Autowired
	public MemberService(MemberMapper memberMapper, BCryptPasswordEncoder passwordEncoder) {
		this.memberMapper = memberMapper;
		this.passwordEncoder = passwordEncoder;
	}

	// 접근제한자 리턴타입 메서드명(파라메터);
	public boolean insertMember(MemberDTO memberDTO) {
//		String memberInfo = memberDTO.toString();
//		System.out.println(memberInfo);
		// 아이디가 중복되는지 확인
		MemberDTO checkEmail = memberMapper.findMemberByEmail(memberDTO);

		// checkEmail null이면 회원정보가 중복이 안됀 것 그러므로 회원 가입진행
		if (checkEmail == null) {
			String encryptedPw = passwordEncoder.encode(memberDTO.getPassword()); // "1234"
//			System.out.println(encryptedPw);
			memberDTO.setPassword(encryptedPw); // 암호화된 비밀번호를 setPassword
			// 회원가입처리
			memberMapper.insertMember(memberDTO);
			return true;
		} else {
			// null이 아닐경우에
			return false;

		}

	}

//	MemberDTO findMember(MemberDTO memberDTO);
	// 회원 정보 차기
	public MemberDTO findMember(MemberDTO memberDTO) {

		// 리턴 결과의 타입 MemberDTO
		// 이메일 기준으로 조회한 결과
		MemberDTO memberInfo = memberMapper.findMember(memberDTO);

		if (memberInfo != null && passwordEncoder.matches(memberDTO.getPassword(), memberInfo.getPassword())) {
			return memberInfo;

		}

		return null;
	}

	// 빈 값을 검사하고 null 처리 후에 회원 정보 업데이트
	public void updateMember(MemberDTO memberDTO) {
		String name = memberDTO.getName();
		String password = memberDTO.getPassword();
		// 빈값 검증 if문
		// 이름 검증
		if (name.isEmpty()) {
			memberDTO.setName(null);
		}
		// 비밀번호 검증
		if (password.isEmpty()) {
			memberDTO.setPassword(null);
		} else {

			String encryptedPw = passwordEncoder.encode(memberDTO.getPassword());
			memberDTO.setPassword(encryptedPw);
		}

		memberMapper.updateMember(memberDTO);

		return;
	}

	// 회원 정보 삭제
	public void deleteMember(String email) {
		memberMapper.deleteMember(email);
		return;
	};

}
