//로그인, 회원가입 폼 애니메이션
document.addEventListener('DOMContentLoaded', function() {
	const signUpButton = document.getElementById('signUp');
	const signInButton = document.getElementById('signIn');
	const container = document.getElementById('container');
	
	signUpButton.addEventListener('click', () => {
	  container.classList.add("right-panel-active");
	});
	
	signInButton.addEventListener('click', () => {
	  container.classList.remove("right-panel-active");
	});
});

// 페이지가 로드될 때 폼을 체크하여 버튼 상태를 설정
document.addEventListener("DOMContentLoaded", function() {
    checkForm();
});

//입력폼에 에러 메시지가 출력 시, 해당 폼의 색깔 변경
//자동 완성 입력은 이벤트가 발생하지 않으므로 테스트 시 주의
function showErrorStyles(elementId) {
    var element = document.getElementById(elementId);
    element.classList.add('error');
}

function resetErrorStyles(elementId) {
    var element = document.getElementById(elementId);
    element.classList.remove('error');
}

//에러 메시지가 하나라도 출력되거나, 하나라도 null일 시 회원가입 버튼 비활성화
function checkForm() { 
	
    var passwordMessage = document.getElementById("pwMsg").innerHTML;
    var emailMessage = document.getElementById("idMsg").innerHTML;
    var nicknameMessage = document.getElementById("nicknameMsg").innerHTML;
    
    // 입력값이 없을 때 버튼 비활성화
    var emailValue = document.getElementById("joinUserEmail").value;
    var nicknameValue = document.getElementById("joinUserNick").value;
    var passwordValue = document.getElementById("joinPw").value;
    var confirmPasswordValue = document.getElementById("confirmPw").value;
    
    var signUpButton = document.querySelector(".sign-up-container button[type='submit']");

    if (passwordMessage || emailMessage || nicknameMessage || !emailValue || !nicknameValue || !passwordValue || !confirmPasswordValue) {
        signUpButton.disabled = true;
    } else {
        signUpButton.disabled = false;
    }
}

// 비밀번호, 비밀번호 확인란이 일치하지 않을 시 메시지 출력
function checkPasswordMatch() {
    var password = document.getElementById("joinPw").value;
    var confirmPassword = document.getElementById("confirmPw").value;
    var message = document.getElementById("pwMsg");
    
    if (password !== confirmPassword && confirmPassword !== "") {
    	showErrorStyles("joinPw");
    	showErrorStyles("confirmPw");
        message.innerHTML = "비밀번호가 일치하지 않습니다.";
    } else {
    	resetErrorStyles("joinPw");
    	resetErrorStyles("confirmPw");
        message.innerHTML = "";
    }
    checkForm();
}

//이메일 형식 검사 정규식
function validateEmail(email) {
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
}

//아이디 체크
function checkEmailAvailability() {
    var userEmail = document.getElementById("joinUserEmail").value;
    var message = document.getElementById("idMsg");
    
    // 입력 값이 null 또는 빈 문자열인 경우 처리
    if (!userEmail) {
    	resetErrorStyles("joinUserEmail");
        message.innerHTML = ""; // 메시지 초기화
        return; // 함수 종료
    }
    
    $.ajax({
        url: 'register/process/checkEmail',
        type: 'POST',
        data: userEmail,
        contentType: 'application/json',
        success: function(data) {
            if (data > 0) {
            	showErrorStyles("joinUserEmail");
            	message.innerHTML = "이미 존재하는 아이디입니다.";
            } else if(!validateEmail(userEmail)) {
            	showErrorStyles("joinUserEmail");
            	message.innerHTML = "올바른 이메일 주소 형식이 아닙니다.";
            } else {
            	resetErrorStyles("joinUserEmail");
                message.innerHTML = ""; // 초기화
            }
            checkForm();
        },
	    error: function(error) {
	        console.error("Error in checkEmailAvailability:", error);
	    }
    });
}

//닉네임 중복 체크
function checkNicknameAvailability() {
    var nickname = document.getElementById("joinUserNick").value;
    var message = document.getElementById("nicknameMsg");
    
    // 입력 값이 null 또는 빈 문자열인 경우 처리
    if (!nickname) {
    	resetErrorStyles("joinUserNick");
        message.innerHTML = ""; // 메시지 초기화
        return; // 함수 종료
    }
    
    $.ajax({
        url: 'register/process/checkNickname',
        type: 'POST',
        data: nickname,
        contentType: 'application/json',
        success: function(data) {
            if (data > 0) {
            	showErrorStyles("joinUserNick");
            	message.innerHTML = "이미 존재하는 닉네임입니다.";
            }else {
            	resetErrorStyles("joinUserNick");
                message.innerHTML = "";
            }
            checkForm();
        },
        error: function(error) {
            console.error("Error in checkNicknameAvailability:", error);
        }
    });
}

