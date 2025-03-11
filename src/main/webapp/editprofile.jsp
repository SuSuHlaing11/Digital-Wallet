<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bank.LanguageHelper"%>
<%
String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
%>
<%@ page import="java.sql.*, com.bank.database.DatabaseConnection"%>
<%@ page import="com.bank.model.User"%>
<%@ page import="com.bank.dao.UserDAO"%>

<%
if (session.getAttribute("accno") == null) {
	response.sendRedirect("sign_in.jsp"); // Redirect if admin is not logged in
	return; // Stop further execution
}
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76" href="img/logo.png">
<link rel="icon" type="image/png" href="img/logo.png">
<title><%=LanguageHelper.getMessage("title", lang)%></title>
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700,800"
	rel="stylesheet" />
<!-- Nucleo Icons -->
<link
	href="https://demos.creative-tim.com/soft-ui-dashboard/assets/css/nucleo-icons.css"
	rel="stylesheet" />
<link
	href="https://demos.creative-tim.com/soft-ui-dashboard/assets/css/nucleo-svg.css"
	rel="stylesheet" />
<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- CSS Files -->
<link rel="stylesheet" href="css_update/user.css">

<link id="pagestyle" href="css_update2/soft-ui-dashboard.css?v=1.1.0"
	rel="stylesheet" />

<!-- Nepcha Analytics (nepcha.com) -->
<!-- Nepcha is a easy-to-use web analytics. No cookies and fully compliant with GDPR, CCPA and PECR. -->
<script defer data-site="YOUR_DOMAIN_HERE"
	src="https://api.nepcha.com/js/nepcha-analytics.js"></script>
</head>

<%
Integer accno = (Integer) session.getAttribute("accno");
String acctype = (String) session.getAttribute("acctype");
Connection con = null;
PreparedStatement psBalance = null;
ResultSet rsBalance = null;
double balance = 0.00;
String defaultProfilePic = "img/No_Img.jpg";

try {
	User user = UserDAO.getUserByAccno(accno);
	if (user != null) {
		request.setAttribute("user", user);
		request.setAttribute("fullname", user.getFullname());

		// Ensure profile picture is not null
		String tempProfilePic = user.getProfilePicture();
		if (tempProfilePic == null || tempProfilePic.isEmpty()) {
	tempProfilePic = defaultProfilePic;
		}
		request.setAttribute("profilePicture", tempProfilePic);

		request.setAttribute("phone", user.getPhone());
		request.setAttribute("email", user.getEmail());
		request.setAttribute("username", user.getUsername());
	}

	// Fetch balance
	con = DatabaseConnection.getConnection();
	psBalance = con.prepareStatement("SELECT balance FROM balance WHERE accno = ?");
	psBalance.setInt(1, accno);
	rsBalance = psBalance.executeQuery();

	if (rsBalance.next()) {
		balance = rsBalance.getDouble("balance");
	}

	// Set balance as request attribute for JSP
	request.setAttribute("balance", balance);
} catch (Exception e) {
	e.printStackTrace();
} finally {
	try {
		if (rsBalance != null)
	rsBalance.close();
		if (psBalance != null)
	psBalance.close();
		if (con != null)
	con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
%>

<body class="bg g-sidenav-show profilemain" style="overflow-y: hidden;">
	<aside
		class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 "
		id="sidenav-main">
		<div class="bg-glass2">
			<div class="sidenav-header sticky-top glass-effect">
				<i
					class="fas fa-times p-3 cursor-pointer text-secondary opacity-1 position-absolute end-0 top-0 d-none d-xl-none"
					aria-hidden="true" id="iconSidenav"></i> <a
					class="navbar-brand m-0" href="index.jsp" target="_blank"> <img
					src="img/vue.png" class="navbar-brand-img h-100" alt="main_logo">
					<span class="ms-1 font-weight-bold"><%=LanguageHelper.getMessage("title", lang)%></span>
				</a>
			</div>
			<hr class="horizontal dark mt-0">
			<div class="collapse navbar-collapse  w-auto vh-100"
				id="sidenav-collapse-main">
				<ul class="navbar-nav">

					<li class="nav-item"><a class="nav-link " id="hover-link"
						href="homepage.jsp">
							<div
								class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">

								<svg width="12px" height="12px" viewBox="0 0 45 40"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink">
		                <title>shop </title>
		                <g stroke="none" stroke-width="1" fill="none"
										fill-rule="evenodd">
		                  <g transform="translate(-1716.000000, -439.000000)"
										fill="#FFFFFF" fill-rule="nonzero">
		                    <g transform="translate(1716.000000, 291.000000)">
		                      <g transform="translate(0.000000, 148.000000)">
		                        <path class="color-background opacity-6"
										d="M46.7199583,10.7414583 L40.8449583,0.949791667 C40.4909749,0.360605034 39.8540131,0 39.1666667,0 L7.83333333,0 C7.1459869,0 6.50902508,0.360605034 6.15504167,0.949791667 L0.280041667,10.7414583 C0.0969176761,11.0460037 -1.23209662e-05,11.3946378 -1.23209662e-05,11.75 C-0.00758042603,16.0663731 3.48367543,19.5725301 7.80004167,19.5833333 L7.81570833,19.5833333 C9.75003686,19.5882688 11.6168794,18.8726691 13.0522917,17.5760417 C16.0171492,20.2556967 20.5292675,20.2556967 23.494125,17.5760417 C26.4604562,20.2616016 30.9794188,20.2616016 33.94575,17.5760417 C36.2421905,19.6477597 39.5441143,20.1708521 42.3684437,18.9103691 C45.1927731,17.649886 47.0084685,14.8428276 47.0000295,11.75 C47.0000295,11.3946378 46.9030823,11.0460037 46.7199583,10.7414583 Z"></path>
		                        <path class="color-background"
										d="M39.198,22.4912623 C37.3776246,22.4928106 35.5817531,22.0149171 33.951625,21.0951667 L33.92225,21.1107282 C31.1430221,22.6838032 27.9255001,22.9318916 24.9844167,21.7998837 C24.4750389,21.605469 23.9777983,21.3722567 23.4960833,21.1018359 L23.4745417,21.1129513 C20.6961809,22.6871153 17.4786145,22.9344611 14.5386667,21.7998837 C14.029926,21.6054643 13.533337,21.3722507 13.0522917,21.1018359 C11.4250962,22.0190609 9.63246555,22.4947009 7.81570833,22.4912623 C7.16510551,22.4842162 6.51607673,22.4173045 5.875,22.2911849 L5.875,44.7220845 C5.875,45.9498589 6.7517757,46.9451667 7.83333333,46.9451667 L19.5833333,46.9451667 L19.5833333,33.6066734 L27.4166667,33.6066734 L27.4166667,46.9451667 L39.1666667,46.9451667 C40.2482243,46.9451667 41.125,45.9498589 41.125,44.7220845 L41.125,22.2822926 C40.4887822,22.4116582 39.8442868,22.4815492 39.198,22.4912623 Z"></path>
		                      </g>
		                    </g>
		                  </g>
		                </g>
		              </svg>
							</div> <span class="nav-link-text ms-1 text-white"
							style="font-size: 13px;"><%=LanguageHelper.getMessage("home_page", lang)%></span>
					</a></li>

					<!-- Deposit -->
					<li class="nav-item"><a class="nav-link " id="hover-link"
						href="deposit.jsp">
							<div
								class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
								<svg width="12px" height="12px" viewBox="0 0 16 16"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink">
                            <path fill="#000"
										d="M8 16l-2-3h1v-2h2v2h1l-2 3z"></path>
                            <path fill="#000"
										d="M15 1v8h-14v-8h14zM16 0h-16v10h16v-10z"></path>
                            <path fill="#000"
										d="M8 2c1.657 0 3 1.343 3 3s-1.343 3-3 3h5v-1h1v-4h-1v-1h-5z"></path>
                            <path fill="#000"
										d="M5 5c0-1.657 1.343-3 3-3h-5v1h-1v4h1v1h5c-1.657 0-3-1.343-3-3z"></path>
                      </svg>
							</div> <span class="nav-link-text ms-1 text-white"
							style="font-size: 13px;"><%=LanguageHelper.getMessage("deposit", lang)%></span>
					</a></li>

					<!-- Withdrawal -->
					<li class="nav-item"><a class="nav-link " id="hover-link"
						href="deposit.jsp">
							<div
								class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
								<svg width="12px" height="12px" viewBox="0 0 16 16"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000">
							<g id="SVGRepo_bgCarrier" stroke-width="0" />
							<g id="SVGRepo_tracerCarrier" stroke-linecap="round"
										stroke-linejoin="round" />
							<g id="SVGRepo_iconCarrier">
					        <path fill="#000" d="M8 0l2 3h-1v2h-2v-2h-1l2-3z" />
                            <path fill="#000"
										d="M15 7v8h-14v-8h14zM16 6h-16v10h16v-10z" />
                            <path fill="#000"
										d="M8 8c1.657 0 3 1.343 3 3s-1.343 3-3 3h5v-1h1v-4h-1v-1h-5z" />
                            <path fill="#000"
										d="M5 11c0-1.657 1.343-3 3-3h-5v1h-1v4h1v1h5c-1.657 0-3-1.343-3-3z" />
						    </g>
						</svg>
							</div> <span class="nav-link-text ms-1 text-white"
							style="font-size: 13px;"><%=LanguageHelper.getMessage("withdraw", lang)%></span>
					</a></li>

					<!-- Transfer -->
					<!-- Transfer -->
					<%
					if (!"Saving Account".equals(acctype)) {
					%>
					<!-- Transfer -->
					<li class="nav-item"><a class="nav-link " id="hover-link"
						href="transfer.jsp">
							<div
								class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
								<svg width="18px" height="18px" viewBox="-2.5 0 19 19"
									xmlns="http://www.w3.org/2000/svg" class="cf-icon-svg">
					                    <path
										d="M13.014 7.026v5.142a.476.476 0 0 1-.475.475H1.461a.476.476 0 0 1-.475-.475V7.026a.476.476 0 0 1 .475-.475h11.078a.476.476 0 0 1 .475.475zm-3.582 2.57a2.424 2.424 0 1 0-.191.947 2.417 2.417 0 0 0 .19-.946zm-.235-4.581a.554.554 0 0 1-.783 0l-.86-.86v1a.554.554 0 1 1-1.108 0v-1l-.86.86a.554.554 0 0 1-.783-.784l1.805-1.805a.554.554 0 0 1 .784 0L9.197 4.23a.554.554 0 0 1 0 .784zm0 9.947-1.805 1.806a.554.554 0 0 1-.784 0l-1.805-1.806a.554.554 0 0 1 .783-.783l.86.86v-1a.554.554 0 0 1 1.108 0v1l.86-.86a.554.554 0 1 1 .783.783zm-1.05-4.729a.83.83 0 0 1-.416.716 1.326 1.326 0 0 1-.413.173v.266a.317.317 0 0 1-.633 0v-.262a1.449 1.449 0 0 1-.268-.084.943.943 0 0 1-.362-.265.317.317 0 0 1 .479-.415.32.32 0 0 0 .118.092.842.842 0 0 0 .162.052 1.248 1.248 0 0 0 .176.022.765.765 0 0 0 .397-.11c.127-.082.127-.152.127-.185a.218.218 0 0 0-.053-.14.504.504 0 0 0-.132-.106.668.668 0 0 0-.163-.058.765.765 0 0 0-.16-.017 1.642 1.642 0 0 1-.273-.021 1.248 1.248 0 0 1-.352-.114 1.018 1.018 0 0 1-.335-.269.864.864 0 0 1-.198-.542.876.876 0 0 1 .435-.74 1.314 1.314 0 0 1 .402-.165v-.255a.317.317 0 0 1 .633 0v.264a1.513 1.513 0 0 1 .273.095 1.085 1.085 0 0 1 .318.218.317.317 0 0 1-.448.449.454.454 0 0 0-.13-.09.887.887 0 0 0-.167-.058l-.017-.004a.842.842 0 0 0-.137-.023.768.768 0 0 0-.389.104.249.249 0 0 0-.14.205.242.242 0 0 0 .057.143.394.394 0 0 0 .126.101.627.627 0 0 0 .173.056 1.01 1.01 0 0 0 .169.013 1.4 1.4 0 0 1 .295.03 1.305 1.305 0 0 1 .323.117 1.13 1.13 0 0 1 .314.25.848.848 0 0 1 .21.557z" />
					                </svg>
							</div> <span class="nav-link-text ms-1 text-white"
							style="font-size: 13px;"><%=LanguageHelper.getMessage("transfer", lang)%></span>
					</a></li>
					<%
					}
					%>

					<!-- Exchange Converter -->
					<li class="nav-item"><a class="nav-link " id="hover-link"
						href="exchange_converter.jsp">
							<div
								class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
								<svg width="12px" height="12px" viewBox="0 0 43 36"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink">
		                <title>credit-card</title>
		                <g stroke="none" stroke-width="1" fill="none"
										fill-rule="evenodd">
		                  <g transform="translate(-2169.000000, -745.000000)"
										fill="#FFFFFF" fill-rule="nonzero">
		                    <g transform="translate(1716.000000, 291.000000)">
		                      <g transform="translate(453.000000, 454.000000)">
		                        <path class="color-background opacity-6"
										d="M43,10.7482083 L43,3.58333333 C43,1.60354167 41.3964583,0 39.4166667,0 L3.58333333,0 C1.60354167,0 0,1.60354167 0,3.58333333 L0,10.7482083 L43,10.7482083 Z"></path>
		                        <path class="color-background"
										d="M0,16.125 L0,32.25 C0,34.2297917 1.60354167,35.8333333 3.58333333,35.8333333 L39.4166667,35.8333333 C41.3964583,35.8333333 43,34.2297917 43,32.25 L43,16.125 L0,16.125 Z M19.7083333,26.875 L7.16666667,26.875 L7.16666667,23.2916667 L19.7083333,23.2916667 L19.7083333,26.875 Z M35.8333333,26.875 L28.6666667,26.875 L28.6666667,23.2916667 L35.8333333,23.2916667 L35.8333333,26.875 Z"></path>
		                      </g>
		                    </g>
		                  </g>
		                </g>
		              </svg>
							</div> <span class="nav-link-text ms-1 text-white"
							style="font-size: 13px;"><%=LanguageHelper.getMessage("exchange_rate", lang)%></span>
					</a></li>

					<!-- Account Pages  -->
					<li class="nav-item mt-3">
						<h6
							class="ps-4 ms-2 text-uppercase text-xs font-weight-bolder opacity-6 text-white"><%=LanguageHelper.getMessage("acc_setting", lang)%></h6>
					</li>

					<!-- Edit Profile  -->
					<li class="nav-item"><a class="nav-link active"
						href="editprofile.jsp">
							<div
								class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
								<svg width="12px" height="12px" viewBox="0 0 40 44"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink">
		                <title>document</title>
		                <g stroke="none" stroke-width="1" fill="none"
										fill-rule="evenodd">
		                  <g transform="translate(-1870.000000, -591.000000)"
										fill="#FFFFFF" fill-rule="nonzero">
		                    <g transform="translate(1716.000000, 291.000000)">
		                      <g transform="translate(154.000000, 300.000000)">
		                        <path class="color-background opacity-6"
										d="M40,40 L36.3636364,40 L36.3636364,3.63636364 L5.45454545,3.63636364 L5.45454545,0 L38.1818182,0 C39.1854545,0 40,0.814545455 40,1.81818182 L40,40 Z"></path>
		                        <path class="color-background"
										d="M30.9090909,7.27272727 L1.81818182,7.27272727 C0.814545455,7.27272727 0,8.08727273 0,9.09090909 L0,41.8181818 C0,42.8218182 0.814545455,43.6363636 1.81818182,43.6363636 L30.9090909,43.6363636 C31.9127273,43.6363636 32.7272727,42.8218182 32.7272727,41.8181818 L32.7272727,9.09090909 C32.7272727,8.08727273 31.9127273,7.27272727 30.9090909,7.27272727 Z M18.1818182,34.5454545 L7.27272727,34.5454545 L7.27272727,30.9090909 L18.1818182,30.9090909 L18.1818182,34.5454545 Z M25.4545455,27.2727273 L7.27272727,27.2727273 L7.27272727,23.6363636 L25.4545455,23.6363636 L25.4545455,27.2727273 Z M25.4545455,20 L7.27272727,20 L7.27272727,16.3636364 L25.4545455,16.3636364 L25.4545455,20 Z"></path>
		                      </g>
		                    </g>
		                  </g>
		                </g>
		              </svg>
							</div> <span class="nav-link-text ms-1 text-white"
							style="font-size: 13px;"><%=LanguageHelper.getMessage("profile", lang)%></span>
					</a></li>

					<!-- History  -->
					<li class="nav-item"><a class="nav-link " id="hover-link"
						href="history.jsp">
							<div
								class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
								<svg width="12px" height="12px" viewBox="0 0 40 44"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink">
		                <title>document</title>
		                <g stroke="none" stroke-width="1" fill="none"
										fill-rule="evenodd">
		                  <g transform="translate(-1870.000000, -591.000000)"
										fill="#FFFFFF" fill-rule="nonzero">
		                    <g transform="translate(1716.000000, 291.000000)">
		                      <g transform="translate(154.000000, 300.000000)">
		                        <path class="color-background opacity-6"
										d="M40,40 L36.3636364,40 L36.3636364,3.63636364 L5.45454545,3.63636364 L5.45454545,0 L38.1818182,0 C39.1854545,0 40,0.814545455 40,1.81818182 L40,40 Z"></path>
		                        <path class="color-background"
										d="M30.9090909,7.27272727 L1.81818182,7.27272727 C0.814545455,7.27272727 0,8.08727273 0,9.09090909 L0,41.8181818 C0,42.8218182 0.814545455,43.6363636 1.81818182,43.6363636 L30.9090909,43.6363636 C31.9127273,43.6363636 32.7272727,42.8218182 32.7272727,41.8181818 L32.7272727,9.09090909 C32.7272727,8.08727273 31.9127273,7.27272727 30.9090909,7.27272727 Z M18.1818182,34.5454545 L7.27272727,34.5454545 L7.27272727,30.9090909 L18.1818182,30.9090909 L18.1818182,34.5454545 Z M25.4545455,27.2727273 L7.27272727,27.2727273 L7.27272727,23.6363636 L25.4545455,23.6363636 L25.4545455,27.2727273 Z M25.4545455,20 L7.27272727,20 L7.27272727,16.3636364 L25.4545455,16.3636364 L25.4545455,20 Z"></path>
		                      </g>
		                    </g>
		                  </g>
		                </g>
		              </svg>
							</div> <span class="nav-link-text ms-1 text-white"
							style="font-size: 13px;"><%=LanguageHelper.getMessage("history", lang)%></span>
					</a></li>

					<!-- Sign out  -->
					<li class="nav-item"><a class="nav-link " id="hover-link"
						href="logout.jsp">
							<div
								class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
								<svg width="12px" height="12px" viewBox="0 0 512 512"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink">
                                <title>Sign Out</title>
                                <g stroke="none" stroke-width="1"
										fill="none" fill-rule="evenodd">
                                    <g fill="#FFFFFF"
										fill-rule="nonzero">
                                        <!-- Door -->
                                        <path
										class="color-background opacity-6"
										d="M320,480 L320,32 C320,14.3 334.3,0 352,0 L448,0 C465.7,0 480,14.3 480,32 L480,480 C480,497.7 465.7,512 448,512 L352,512 C334.3,512 320,497.7 320,480 Z">
                                        </path>
                                        <!-- Arrow -->
                                        <path class="color-background"
										d="M169.4,142.1 C162.9,148.6 162.9,159.4 169.4,165.9 L238.1,234.6 L24,234.6 C10.7,234.6 0,245.3 0,258.6 C0,271.9 10.7,282.6 24,282.6 L238.1,282.6 L169.4,351.3 C162.9,357.8 162.9,368.6 169.4,375.1 C175.9,381.6 186.7,381.6 193.2,375.1 L285.2,283.1 C291.7,276.6 291.7,265.8 285.2,259.3 L193.2,167.3 C186.7,160.8 175.9,160.8 169.4,142.1 Z">
                                        </path>
                                    </g>
                                </g>
                       </svg>
							</div> <span class="nav-link-text ms-1 text-white"
							style="font-size: 13px;"><%=LanguageHelper.getMessage("sign_out", lang)%></span>
					</a></li>

				</ul>
			</div>
		</div>
	</aside>
	<div class="main-content position-relative max-height-vh-100 h-100"
		style="padding-top: 15px;">
		<!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg  shadow-none position-absolute px-4 w-100 z-index-2">

			<div class="container-fluid py-1">
				<nav aria-label="breadcrumb" style="padding-top: 0px;">
					<ol
						class="breadcrumb bg-transparent mb-0 pb-0 pt-1 ps-2 me-sm-6 me-5">
						<li class="breadcrumb-item text-sm"><a
							class="text-white opacity-5" href="javascript:;"><%=LanguageHelper.getMessage("pages", lang)%></a></li>
						<li class="breadcrumb-item text-sm text-white active"
							aria-current="page"><%=LanguageHelper.getMessage("profile", lang)%></li>
					</ol>
					<h6 class="text-white font-weight-bolder ms-2">
						<%=LanguageHelper.getMessage("acc_num", lang)%>:
						<%=accno%></h6>

					<h6 class="ms-2 mb-0 text-white font-weight-bolder">
						<%=LanguageHelper.getMessage("balance", lang)%>: <span id="balance"
							data-actual-balance="<%=String.format("%.2f", balance)%>">******</span>
						<i id="toggleBalance" class="fa fa-eye-slash ms-1"
							style="font-size: 10px; cursor: pointer;"></i>
					</h6>
				</nav>

				<div class="collapse navbar-collapse me-md-0 me-sm-4 mt-sm-0 mt-2"
					id="navbar">
					<div class="ms-md-auto pe-md-3 d-flex align-items-center"></div>

					<ul class="navbar-nav  justify-content-end">
						<li class="nav-item d-flex align-items-center"><a
							href="logout.jsp" id="hover-link"
							class="nav-link text-white font-weight-bold px-0"> <i
								class="fa fa-user me-sm-1"></i> <span
								class="d-sm-inline d-none text-white" style="font-size: 13px;"><%=LanguageHelper.getMessage("sign_out", lang)%></span>
						</a></li>
					</ul>

				</div>
			</div>

		</nav>

		<!-- End Navbar -->
		<div class="container-fluid ">
			<div class="bg-glass2">
				<div
					class="page-header min-height-200 border-radius-lg mt-3 d-flex flex-column justify-content-end">
					<span class="mask bg-primary opacity-0"></span>
					<div class="w-100 position-relative p-3">
						<div class="d-flex justify-content-between align-items-end">
							<div class="d-flex align-items-center" style="margin-left: 10px;">
								<div class="avatar avatar-xl position-relative me-3">
									<!-- Display Profile Picture -->
									<img
										src="${user.profilePicture != null && !user.profilePicture.isEmpty() ? user.profilePicture : 'img/No_Img.jpg'}"
										alt="profile_image" class="w-100 border-radius-lg shadow-sm">

								</div>
								<div>
									<h5 class="mb-1 text-white font-weight-bolder">
										${user.fullname}</h5>
									<p class="mb-0 text-white text-sm">${user.acctype}</p>
								</div>

								<div class="d-flex justify-content-end mt-4"
									style="margin-left: 520px;">
									<a href="profile.jsp">
										<button type="submit"
											class="btn bg-purple text-white m-0 ms-2"><%=LanguageHelper.getMessage("profile", lang)%></button>
									</a>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="container-fluid py-4">
			<div class="row d-flex justify-content-center">
				<div class="col-12 col-xl-9">
					<div class="card h-100 bg-glass3">
						<div class="card-header pb-0 p-3 bg-transparent">
							<div class="row">
								<div class="col-md-8 d-flex align-items-center">
									<h6 class="mb-0 text-white"><%=LanguageHelper.getMessage("edit_profile", lang)%></h6>
								</div>
							</div>
						</div>
						<div class="card-body p-3">
							<form action="EditController" method="post"
								enctype="multipart/form-data">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-control-label text-white"><%=LanguageHelper.getMessage("username", lang)%></label>
											<input type="text" name="username"
												class="form-control transparent-input"
												value="${user.username}" required>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-control-label text-white"><%=LanguageHelper.getMessage("email", lang)%></label> <input type="email" name="email"
												class="form-control transparent-input"
												style="color: black !important;" value="${user.email}"
												disabled>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-control-label text-white"><%=LanguageHelper.getMessage("mobile", lang)%></label> 
												<input type="text" name="phone"
												id="phone_num" class="form-control transparent-input"
												value="${user.phone}" placeholder="+959" maxlength="15" pattern="(\+959|959)[0-9]{8,11}"
												title="Phone number must start with +959 or 959, followed by 8 to 11 digits." required>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label class="form-control-label text-white"><%=LanguageHelper.getMessage("profile_pic", lang)%></label> <input type="file"
												class="form-control transparent-input"
												name="profile_picture" id="profilePicInput" accept="image/*">
										</div>
									</div>

									<script>
document.getElementById("profilePicInput").addEventListener("change", function(event) {
    var file = event.target.files[0];
    if (file) {
        console.log("Selected File: " + file.name + " | Size: " + file.size + " bytes");
    } else {
        console.log("No file selected.");
    }
});
</script>
									<div class="d-flex justify-content-end mt-4">
										<a href="profile.jsp" class="btn m-0 text-white bg-purple"><%=LanguageHelper.getMessage("cancel", lang)%></a>
										<button type="submit"
											class="btn bg-purple text-white m-0 ms-2"><%=LanguageHelper.getMessage("save_changes", lang)%></button>
									</div>
							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--   Core JS Files   -->
	<script src="js/core/popper.min.js"></script>
	<script src="js/core/bootstrap.min.js"></script>
	<script src="js/plugins/perfect-scrollbar.min.js"></script>
	<script src="js/plugins/smooth-scrollbar.min.js"></script>

	<script>
    document.addEventListener("DOMContentLoaded", function () {
        var toggleBalance = document.getElementById("toggleBalance");
        var balanceElement = document.getElementById("balance");
        var actualBalance = balanceElement.getAttribute("data-actual-balance"); // Get balance from data attribute

        toggleBalance.addEventListener("click", function () {
            if (balanceElement.innerText === "******") {
                balanceElement.innerText = actualBalance; // Show balance
                this.classList.remove("fa-eye-slash");
                this.classList.add("fa-eye");
            } else {
                balanceElement.innerText = "******"; // Hide balance
                this.classList.remove("fa-eye");
                this.classList.add("fa-eye-slash");
            }
        });
    });
</script>

	<script>
		var win = navigator.platform.indexOf('Win') > -1;
		if (win && document.querySelector('#sidenav-scrollbar')) {
			var options = {
				damping : '0.5'
			}
			Scrollbar.init(document.querySelector('#sidenav-scrollbar'),
					options);
		}

		String
		nrcNumber = request.getParameter("phone_num"); // Get the NRC number

		// Validate NRC number if needed (only digits, length of 6)
		if (nrcNumber != null && !nrcNumber.matches("\\d{6}")) {
			response
					.sendRedirect("editprofile.jsp?error=Invalid NRC number format");
			return;
		}
	</script>
	<!-- Github buttons -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>
	<!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="js/soft-ui-dashboard.min.js?v=1.1.0"></script>
</body>

</html>