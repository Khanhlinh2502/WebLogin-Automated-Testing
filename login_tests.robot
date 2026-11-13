*** Settings ***
Documentation	Kiem thu tu dong he thong WebLogin - 31 Test Case Hop Den (DTU CMU-SE 303 MIS)
Library	SeleniumLibrary

Suite Setup	Open Browser To Login Page
Suite Teardown	Close Browser
Test Setup	Reset Form Va Trang Thai
Test Template	Kiem Tra Dang Nhap

*** Variables ***
${LOGIN URL}	http://127.0.0.1:5500/WebLogin.html
${BROWSER}	Chrome

${TXT_USERNAME}	id=username
${TXT_PASSWORD}	id=password
${BTN_LOGIN}	id=btnSubmit
${MSG_BOX}	id=msgBox

*** Keywords ***
Open Browser To Login Page
	Open Browser	${LOGIN URL}	${BROWSER}
	Maximize Browser Window
	Set Selenium Speed	0.04s

Reset Form Va Trang Thai
	Execute Javascript	if (window.resetState) { window.resetState(); } else { window.failCount = 0; }

Kiem Tra Dang Nhap
	[Arguments]	${username}	${password}	${expected_msg}
	Input Text	${TXT_USERNAME}	${username}
	Input Text	${TXT_PASSWORD}	${password}
	Click Button	${BTN_LOGIN}
	Sleep	0.2s
	${actual_msg}=	Get Text	${MSG_BOX}
	Should Be Equal As Strings	${actual_msg}	${expected_msg}

Kiem Tra Khoa Sau 3 Lan Sai
	[Arguments]	${username}	${password}	${expected_msg}
	FOR	${i}	IN RANGE	3
		Input Text	${TXT_USERNAME}	linh.tran
		Input Text	${TXT_PASSWORD}	WrongPass${i}
		Click Button	${BTN_LOGIN}
		Sleep	0.1s
	END
	Input Text	${TXT_USERNAME}	${username}
	Input Text	${TXT_PASSWORD}	${password}
	Click Button	${BTN_LOGIN}
	Sleep	0.2s
	${actual_msg}=	Get Text	${MSG_BOX}
	Should Be Equal As Strings	${actual_msg}	${expected_msg}

*** Test Cases ***
# ====================================================================================================================
# PHAN 1: PHAN TICH GIA TRI BIEN (BOUNDARY VALUE ANALYSIS - BVA) [12 TEST CASES]
# ====================================================================================================================
TC_BVA_01	linh	Secret@2026	Tên đăng nhập phải có độ dài từ 5 đến 20 ký tự.
TC_BVA_02	linht	Secret@2026	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_BVA_03	linhtr	Secret@2026	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_BVA_04	1234567890123456789	Secret@2026	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_BVA_05	12345678901234567890	Secret@2026	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_BVA_06	123456789012345678901	Secret@2026	Tên đăng nhập phải có độ dài từ 5 đến 20 ký tự.
TC_BVA_07	linh.tran	Abc1!	Mật khẩu phải có độ dài từ 6 đến 32 ký tự.
TC_BVA_08	linh.tran	Pass1!	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_BVA_09	linh.tran	Secr@12	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_BVA_10	linh.tran	A1b2c3d4e5f6g7h8i9j0k1l2m3n4o5!	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_BVA_11	linh.tran	A1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p!	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_BVA_12	linh.tran	Pass12345678901234567890123456789	Mật khẩu phải có độ dài từ 6 đến 32 ký tự.

# ====================================================================================================================
# PHAN 2: PHAN VUNG TUONG DUONG (EQUIVALENCE PARTITIONING - EP) [12 TEST CASES - THU TU CHUAN LOP 8 DEN 17]
# ====================================================================================================================
TC_EP_01	linh.tran	Secret@2026	Đăng nhập thành công! Chào mừng linh.tran (Admin).
TC_EP_02	${SPACE}${SPACE}linh.tran${SPACE}	Secret@2026	Đăng nhập thành công! Chào mừng linh.tran (Admin).
TC_EP_03	${EMPTY}	Secret@2026	Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.
TC_EP_04	qa	Secret@2026	Tên đăng nhập phải có độ dài từ 5 đến 20 ký tự.
TC_EP_05	nguyenthikhanhlinh2026	Secret@2026	Tên đăng nhập phải có độ dài từ 5 đến 20 ký tự.
TC_EP_06	unknown_user	Secret@2026	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_EP_07	blocked_acc	Pass#9999	Tài khoản của bạn đã bị vô hiệu hóa!
TC_EP_08	linh.tran	${EMPTY}	Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.
TC_EP_09	linh.tran	12345	Mật khẩu phải có độ dài từ 6 đến 32 ký tự.
TC_EP_10	linh.tran	WrongPassword@123	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_EP_11	linh.tran	secret@2026	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_EP_12	${EMPTY}	${EMPTY}	Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.

# ====================================================================================================================
# PHAN 3: BANG QUYET DINH (DECISION TABLE - DT) [7 TEST CASES]
# ====================================================================================================================
TC_DT_01
	[Template]	Kiem Tra Khoa Sau 3 Lan Sai
	linh.tran	Secret@2026	Tài khoản bị tạm khóa do nhập sai liên tiếp quá 3 lần!

TC_DT_02	abc	Secret@2026	Tên đăng nhập phải có độ dài từ 5 đến 20 ký tự.
TC_DT_03	guest_notfound	Secret@2026	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_DT_04	tester_qa	WrongPass123	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_DT_05	tester_qa	testing#123	Thông tin đăng nhập không chính xác! (Còn 2 lần)
TC_DT_06	blocked_acc	Secret@2026	Tài khoản của bạn đã bị vô hiệu hóa!
TC_DT_07	tester_qa	Testing#123	Đăng nhập thành công! Chào mừng tester_qa (Tester).