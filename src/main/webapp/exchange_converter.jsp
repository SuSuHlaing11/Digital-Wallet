<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.bank.database.DatabaseConnection"%>
<%@ page import="com.bank.LanguageHelper"%>
<%
String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
%>
<%
if (session.getAttribute("accno") == null) {
    response.sendRedirect("sign_in.jsp"); // Redirect if admin is not logged in
    return; // Stop further execution
}
Integer userId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="apple-touch-icon" sizes="76x76" href="img/logo.png">
    <link rel="icon" type="image/png" href="img/logo.png">
    <title>
        <%=LanguageHelper.getMessage("title", lang)%>
    </title>
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
<link id="pagestyle" href="css_update2/soft-ui-dashboard.css?v=1.1.0" rel="stylesheet" />
    
<link id="pagestyle" href="css/soft-ui-dashboard.css?v=1.1.0"
	rel="stylesheet" />
<!-- Nepcha Analytics (nepcha.com) -->
<!-- Nepcha is a easy-to-use web analytics. No cookies and fully compliant with GDPR, CCPA and PECR. -->
<script defer data-site="YOUR_DOMAIN_HERE"
	src="https://api.nepcha.com/js/nepcha-analytics.js"></script>
	
<style>
	select.form-control {
    color: black !important;
}	
	select option {
    color: #a852fd; /* Change text color */
    background-color: #210d35;/* Change background color */
}
</style>

</head>

<%
String uname = (String) session.getAttribute("uname");
String acctype = (String) session.getAttribute("acctype");
Integer accno = (Integer) session.getAttribute("accno");

// Check if the user is logged in
if (accno == null) {
    response.sendRedirect("sign_in.jsp");
    return; // Stop further execution
}

String username = "User"; // Default
String fullname = "Full Name"; // Default
double balance = 0.00; // Default balance

Connection conn = null;
PreparedStatement psUser = null;
PreparedStatement psBalance = null;
ResultSet rsUser = null;
ResultSet rsBalance = null;

try {
    // Get database connection from custom class
    conn = DatabaseConnection.getConnection();

    // Query user details based on account number
    psUser = conn.prepareStatement("SELECT username, fullname, acctype FROM user WHERE accno = ?");
    psUser.setInt(1, accno);
    rsUser = psUser.executeQuery();

    if (rsUser.next()) {
        username = rsUser.getString("username");
        fullname = rsUser.getString("fullname");
        acctype = rsUser.getString("acctype");
    }

    // Query balance from balance table
    psBalance = conn.prepareStatement("SELECT balance FROM balance WHERE accno = ?");
    psBalance.setInt(1, accno);
    rsBalance = psBalance.executeQuery();

    if (rsBalance.next()) {
        balance = rsBalance.getDouble("balance");
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (rsUser != null) rsUser.close();
        if (psUser != null) psUser.close();
        if (rsBalance != null) rsBalance.close();
        if (psBalance != null) psBalance.close();
        if (conn != null) conn.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}
%>

<body class="g-sidenav-show profilemain" style="overflow-y:hidden;">
    <aside
        class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 "
        id="sidenav-main">
        <div class="bg-glass2">
        <div class="sidenav-header sticky-top glass-effect">
            <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-1 position-absolute end-0 top-0 d-none d-xl-none"
                aria-hidden="true" id="iconSidenav"></i>
            <a class="navbar-brand m-0" href="index.jsp"
                target="_blank">
                <img src="img/vue.png" class="navbar-brand-img h-100" alt="main_logo">
        		<span class="ms-1 font-weight-bold"><%=LanguageHelper.getMessage("title", lang)%></span>
            </a>
        </div>
        <hr class="horizontal dark mt-0">
        <div class="collapse navbar-collapse  w-auto vh-100" id="sidenav-collapse-main">
            <ul class="navbar-nav">
            
            	<li class="nav-item">
		          <a class="nav-link " id="hover-link" href="homepage.jsp">
		            <div class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
		              	
		              <svg width="12px" height="12px" viewBox="0 0 45 40" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
		                <title>shop </title>
		                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
		                  <g transform="translate(-1716.000000, -439.000000)" fill="#FFFFFF" fill-rule="nonzero">
		                    <g transform="translate(1716.000000, 291.000000)">
		                      <g transform="translate(0.000000, 148.000000)">
		                        <path class="color-background opacity-6" d="M46.7199583,10.7414583 L40.8449583,0.949791667 C40.4909749,0.360605034 39.8540131,0 39.1666667,0 L7.83333333,0 C7.1459869,0 6.50902508,0.360605034 6.15504167,0.949791667 L0.280041667,10.7414583 C0.0969176761,11.0460037 -1.23209662e-05,11.3946378 -1.23209662e-05,11.75 C-0.00758042603,16.0663731 3.48367543,19.5725301 7.80004167,19.5833333 L7.81570833,19.5833333 C9.75003686,19.5882688 11.6168794,18.8726691 13.0522917,17.5760417 C16.0171492,20.2556967 20.5292675,20.2556967 23.494125,17.5760417 C26.4604562,20.2616016 30.9794188,20.2616016 33.94575,17.5760417 C36.2421905,19.6477597 39.5441143,20.1708521 42.3684437,18.9103691 C45.1927731,17.649886 47.0084685,14.8428276 47.0000295,11.75 C47.0000295,11.3946378 46.9030823,11.0460037 46.7199583,10.7414583 Z"></path>
		                        <path class="color-background" d="M39.198,22.4912623 C37.3776246,22.4928106 35.5817531,22.0149171 33.951625,21.0951667 L33.92225,21.1107282 C31.1430221,22.6838032 27.9255001,22.9318916 24.9844167,21.7998837 C24.4750389,21.605469 23.9777983,21.3722567 23.4960833,21.1018359 L23.4745417,21.1129513 C20.6961809,22.6871153 17.4786145,22.9344611 14.5386667,21.7998837 C14.029926,21.6054643 13.533337,21.3722507 13.0522917,21.1018359 C11.4250962,22.0190609 9.63246555,22.4947009 7.81570833,22.4912623 C7.16510551,22.4842162 6.51607673,22.4173045 5.875,22.2911849 L5.875,44.7220845 C5.875,45.9498589 6.7517757,46.9451667 7.83333333,46.9451667 L19.5833333,46.9451667 L19.5833333,33.6066734 L27.4166667,33.6066734 L27.4166667,46.9451667 L39.1666667,46.9451667 C40.2482243,46.9451667 41.125,45.9498589 41.125,44.7220845 L41.125,22.2822926 C40.4887822,22.4116582 39.8442868,22.4815492 39.198,22.4912623 Z"></path>
		                      </g>
		                    </g>
		                  </g>
		                </g>
		              </svg>
		            </div>
		            <span class="nav-link-text ms-1 text-white" style="font-size:13px;"><%=LanguageHelper.getMessage("home_page", lang)%></span>
		          </a>
		        </li>
		        
                <!-- Deposit -->
                <li class="nav-item">
		          <a class="nav-link " id="hover-link" href="deposit.jsp">
		            <div class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
		              <svg width="12px" height="12px" viewBox="0 0 16 16" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <path fill="#000" d="M8 16l-2-3h1v-2h2v2h1l-2 3z"></path>
                            <path fill="#000" d="M15 1v8h-14v-8h14zM16 0h-16v10h16v-10z"></path>
                            <path fill="#000" d="M8 2c1.657 0 3 1.343 3 3s-1.343 3-3 3h5v-1h1v-4h-1v-1h-5z"></path>
                            <path fill="#000" d="M5 5c0-1.657 1.343-3 3-3h-5v1h-1v4h1v1h5c-1.657 0-3-1.343-3-3z"></path>
                      </svg>
		            </div>
		            <span class="nav-link-text ms-1 text-white" style="font-size:13px;"><%=LanguageHelper.getMessage("deposit", lang)%></span>
		          </a>
		        </li>
		        
		        <!-- Withdrawal -->
		        <li class="nav-item">
		          <a class="nav-link" id="hover-link" href="withdraw.jsp">
		            <div class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
		              <svg width="12px" height="12px" viewBox="0 0 16 16" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000">
							<g id="SVGRepo_bgCarrier" stroke-width="0" />
							<g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" />
							<g id="SVGRepo_iconCarrier">
					        <path fill="#000" d="M8 0l2 3h-1v2h-2v-2h-1l2-3z" />
                            <path fill="#000" d="M15 7v8h-14v-8h14zM16 6h-16v10h16v-10z" />
                            <path fill="#000" d="M8 8c1.657 0 3 1.343 3 3s-1.343 3-3 3h5v-1h1v-4h-1v-1h-5z" />
                            <path fill="#000"	d="M5 11c0-1.657 1.343-3 3-3h-5v1h-1v4h1v1h5c-1.657 0-3-1.343-3-3z" />
						    </g>
						</svg>
		            </div>
		            <span class="nav-link-text ms-1 text-white" style="font-size:13px;"><%=LanguageHelper.getMessage("withdraw", lang)%></span>
		          </a>
		        </li>
		        
		        <!-- Transfer -->
		        <% if (!"Saving Account".equals(acctype)) { %>
				    <!-- Transfer -->
				    <li class="nav-item">
				        <a class="nav-link " id="hover-link" href="transfer.jsp">
				            <div class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
				                <svg width="18px" height="18px" viewBox="-2.5 0 19 19" xmlns="http://www.w3.org/2000/svg" class="cf-icon-svg">
				                    <path d="M13.014 7.026v5.142a.476.476 0 0 1-.475.475H1.461a.476.476 0 0 1-.475-.475V7.026a.476.476 0 0 1 .475-.475h11.078a.476.476 0 0 1 .475.475zm-3.582 2.57a2.424 2.424 0 1 0-.191.947 2.417 2.417 0 0 0 .19-.946zm-.235-4.581a.554.554 0 0 1-.783 0l-.86-.86v1a.554.554 0 1 1-1.108 0v-1l-.86.86a.554.554 0 0 1-.783-.784l1.805-1.805a.554.554 0 0 1 .784 0L9.197 4.23a.554.554 0 0 1 0 .784zm0 9.947-1.805 1.806a.554.554 0 0 1-.784 0l-1.805-1.806a.554.554 0 0 1 .783-.783l.86.86v-1a.554.554 0 0 1 1.108 0v1l.86-.86a.554.554 0 1 1 .783.783zm-1.05-4.729a.83.83 0 0 1-.416.716 1.326 1.326 0 0 1-.413.173v.266a.317.317 0 0 1-.633 0v-.262a1.449 1.449 0 0 1-.268-.084.943.943 0 0 1-.362-.265.317.317 0 0 1 .479-.415.32.32 0 0 0 .118.092.842.842 0 0 0 .162.052 1.248 1.248 0 0 0 .176.022.765.765 0 0 0 .397-.11c.127-.082.127-.152.127-.185a.218.218 0 0 0-.053-.14.504.504 0 0 0-.132-.106.668.668 0 0 0-.163-.058.765.765 0 0 0-.16-.017 1.642 1.642 0 0 1-.273-.021 1.248 1.248 0 0 1-.352-.114 1.018 1.018 0 0 1-.335-.269.864.864 0 0 1-.198-.542.876.876 0 0 1 .435-.74 1.314 1.314 0 0 1 .402-.165v-.255a.317.317 0 0 1 .633 0v.264a1.513 1.513 0 0 1 .273.095 1.085 1.085 0 0 1 .318.218.317.317 0 0 1-.448.449.454.454 0 0 0-.13-.09.887.887 0 0 0-.167-.058l-.017-.004a.842.842 0 0 0-.137-.023.768.768 0 0 0-.389.104.249.249 0 0 0-.14.205.242.242 0 0 0 .057.143.394.394 0 0 0 .126.101.627.627 0 0 0 .173.056 1.01 1.01 0 0 0 .169.013 1.4 1.4 0 0 1 .295.03 1.305 1.305 0 0 1 .323.117 1.13 1.13 0 0 1 .314.25.848.848 0 0 1 .21.557z" />
				                </svg>
				            </div>
				            <span class="nav-link-text ms-1 text-white" style="font-size:13px;"><%=LanguageHelper.getMessage("transfer", lang)%></span>
				        </a>
				    </li>
				<% } %>
		        
		        <!-- Exchange Converter -->
		        <li class="nav-item">
		          <a class="nav-link active" href="exchange_converter.jsp">
		            <div class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
		              <svg width="12px" height="12px" viewBox="0 0 43 36" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
		                <title>credit-card</title>
		                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
		                  <g transform="translate(-2169.000000, -745.000000)" fill="#FFFFFF" fill-rule="nonzero">
		                    <g transform="translate(1716.000000, 291.000000)">
		                      <g transform="translate(453.000000, 454.000000)">
		                        <path class="color-background opacity-6" d="M43,10.7482083 L43,3.58333333 C43,1.60354167 41.3964583,0 39.4166667,0 L3.58333333,0 C1.60354167,0 0,1.60354167 0,3.58333333 L0,10.7482083 L43,10.7482083 Z"></path>
		                        <path class="color-background" d="M0,16.125 L0,32.25 C0,34.2297917 1.60354167,35.8333333 3.58333333,35.8333333 L39.4166667,35.8333333 C41.3964583,35.8333333 43,34.2297917 43,32.25 L43,16.125 L0,16.125 Z M19.7083333,26.875 L7.16666667,26.875 L7.16666667,23.2916667 L19.7083333,23.2916667 L19.7083333,26.875 Z M35.8333333,26.875 L28.6666667,26.875 L28.6666667,23.2916667 L35.8333333,23.2916667 L35.8333333,26.875 Z"></path>
		                      </g>
		                    </g>
		                  </g>
		                </g>
		              </svg>
		            </div>
		            <span class="nav-link-text ms-1 text-white" style="font-size:13px;"><%=LanguageHelper.getMessage("exchange_rate", lang)%></span>
		          </a>
		        </li>
		        
                <!-- Account Pages  -->
                <li class="nav-item mt-3">
                    <h6 class="ps-4 ms-2 text-uppercase text-xs font-weight-bolder opacity-6 text-white"><%=LanguageHelper.getMessage("acc_setting", lang)%>
                    </h6>
                </li>
                
                <!-- Account setting  -->
                <li class="nav-item">
		          <a class="nav-link" id="hover-link" href="#manageUserDropdown2" data-bs-toggle="collapse" aria-expanded="false">
		            <div class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
		              <svg width="12px" height="12px" viewBox="0 0 46 42" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
		                <title>customer-support</title>
		                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
		                  <g transform="translate(-1717.000000, -291.000000)" fill="#FFFFFF" fill-rule="nonzero">
		                    <g transform="translate(1716.000000, 291.000000)">
		                      <g transform="translate(1.000000, 0.000000)">
		                        <path class="color-background opacity-6" d="M45,0 L26,0 C25.447,0 25,0.447 25,1 L25,20 C25,20.379 25.214,20.725 25.553,20.895 C25.694,20.965 25.848,21 26,21 C26.212,21 26.424,20.933 26.6,20.8 L34.333,15 L45,15 C45.553,15 46,14.553 46,14 L46,1 C46,0.447 45.553,0 45,0 Z"></path>
		                        <path class="color-background" d="M22.883,32.86 C20.761,32.012 17.324,31 13,31 C8.676,31 5.239,32.012 3.116,32.86 C1.224,33.619 0,35.438 0,37.494 L0,41 C0,41.553 0.447,42 1,42 L25,42 C25.553,42 26,41.553 26,41 L26,37.494 C26,35.438 24.776,33.619 22.883,32.86 Z"></path>
		                        <path class="color-background" d="M13,28 C17.432,28 21,22.529 21,18 C21,13.589 17.411,10 13,10 C8.589,10 5,13.589 5,18 C5,22.529 8.568,28 13,28 Z"></path>
		                      </g>
		                    </g>
		                  </g>
		                </g>
		               </svg>
		            </div>
		            <span class="nav-link-text ms-1 text-white" style="font-size:13px;" ><%=LanguageHelper.getMessage("my_acc", lang)%></span>
		          </a>
		          		<ul id="manageUserDropdown2" class="collapse" style="list-style: none;">
		                    <li class="nav-item">
		                    	<a class="nav-link" id="hover-link" href="profile.jsp">
		                        <span class="nav-link-text text-white" style="font-size:13px; padding-left: 35px; margin: 0;"><%=LanguageHelper.getMessage("profile", lang)%></span>
		                        </a>
		                    </li>
		                    <li class="nav-item">
		                    	<a class="nav-link" id="hover-link" href="change_password.jsp">
		                        <span class="nav-link-text text-white" style="font-size:13px; padding-left: 35px; margin: 0;"><%=LanguageHelper.getMessage("change_psw", lang)%></span>
		                        </a>
		                    </li>
		               	</ul>
		        </li>
		        
		        <!-- History  -->
                <li class="nav-item">
		          <a class="nav-link" id="hover-link" href="history.jsp">
		            <div class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
		              <svg width="12px" height="12px" viewBox="0 0 40 44" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
		                <title>document</title>
		                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
		                  <g transform="translate(-1870.000000, -591.000000)" fill="#FFFFFF" fill-rule="nonzero">
		                    <g transform="translate(1716.000000, 291.000000)">
		                      <g transform="translate(154.000000, 300.000000)">
		                        <path class="color-background opacity-6" d="M40,40 L36.3636364,40 L36.3636364,3.63636364 L5.45454545,3.63636364 L5.45454545,0 L38.1818182,0 C39.1854545,0 40,0.814545455 40,1.81818182 L40,40 Z"></path>
		                        <path class="color-background" d="M30.9090909,7.27272727 L1.81818182,7.27272727 C0.814545455,7.27272727 0,8.08727273 0,9.09090909 L0,41.8181818 C0,42.8218182 0.814545455,43.6363636 1.81818182,43.6363636 L30.9090909,43.6363636 C31.9127273,43.6363636 32.7272727,42.8218182 32.7272727,41.8181818 L32.7272727,9.09090909 C32.7272727,8.08727273 31.9127273,7.27272727 30.9090909,7.27272727 Z M18.1818182,34.5454545 L7.27272727,34.5454545 L7.27272727,30.9090909 L18.1818182,30.9090909 L18.1818182,34.5454545 Z M25.4545455,27.2727273 L7.27272727,27.2727273 L7.27272727,23.6363636 L25.4545455,23.6363636 L25.4545455,27.2727273 Z M25.4545455,20 L7.27272727,20 L7.27272727,16.3636364 L25.4545455,16.3636364 L25.4545455,20 Z"></path>
		                      </g>
		                    </g>
		                  </g>
		                </g>
		              </svg>
		            </div>
		            <span class="nav-link-text ms-1 text-white" style="font-size:13px;"><%=LanguageHelper.getMessage("history", lang)%></span>
		          </a>
		        </li>
                
                <!-- Sign out  -->
                <li class="nav-item">
		          <a class="nav-link " id="hover-link" href="logout.jsp">
		            <div class="icon icon-shape icon-sm shadow border-radius-md text-center me-2 d-flex align-items-center justify-content-center bg-purple">
		              <svg width="12px" height="12px" viewBox="0 0 512 512" version="1.1"
                                xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                <title>Sign Out</title>
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <g fill="#FFFFFF" fill-rule="nonzero">
                                        <!-- Door -->
                                        <path class="color-background opacity-6"
                                            d="M320,480 L320,32 C320,14.3 334.3,0 352,0 L448,0 C465.7,0 480,14.3 480,32 L480,480 C480,497.7 465.7,512 448,512 L352,512 C334.3,512 320,497.7 320,480 Z">
                                        </path>
                                        <!-- Arrow -->
                                        <path class="color-background"
                                            d="M169.4,142.1 C162.9,148.6 162.9,159.4 169.4,165.9 L238.1,234.6 L24,234.6 C10.7,234.6 0,245.3 0,258.6 C0,271.9 10.7,282.6 24,282.6 L238.1,282.6 L169.4,351.3 C162.9,357.8 162.9,368.6 169.4,375.1 C175.9,381.6 186.7,381.6 193.2,375.1 L285.2,283.1 C291.7,276.6 291.7,265.8 285.2,259.3 L193.2,167.3 C186.7,160.8 175.9,160.8 169.4,142.1 Z">
                                        </path>
                                    </g>
                                </g>
                       </svg>
		            </div>
		            <span class="nav-link-text ms-1 text-white" style="font-size:13px;"><%=LanguageHelper.getMessage("sign_out", lang)%></span>
		          </a>
		        </li>
                
            </ul>
        </div>
        </div>
    </aside>
    <div class="main-content position-relative max-height-vh-100 h-100">
        <!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl"
			id="navbarBlur" navbar-scroll="true">
			<div class="container-fluid py-1 px-3">
				<nav aria-label="breadcrumb" style="padding-top:0px;">
                    <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 ps-2 me-sm-6 me-5">
                        <li class="breadcrumb-item text-sm"><a class="text-white opacity-5"
                                href="javascript:;"><%=LanguageHelper.getMessage("pages", lang)%></a></li>
                        <li class="breadcrumb-item text-sm text-white active" aria-current="page"><%=LanguageHelper.getMessage("exchange_rate", lang)%></li>
                    </ol>
                    <h6 class="text-white font-weight-bolder ms-2"><%= fullname %></h6> 
                    <p class="ms-2 mb-0 text-white font-weight-bolder">
					    <%=LanguageHelper.getMessage("balance", lang)%>: <span id="balance" style="">******</span>
					    <i id="toggleBalance" class="fa fa-eye-slash ms-1" style="font-size:10px; cursor: pointer;"></i>
					</p>
        
           		</nav>
				<div class="collapse navbar-collapse me-md-0 me-sm-4 mt-sm-0 mt-2" id="navbar">
                    <div class="ms-md-auto pe-md-3 d-flex align-items-center"> </div>
                    
                    <ul class="navbar-nav  justify-content-end">
						<li class="nav-item d-flex align-items-center"><a
							href="logout.jsp" id="hover-link"
							class="nav-link text-white font-weight-bold px-0"> <i
								class="fa fa-user me-sm-1"></i> <span
								class="d-sm-inline d-none text-white" style="font-size: 13px;"><%= LanguageHelper.getMessage("sign_out", lang) %></span>
						</a></li>
					</ul>
                    
			</div>
		</nav>
		<!-- End Navbar -->
        
        <div class="container-fluid py-4" style="margin-top:-20px;">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card my-4 bg-glass3">
                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
                            <div class="bg-purple shadow-primary border-radius-lg pt-4 pb-3">
                                <h6 class="text-white text-center text-capitalize ps-3"><%=LanguageHelper.getMessage("exchange_rate", lang)%></h6>
                            </div>
                        </div>
                        <div class="card-body px-4 pb-2">
                            <form action="currencyExchange" method="post">	
                                <div class="mb-3">
                                    <label for="amount" class="form-label text-white"><%=LanguageHelper.getMessage("amt", lang)%></label>
                                    <div class="input-group input-group-outline">
                                        <input type="number" class="form-control transparent-input" id="amount" name="amount"
                                            placeholder="<%=LanguageHelper.getMessage("enter_amt", lang)%>" step="0.01" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="from" class="form-label text-white"><%=LanguageHelper.getMessage("from_currency", lang)%></label>
                                    <div class="input-group input-group-outline">
                                        <select id="from" name="from" class="form-control" required>
								         	<option value="" disabled selected ><%=LanguageHelper.getMessage("select", lang)%></option>
											<option value="AED">AED UAE Dirham</option>
											<option value="AFN">AFN Afghan Afghani</option>
											<option value="ALL">ALL Albanian Lek</option>
											<option value="AMD">AMD Armenian Dram</option>
											<option value="ANG">ANG Netherlands Antillian Guilder</option>
											<option value="AOA">AOA Angolan Kwanza</option>
											<option value="ARS">ARS Argentine Peso</option>
											<option value="AUD">AUD Australian Dollar</option>
											<option value="AWG">AWG Aruban Florin</option>
											<option value="AZN">AZN Azerbaijani Manat</option>
											<option value="BAM">BAM Bosnia and Herzegovina Mark</option>
											<option value="BBN">BBD Barbados Dollar</option>
											<option value="BDT">BDT Bangladeshi Taka</option>
											<option value="BGN">BGN Bulgarian Lev</option>
											<option value="BHD">BHD Bahraini Dinar</option>
											<option value="BIF">BIF Burundian Franc</option>
											<option value="BMD">BMD Bermudian Dollar</option>
											<option value="BND">BND Brunei Dollar</option>
											<option value="BOB">BOB Bolivian Boliviano</option>
											<option value="BRL">BRL Brazilian Real</option>
											<option value="BSD">BSD Bahamian Dollar</option>
											<option value="BTN">BTN Bhutanese Ngultrum</option>
											<option value="BWP">BWP Botswana Pula</option>
											<option value="BYN">BYN Belarusian Ruble</option>
											<option value="BZD">BZD Belize Dollar</option>
											<option value="CAD">CAD Canadian Dollar</option>
											<option value="CDF">CDF Congolese Franc</option>
											<option value="CHF">CHF Swiss Franc</option>
											<option value="CLP">CLP Chilean Peso</option>
											<option value="CNY">CNY Chinese Renminbi</option>
											<option value="COP">COP Colombian Peso</option>
											<option value="CRC">CRC Costa Rican Colon</option>
											<option value="CUP">CUP Cuban Peso</option>
											<option value="CVE">CVE Cape Verdean Escudo</option>
											<option value="CZK">CZK Czech Koruna</option>
											<option value="DJF">DJF Djiboutian Franc</option>
											<option value="DKK">DKK Danish Krone</option>
											<option value="DOP">DOP Dominican Peso</option>
											<option value="DZD">DZD Algerian Dinar</option>
											<option value="EGP">EGP Egyptian Pound</option>
											<option value="ERN">ERN Eritrean Nakfa</option>
											<option value="ETB">ETB Ethiopian Birr</option>
											<option value="EUR">EUR Euro</option>
											<option value="FJD">FJD Fiji Dollar</option>
											<option value="FKP">FKP Falkland Islands Pound</option>
											<option value="FOK">FOK Faroese Króna</option>
											<option value="GBP">GBP Pound Sterling</option>
											<option value="GEL">GEL Georgian Lari</option>
											<option value="GGP">GGP Guernsey Pound</option>
											<option value="GHS">GHS Ghanaian Cedi</option>
											<option value="GIP">GIP Gibraltar Pound</option>
											<option value="GMD">GMD Gambian Dalasi</option>
											<option value="GNF">GNF Guinean Franc</option>
											<option value="GTQ">GTQ Guatemalan Quetzal</option>
											<option value="GYD">GYD Guyanese Dollar</option>
											<option value="HKD">HKD Hong Kong Dollar</option>
											<option value="HNL">HNL Honduran Lempira</option>
											<option value="HRK">HRK Croatian Kuna</option>
											<option value="HTG">HTG Haitian Gourde</option>
											<option value="HUF">HUF Hungarian Forint</option>
											<option value="IDR">IDR Indonesian Rupiah</option>
											<option value="ILS">ILS Israeli New Shekel</option>
											<option value="IMP">IMP Manx Pound</option>
											<option value="INR">INR Indian Rupee</option>
											<option value="IQD">IQD Iraqi Dinar</option>
											<option value="IRR">IRR Iranian Rial</option>
											<option value="ISK">ISK Icelandic Krona</option>
											<option value="JEP">JEP Jersey Pound</option>
											<option value="JMD">JMD Jamaican Dollar</option>
											<option value="JOD">JOD Jordanian Dinar</option>
											<option value="JPY">JPY Japanese Yen</option>
											<option value="KES">KES Kenyan Shilling</option>
											<option value="KGS">KGS Kyrgyzstani Som</option>
											<option value="KHR">KHR Cambodian Riel</option>
											<option value="KID">KID Kiribati Dollar</option>
											<option value="KMF">KMF Comorian Franc</option>
											<option value="KRW">KRW South Korean Won</option>
											<option value="KWD">KWD Kuwaiti Dinar</option>
											<option value="KYD">KYD Cayman Islands Dollar</option>
											<option value="KZT">KZT Kazakhstani Tenge</option>
											<option value="LAK">LAK Lao Kip</option>
											<option value="LBP">LBP Lebanese Pound</option>
											<option value="LKR">LKR Sri Lanka Rupee</option>
											<option value="LRD">LRD Liberian Dollar</option>
											<option value="LSL">LSL Lesotho Loti</option>
											<option value="LYD">LYD Libyan Dinar</option>
											<option value="MAD">MAD Moroccan Dirham</option>
											<option value="MDL">MDL Moldovan Leu</option>
											<option value="MGA">MGA Malagasy Ariary</option>
											<option value="MKD">MKD Macedonian Denar</option>
											<option value="MMK">MMK Burmese Kyat</option>
											<option value="MNT">MNT Mongolian Tugrik</option>
											<option value="MOP">MOP Macanese Pataca</option>
											<option value="MRU">MRU Mauritanian Ouguiya</option>
											<option value="MUR">MUR Mauritian Rupee</option>
											<option value="MVR">MVR Maldivian Rufiyaa</option>
											<option value="MWK">MWK Malawian Kwacha</option>
											<option value="MXN">MXN Mexican Peso</option>
											<option value="MYR">MYR Malaysian Ringgit</option>
											<option value="MZN">MZN Mozambican Metical</option>
											<option value="NAD">NAD Namibian Dollar</option>
											<option value="NGN">NGN Nigerian Naira</option>
											<option value="NIO">NIO Nicaraguan Cordoba</option>
											<option value="NOK">NOK Norwegian Krone</option>
											<option value="NPR">NPR Nepalese Rupee</option>
											<option value="NZD">NZD New Zealand Dollar</option>
											<option value="OMR">OMR Omani Rial</option>
											<option value="PAB">PAB Panamanian Balboa</option>
											<option value="PEN">PEN Peruvian Sol</option>
											<option value="PGK">PGK Papua New Guinean Kina</option>
											<option value="PHP">PHP Philippine Peso</option>
											<option value="PKR">PKR Pakistani Rupee</option>
											<option value="PLN">PLN Polish Zloty</option>
											<option value="PYG">PYG Paraguayan Guarani</option>
											<option value="QAR">QAR Qatari Riyal</option>
											<option value="RON">RON Romanian Leu</option>
											<option value="RSD">RSD Serbian Dinar</option>
											<option value="RUB">RUB Russian Ruble</option>
											<option value="RWF">RWF Rwandan Franc</option>
											<option value="SAR">SAR Saudi Riyal</option>
											<option value="SBD">SBD Solomon Islands Dollar</option>
											<option value="SCR">SCR Seychellois Rupee</option>
											<option value="SDG">SDG Sudanese Pound</option>
											<option value="SEK">SEK Swedish Krona</option>
											<option value="SGD">SGD Singapore Dollar</option>
											<option value="SHP">SHP Saint Helena Pound</option>
											<option value="SLE">SLE Sierra Leonean Leone</option>
											<option value="SOS">SOS Somali Shilling</option>
											<option value="SRD">SRD Surinamese Dollar</option>
											<option value="SSP">SSP South Sudanese Pound</option>
											<option value="STN">STN Sao Tome and Principe Dobra</option>
											<option value="SYP">SYP Syrian Pound</option>
											<option value="SZL">SZL Eswatini Lilangeni</option>
											<option value="THB">THB Thai Baht</option>
											<option value="TJS">TJS Tajikistani Somoni</option>
											<option value="TMT">TMT Turkmenistan Manat</option>
											<option value="TND">TND Tunisian Dinar</option>
											<option value="TOP">TOP Tongan Pa'anga</option>
											<option value="TRY">TRY Turkish Lira</option>
											<option value="TTD">TTD Trinidad and Tobago Dollar</option>
											<option value="TVD">TVD Tuvaluan Dollar</option>
											<option value="TWD">TWD New Taiwan Dollar</option>
											<option value="TZS">TZS Tanzanian Shilling</option>
											<option value="UAH">UAH Ukrainian Hryvnia</option>
											<option value="UGX">UGX Ugandan Shilling</option>
											<option value="USD">USD United States Dollar</option>
											<option value="UYU">UYU Uruguayan Peso</option>
											<option value="UZS">UZS Uzbekistani So'm</option>
											<option value="VES">VES Venezuelan Bolívar Soberano</option>
											<option value="VND">VND Vietnamese Dong</option>
											<option value="VUV">VUV Vanuatu Vatu</option>
											<option value="WST">WST Samoan Tala</option>
											<option value="XAF">XAF Central African CFA Franc</option>
											<option value="XCD">XCD East Caribbean Dollar</option>
											<option value="XDR">XDR Special Drawing Rights</option>
											<option value="XOF">XOF West African CFA franc</option>
											<option value="XPF">XPF CFP Franc</option>
											<option value="YER">YER Yemeni Rial</option>
											<option value="ZAR">ZAR South African Rand</option>
											<option value="ZMW">ZMW Zambian Kwacha</option>
											<option value="ZWL">ZWL Zimbabwean Dollar</option>
								        </select>
    								</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="to" class="form-label text-white"><%=LanguageHelper.getMessage("to_currency", lang)%></label>
                                    <div class="input-group input-group-outline">
                                        <select id="to" name="to" class="form-control text-black" required>
								         	<option value="" disabled selected style="color:black !important"><%=LanguageHelper.getMessage("select", lang)%></option>
											<option value="AED">AED UAE Dirham</option>
											<option value="AFN">AFN Afghan Afghani</option>
											<option value="ALL">ALL Albanian Lek</option>
											<option value="AMD">AMD Armenian Dram</option>
											<option value="ANG">ANG Netherlands Antillian Guilder</option>
											<option value="AOA">AOA Angolan Kwanza</option>
											<option value="ARS">ARS Argentine Peso</option>
											<option value="AUD">AUD Australian Dollar</option>
											<option value="AWG">AWG Aruban Florin</option>
											<option value="AZN">AZN Azerbaijani Manat</option>
											<option value="BAM">BAM Bosnia and Herzegovina Mark</option>
											<option value="BBN">BBD Barbados Dollar</option>
											<option value="BDT">BDT Bangladeshi Taka</option>
											<option value="BGN">BGN Bulgarian Lev</option>
											<option value="BHD">BHD Bahraini Dinar</option>
											<option value="BIF">BIF Burundian Franc</option>
											<option value="BMD">BMD Bermudian Dollar</option>
											<option value="BND">BND Brunei Dollar</option>
											<option value="BOB">BOB Bolivian Boliviano</option>
											<option value="BRL">BRL Brazilian Real</option>
											<option value="BSD">BSD Bahamian Dollar</option>
											<option value="BTN">BTN Bhutanese Ngultrum</option>
											<option value="BWP">BWP Botswana Pula</option>
											<option value="BYN">BYN Belarusian Ruble</option>
											<option value="BZD">BZD Belize Dollar</option>
											<option value="CAD">CAD Canadian Dollar</option>
											<option value="CDF">CDF Congolese Franc</option>
											<option value="CHF">CHF Swiss Franc</option>
											<option value="CLP">CLP Chilean Peso</option>
											<option value="CNY">CNY Chinese Renminbi</option>
											<option value="COP">COP Colombian Peso</option>
											<option value="CRC">CRC Costa Rican Colon</option>
											<option value="CUP">CUP Cuban Peso</option>
											<option value="CVE">CVE Cape Verdean Escudo</option>
											<option value="CZK">CZK Czech Koruna</option>
											<option value="DJF">DJF Djiboutian Franc</option>
											<option value="DKK">DKK Danish Krone</option>
											<option value="DOP">DOP Dominican Peso</option>
											<option value="DZD">DZD Algerian Dinar</option>
											<option value="EGP">EGP Egyptian Pound</option>
											<option value="ERN">ERN Eritrean Nakfa</option>
											<option value="ETB">ETB Ethiopian Birr</option>
											<option value="EUR">EUR Euro</option>
											<option value="FJD">FJD Fiji Dollar</option>
											<option value="FKP">FKP Falkland Islands Pound</option>
											<option value="FOK">FOK Faroese Króna</option>
											<option value="GBP">GBP Pound Sterling</option>
											<option value="GEL">GEL Georgian Lari</option>
											<option value="GGP">GGP Guernsey Pound</option>
											<option value="GHS">GHS Ghanaian Cedi</option>
											<option value="GIP">GIP Gibraltar Pound</option>
											<option value="GMD">GMD Gambian Dalasi</option>
											<option value="GNF">GNF Guinean Franc</option>
											<option value="GTQ">GTQ Guatemalan Quetzal</option>
											<option value="GYD">GYD Guyanese Dollar</option>
											<option value="HKD">HKD Hong Kong Dollar</option>
											<option value="HNL">HNL Honduran Lempira</option>
											<option value="HRK">HRK Croatian Kuna</option>
											<option value="HTG">HTG Haitian Gourde</option>
											<option value="HUF">HUF Hungarian Forint</option>
											<option value="IDR">IDR Indonesian Rupiah</option>
											<option value="ILS">ILS Israeli New Shekel</option>
											<option value="IMP">IMP Manx Pound</option>
											<option value="INR">INR Indian Rupee</option>
											<option value="IQD">IQD Iraqi Dinar</option>
											<option value="IRR">IRR Iranian Rial</option>
											<option value="ISK">ISK Icelandic Krona</option>
											<option value="JEP">JEP Jersey Pound</option>
											<option value="JMD">JMD Jamaican Dollar</option>
											<option value="JOD">JOD Jordanian Dinar</option>
											<option value="JPY">JPY Japanese Yen</option>
											<option value="KES">KES Kenyan Shilling</option>
											<option value="KGS">KGS Kyrgyzstani Som</option>
											<option value="KHR">KHR Cambodian Riel</option>
											<option value="KID">KID Kiribati Dollar</option>
											<option value="KMF">KMF Comorian Franc</option>
											<option value="KRW">KRW South Korean Won</option>
											<option value="KWD">KWD Kuwaiti Dinar</option>
											<option value="KYD">KYD Cayman Islands Dollar</option>
											<option value="KZT">KZT Kazakhstani Tenge</option>
											<option value="LAK">LAK Lao Kip</option>
											<option value="LBP">LBP Lebanese Pound</option>
											<option value="LKR">LKR Sri Lanka Rupee</option>
											<option value="LRD">LRD Liberian Dollar</option>
											<option value="LSL">LSL Lesotho Loti</option>
											<option value="LYD">LYD Libyan Dinar</option>
											<option value="MAD">MAD Moroccan Dirham</option>
											<option value="MDL">MDL Moldovan Leu</option>
											<option value="MGA">MGA Malagasy Ariary</option>
											<option value="MKD">MKD Macedonian Denar</option>
											<option value="MMK">MMK Burmese Kyat</option>
											<option value="MNT">MNT Mongolian Tugrik</option>
											<option value="MOP">MOP Macanese Pataca</option>
											<option value="MRU">MRU Mauritanian Ouguiya</option>
											<option value="MUR">MUR Mauritian Rupee</option>
											<option value="MVR">MVR Maldivian Rufiyaa</option>
											<option value="MWK">MWK Malawian Kwacha</option>
											<option value="MXN">MXN Mexican Peso</option>
											<option value="MYR">MYR Malaysian Ringgit</option>
											<option value="MZN">MZN Mozambican Metical</option>
											<option value="NAD">NAD Namibian Dollar</option>
											<option value="NGN">NGN Nigerian Naira</option>
											<option value="NIO">NIO Nicaraguan Cordoba</option>
											<option value="NOK">NOK Norwegian Krone</option>
											<option value="NPR">NPR Nepalese Rupee</option>
											<option value="NZD">NZD New Zealand Dollar</option>
											<option value="OMR">OMR Omani Rial</option>
											<option value="PAB">PAB Panamanian Balboa</option>
											<option value="PEN">PEN Peruvian Sol</option>
											<option value="PGK">PGK Papua New Guinean Kina</option>
											<option value="PHP">PHP Philippine Peso</option>
											<option value="PKR">PKR Pakistani Rupee</option>
											<option value="PLN">PLN Polish Zloty</option>
											<option value="PYG">PYG Paraguayan Guarani</option>
											<option value="QAR">QAR Qatari Riyal</option>
											<option value="RON">RON Romanian Leu</option>
											<option value="RSD">RSD Serbian Dinar</option>
											<option value="RUB">RUB Russian Ruble</option>
											<option value="RWF">RWF Rwandan Franc</option>
											<option value="SAR">SAR Saudi Riyal</option>
											<option value="SBD">SBD Solomon Islands Dollar</option>
											<option value="SCR">SCR Seychellois Rupee</option>
											<option value="SDG">SDG Sudanese Pound</option>
											<option value="SEK">SEK Swedish Krona</option>
											<option value="SGD">SGD Singapore Dollar</option>
											<option value="SHP">SHP Saint Helena Pound</option>
											<option value="SLE">SLE Sierra Leonean Leone</option>
											<option value="SOS">SOS Somali Shilling</option>
											<option value="SRD">SRD Surinamese Dollar</option>
											<option value="SSP">SSP South Sudanese Pound</option>
											<option value="STN">STN Sao Tome and Principe Dobra</option>
											<option value="SYP">SYP Syrian Pound</option>
											<option value="SZL">SZL Eswatini Lilangeni</option>
											<option value="THB">THB Thai Baht</option>
											<option value="TJS">TJS Tajikistani Somoni</option>
											<option value="TMT">TMT Turkmenistan Manat</option>
											<option value="TND">TND Tunisian Dinar</option>
											<option value="TOP">TOP Tongan Pa'anga</option>
											<option value="TRY">TRY Turkish Lira</option>
											<option value="TTD">TTD Trinidad and Tobago Dollar</option>
											<option value="TVD">TVD Tuvaluan Dollar</option>
											<option value="TWD">TWD New Taiwan Dollar</option>
											<option value="TZS">TZS Tanzanian Shilling</option>
											<option value="UAH">UAH Ukrainian Hryvnia</option>
											<option value="UGX">UGX Ugandan Shilling</option>
											<option value="USD">USD United States Dollar</option>
											<option value="UYU">UYU Uruguayan Peso</option>
											<option value="UZS">UZS Uzbekistani So'm</option>
											<option value="VES">VES Venezuelan Bolívar Soberano</option>
											<option value="VND">VND Vietnamese Dong</option>
											<option value="VUV">VUV Vanuatu Vatu</option>
											<option value="WST">WST Samoan Tala</option>
											<option value="XAF">XAF Central African CFA Franc</option>
											<option value="XCD">XCD East Caribbean Dollar</option>
											<option value="XDR">XDR Special Drawing Rights</option>
											<option value="XOF">XOF West African CFA franc</option>
											<option value="XPF">XPF CFP Franc</option>
											<option value="YER">YER Yemeni Rial</option>
											<option value="ZAR">ZAR South African Rand</option>
											<option value="ZMW">ZMW Zambian Kwacha</option>
											<option value="ZWL">ZWL Zimbabwean Dollar</option>
								        </select>
    								</div>
                                </div>
                            	
                                
                                <div class="text-center">
                                    <button type="submit"
                                        class="btn btn-lg bg-purple btn-lg w-100 mt-4 mb-0 text-white" id="confirmButton">
                                        <%=LanguageHelper.getMessage("convert", lang)%>
                                    </button>
                                </div>
                            </form>                     
                        </div>                      
                    </div>
                    
                    <% if (request.getAttribute("error") != null) { %>
			             <div class="alert alert-danger">
			                 <%= request.getAttribute("error") %>
			             </div>
			         <% } %>
                    <% if (request.getAttribute("convertedAmount") != null) { %>
	                    <div class="container mt-5">
							<div class="card">
								<div class="card-body">
							
									<%=request.getAttribute("originalAmount") != null ? request.getAttribute("originalAmount") : "No Amount Set"%>
									<%=request.getAttribute("fromCurrency") != null ? request.getAttribute("fromCurrency") : "No Currency Set"%>
									=
									<%=request.getAttribute("convertedAmount") != null ? request.getAttribute("convertedAmount") : "No Amount Set"%>
									<%=request.getAttribute("toCurrency") != null ? request.getAttribute("toCurrency") : "No Currency Set"%>
								</div>
							</div>
						</div>
					<% } %>
                                        
                </div>
            </div>            
        </div>
        
    <!-- Account Frozen Modal -->
	<div class="modal fade" id="frozenModal" tabindex="-1" aria-labelledby="frozenModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="frozenModalLabel"><%=LanguageHelper.getMessage("frozen", lang)%></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <%=LanguageHelper.getMessage("frozen_msg", lang)%>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
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
    document.getElementById("toggleBalance").addEventListener("click", function () {
        var balanceElement = document.getElementById("balance");
        if (balanceElement.innerText === "******") {
            balanceElement.innerText = "<%=balance%>"; // Show balance
            this.classList.remove("fa-eye-slash");
            this.classList.add("fa-eye");
        } else {
            balanceElement.innerText = "******"; // Hide balance
            this.classList.remove("fa-eye");
            this.classList.add("fa-eye-slash");
        }
	    });
	</script>
	
        <script>
            var win = navigator.platform.indexOf('Win') > -1;
            if (win && document.querySelector('#sidenav-scrollbar')) {
                var options = {
                    damping: '0.5'
                }
                Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
            }
        </script>
        <!-- Github buttons -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
    <script src="js/soft-ui-dashboard.min.js?v=1.1.0"></script>

	<%
    Boolean isAccountFrozen = (Boolean) session.getAttribute("accountFrozen");
    boolean frozenStatus = (isAccountFrozen != null && isAccountFrozen);
	%>
	

	<script>
	    document.addEventListener("DOMContentLoaded", function() {
	        var socket = new WebSocket("ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/freezeStatus?userId=<%= userId %>");
	
	        socket.onopen = function() {
	            console.log("WebSocket connected for user <%= userId %>");
	        };
	
	        socket.onmessage = function(event) {
	            console.log("Received status update:", event.data);
	            handleFreezeStatus(event.data);
	        };
	
	        socket.onerror = function(error) {
	            console.error("WebSocket error:", error);
	        };
	
	        socket.onclose = function() {
	            console.log("WebSocket connection closed");
	        };
	
	        function handleFreezeStatus(status) {
	            var freezeModal = new bootstrap.Modal(document.getElementById('frozenModal'));
	            var allowedLinks = ["homepage.jsp", "index.jsp", "history.jsp", "rating.jsp", "exchange_converter.jsp", "profile.jsp", "logout.jsp"];

	            // Update server-side session via AJAX
	            fetch("${pageContext.request.contextPath}/updateFreezeStatus", {
	                method: "POST",
	                headers: {
	                    "Content-Type": "application/json"
	                },
	                body: JSON.stringify({ status: status })
	            })
	            .then(response => {
	                if (status === "frozen") {
	                    freezeModal.show();
	                    document.querySelectorAll("a:not([data-bs-toggle='collapse'])").forEach(link => {
	                        if (!allowedLinks.includes(link.getAttribute("href"))) {
	                            link.style.pointerEvents = "none";
	                            link.style.opacity = "0.4";
	                            link.setAttribute("data-original-href", link.href);
	                            link.removeAttribute("href");
	                        }
	                    });
	                } else {
	                    freezeModal.hide();
	                    document.querySelectorAll("a").forEach(link => {
	                        link.style.pointerEvents = "auto";
	                        link.style.opacity = "1";
	                        const originalHref = link.getAttribute("data-original-href");
	                        if (originalHref) {
	                            link.href = originalHref;
	                        }
	                    });
	                }
	            })
	            .catch(error => console.error("Error updating status:", error));
	        }

	        var isFrozen = <%= frozenStatus %>;
	        if (isFrozen) {
	            handleFreezeStatus("frozen");
	        }
	    });
	</script>
	

</body>

</html>