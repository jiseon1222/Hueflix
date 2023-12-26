//비밀번호, 비밀번호 확인란이 일치하지 않을 시 메시지 출력
function checkPasswordMatch() {
    var password = document.getElementById("changePw").value;
    var confirmPassword = document.getElementById("confirmChangePw").value;
    var message = document.getElementById("changePwError");
    
    if (password !== confirmPassword && confirmPassword !== "") {
        message.innerHTML = "비밀번호가 일치하지 않습니다.";
    } else {
        message.innerHTML = "";
    }
}