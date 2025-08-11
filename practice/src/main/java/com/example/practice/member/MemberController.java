package com.example.practice.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	// 클래스의 멤버 변수 선언하는 것
	// 접근제한자 final 타입 변수명
	private final MemberService memberService;

	@Autowired
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	// 회원가입 화면
	@GetMapping("/join")
	public String joinPage() {
		return "member/join"; // WEB-INF/views/member/join.jsp
	}

	// 회원가입 처리

//	,	RedirectAttributes redirectAttributes
	// redirectAttributes.addFlashAttribute("message", "이메일이 중복되었습니다.");
	// import org.springframework.web.servlet.mvc.support.RedirectAttributes;

	@PostMapping("/insert") // /member/insert
	public String insertMember(@ModelAttribute MemberDTO memberDto, RedirectAttributes redirectAttributes) {
		System.out.println(memberDto.toString());
		boolean result = memberService.insertMember(memberDto);

		// result true 회원가입 성공 -> login페이지로 이동
		if (result) {
			return "redirect:/member/login";
		} else {
			// result false 이메일 중복 때문에 회원가입 실패 -> 회원가입 페이지로 다시이동
			// 사용자한테 실패 이유를 알려줘야한다.
			redirectAttributes.addFlashAttribute("message", "이메일이 중복되었습니다.");
			return "redirect:/member/join";
		}
	}

	// 로그인 화면
	@GetMapping("/login") // get method /member/login
	public String loginPage() {
		return "member/login"; // WEB-INF/views/member/login.jsp
	}

	// 로그인 처리
	@PostMapping("/login") // post method /member/login
	public String loginProcess(MemberDTO memberDto, RedirectAttributes redirectAttributes, HttpSession session) {
//		System.out.println(memberDto.toString());
		MemberDTO memberInfo = memberService.findMember(memberDto);
		if (memberInfo == null) {
			// 회원 정보가 null 이면 ~ 일치하는 정보하는 정보가 없기 때문에
			redirectAttributes.addFlashAttribute("message", "이메일 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/login";
		} else {
			// 회원 정보가 존재합니다. ~ 회원 정보를 세션에 저장한다.
			// 세션 저장한거는 삭제할 경우는 로그아웃
			session.setAttribute("loginMember", memberInfo);
			return "redirect:/member/myPage";
		}
	}

	// 마이페이지
	@GetMapping("/myPage")
	public String myPage(Model model, HttpSession session) {
		MemberDTO member = (MemberDTO) session.getAttribute("loginMember");
		// session에서 가져온 회원 정보가 null이면 사용자가 로그인을 안하고 들어온 것이다.
		if (member == null) {
			return "redirect:/member/login";
		} else {
			model.addAttribute("loginMember", member);
			return "member/myPage";
		}

	}

	// 로그아웃 처리
	@GetMapping("/logout")
	public String logoutProcess(HttpSession session) {
		// 클리어 회원정보 삭제
		session.invalidate();
		return "redirect:/member/login";
	}

	// 사용자가 /member/edit 로 get 방식으로 요청했을 때
	// 회원 정보 수정 페이지
	@GetMapping("/edit")
	public String editPage(Model model, HttpSession session) {

		MemberDTO member = (MemberDTO) session.getAttribute("loginMember");
		// session에서 가져온 회원 정보가 null이면 사용자가 로그인을 안하고 들어온 것이다.
		if (member == null) {
			return "redirect:/member/login";
		} else {

			model.addAttribute("member", member);
			return "member/edit";
		}
	}

	// 회원정보를 수정하고 나서 어떤 페이지로 보낼 것인가.
	// 세션값을 삭제하는게 저희한테는 우선 로그아웃이었다.
	@PostMapping("/edit")
	public String updateProcess(HttpSession session, MemberDTO memberDTO) {
		memberService.updateMember(memberDTO);

//		session.invalidate();
//		return "redirect:/member/login"	;
		// 현재 로그인한 회원의 정보
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		// memberDTO 수정된 멤버의 정보
		String name = memberDTO.getName();
		String password = memberDTO.getPassword();
		if (name != null) {
			loginMember.setName(name);
		}
		return "redirect:/member/myPage";
	}

	// 회원 정보 삭제
	@GetMapping("/delete")
	public String deleteMember(HttpSession session) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		memberService.deleteMember(loginMember.getEmail());

		session.invalidate();
		return "redirect:/member/login";
	}

}
