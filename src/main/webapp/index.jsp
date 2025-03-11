<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bank.LanguageHelper"%>
<%
String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
%>
<meta charset="UTF-8">
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="apple-touch-icon" sizes="76x76" href="img/logo.png">
<link rel="icon" type="image/png" href="img/logo.png">
<title><%=LanguageHelper.getMessage("title", lang)%></title>
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700,800"
	rel="stylesheet" />
<!-- Nucleo Icons -->
<link
	href="https://demos.creative-tim.com/soft-ui-dashboardcss/nucleo-icons.css"
	rel="stylesheet" />
<link
	href="https://demos.creative-tim.com/soft-ui-dashboardcss/nucleo-svg.css"
	rel="stylesheet" />
<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js"
	crossorigin="anonymous"></script>
<!-- Bootstrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<!-- CSS Files -->
<link id="pagestyle" href="css_update2/soft-ui-dashboard.css?v=1.1.0"
	rel="stylesheet" />
<!-- Nepcha Analytics (nepcha.com) -->
<!-- Nepcha is a easy-to-use web analytics. No cookies and fully compliant with GDPR, CCPA and PECR. -->
<script defer data-site="YOUR_DOMAIN_HERE"
	src="https://api.nepcha.com/js/nepcha-analytics.js"></script>

<!--  Bootstrap css file  -->
<link rel="stylesheet" href="css_update2/bootstrap.min.css">

<!--  font awesome icons  -->
<link rel="stylesheet" href="css_update2/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!--  Magnific Popup css file  -->

<link rel="stylesheet"
	href="js-update/vendor/Magnific-Popup/dist/magnific-popup.css">
<link id="pagestyle" href="css_update/soft-ui-dashboard.css"
	rel="stylesheet">

<!--  Owl-carousel css file  -->
<link rel="stylesheet"
	href="js-update/vendor/owl-carousel/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="js-update/vendor/owl-carousel/css/owl.theme.default.min.css">

<!--  custom css file  -->
<link rel="stylesheet" href="css_update2/style.css">

<!--  Responsive css file  -->
<link rel="stylesheet" href="css_update2/responsive.css">

</head>

<style>
body {
	overflow-x: hidden;
}

.leaf {
	position: absolute;
	margin-left: 8px;
	width: 20px; /* Adjust size as needed */
	height: 25px; /* Adjust size as needed */
	background-image: url('img/leaf.png'); /* Ensure the path is correct */
	background-size: cover;
	z-index: 10; /* Make sure it's above other elements */
	animation: scatter 3s ease-in-out forwards;
	opacity: 0;
}

@
keyframes scatter { 0% {
	opacity: 0.5;
	transform: translate(0, 0) rotate(0deg);
}

100


%
{
transform


:


translate
(


var
(


--x


)
,
var
(


--y


)


)


rotate
(


var
(


--r


)


)
;


opacity


:


0
;


}
}
.bg-glass {
	position: relative;
	background: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
	backdrop-filter: blur(10px);
	-webkit-backdrop-filter: blur(10px);
	color: white;
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.10);
	overflow: hidden; /* Ensures pseudo-element stays inside */
}

/* Gradient Layer for Glass Effect */
.bg-glass::before {
	content: "";
	position: absolute;
	inset: 0;
	background: linear-gradient(135deg, #0a0024, #9454f1);
	border-radius: inherit;
	z-index: -1;
	opacity: 0.8;
	color: white;
}

/* Navbar Glass Effect */
.blur {
	backdrop-filter: blur(10px);
	-webkit-backdrop-filter: blur(10px);
	background: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
}

.bg-glass:hover {
	background: linear-gradient(135deg, #9454f1, #ffffff);
	/* Reverse gradient effect */
	background-clip: padding-box;
	color: rgb(255, 255, 255);
	box-shadow: 5px 5px 20px 5px rgba(148, 84, 241, 0.6);
	/* More intense glow */
	transition: all 0.3s ease-in-out;
}

#hover-link:hover {
	background: none;
	background-image: linear-gradient(135deg, #ffffff, #9454f1, #9454f1);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

/* Ensure both icon and text change color on hover */
.gradient-hover:hover, .hover-link:hover .nav-link, .hover-link:hover .nav-link i
	{
	background: linear-gradient(135deg, #ffffff, #9454f1, #9454f1);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	transition: background 0.3s ease-in-out;
}

.hover-text {
	background: none;
	background-image: linear-gradient(135deg, #ffffff, #9454f1);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.nav-nav {
	margin-right: 100px !important;
	margin-left: 100px !important;
}

.navbar .container div img {
	height: 35px; /* Adjust as needed */
	width: auto;
	margin-right: 10px; /* Space between logo and text */
	vertical-align: middle;
}

.logo {
	position: relative;
	z-index: 20; /* Ensures the logo stays above the leaves */
}
</style>

<%@ page import="java.util.Properties"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page
	import="java.util.Properties, javax.mail.*, javax.mail.internet.*"%>
<%
String msg = "";

if (request.getMethod().equalsIgnoreCase("POST")) {
	// Retrieve form data
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String subject = request.getParameter("subject");
	String message = request.getParameter("message");

	if (name != null && email != null && subject != null && message != null) {
		try {
	// SMTP server settings
	String host = "smtp.gmail.com";
	String port = "587"; // For TLS
	final String username = "hninshweyiwint2022@gmail.com"; // Replace with your email
	final String password = "givw ovku mvla yjqe"; // Replace with your app-specific password

	// Properties for JavaMail
	Properties props = new Properties();
	props.put("mail.smtp.host", host);
	props.put("mail.smtp.port", port);
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.starttls.enable", "true");

	// Authenticate using a session
	Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(username, password);
		}
	});

	// Construct the email
	Message mimeMessage = new MimeMessage(mailSession);
	mimeMessage.setFrom(new InternetAddress(email));
	mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse("hninshweyiwint2022@gmail.com")); // Replace with your receiving email
	mimeMessage.setSubject(subject);
	mimeMessage.setText("Name: " + name + "\nEmail: " + email + "\n\nMessage:\n" + message);

	// Send the email
	Transport.send(mimeMessage);

	msg = "<div class='alert alert-success'>Your message has been sent successfully.</div>";
		} catch (Exception e) {
	msg = "<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>";
	e.printStackTrace();
		}
	} else {
		msg = "<div class='alert alert-warning'>All fields are required.</div>";
	}
}
%>

<body>

	<!--  ======================= Start Header Area ============================== -->
	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3 navbar-transparent mt-4">
		<div class="container">
			<div class="">
				<img src="img/logo.png" alt="" class="logo">
			</div>

			<div class="leaf" id="leaf1"></div>
			<div class="leaf" id="leaf2"></div>
			<div class="leaf" id="leaf3"></div>
			<div class="leaf" id="leaf4"></div>
			<div class="leaf" id="leaf5"></div>
			<div class="leaf" id="leaf6"></div>
			<div class="leaf" id="leaf7"></div>
			<div class="leaf" id="leaf8"></div>
			<div class="leaf" id="leaf9"></div>
			<div class="leaf" id="leaf10"></div>
			<div class="leaf" id="leaf11"></div>
			<div class="leaf" id="leaf12"></div>

			<a class="navbar-brand font-weight-bolder ms-lg-0 ms-3 text-white "
				href="index.jsp" target="_blank"> <span
				class="ms-1 font-weight-bold"><%=LanguageHelper.getMessage("title", lang)%></span>
			</a>

			<button class="navbar-toggler shadow-none ms-2" type="button"
				data-bs-toggle="collapse" data-bs-target="#navigation"
				aria-controls="navigation" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon mt-2"> <span
					class="navbar-toggler-bar bar1"></span> <span
					class="navbar-toggler-bar bar2"></span> <span
					class="navbar-toggler-bar bar3"></span>
				</span>
			</button>
			<div class="collapse navbar-collapse" id="navigation"
				style="background: #;">
				<ul class="navbar-nav mx-auto ms-xl-auto me-xl-5">
					<li class="nav-item dropdown hover-link"><a
						class="nav-link d-flex align-items-center me-2 active dropdown-toggle"
						id="bankingDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> <i class="fas fa-landmark  me-1"></i>
							<%=LanguageHelper.getMessage("service", lang)%>

					</a>

						<ul class="dropdown-menu" aria-labelledby="bankingDropdown">
							<a class="dropdown-header" href="#service"><%=LanguageHelper.getMessage("service_offers", lang)%></a>
							<li><a class="dropdown-item" href="deposit.jsp"><%=LanguageHelper.getMessage("deposit", lang)%></a></li>
							<li><a class="dropdown-item" href="withdraw.jsp"><%=LanguageHelper.getMessage("withdraw", lang)%></a></li>
							<li><a class="dropdown-item" href="transfer.jsp"><%=LanguageHelper.getMessage("transfer", lang)%></a></li>
							<li><a class="dropdown-item" href="exchange_converter.jsp"><%=LanguageHelper.getMessage("exchange_rate", lang)%></a></li>
						</ul></li>

					<li class="nav-item hover-link"><a class="nav-link me-2"
						href="#security"> <i class="fa fa-user  me-1"></i> <%=LanguageHelper.getMessage("safe_banking", lang)%>
					</a></li>


					<li class="nav-item hover-link"><a class="nav-link me-2"
						href="#support"> <i class="fas fa-life-ring  me-1"></i> <%=LanguageHelper.getMessage("help_support", lang)%>
					</a></li>

					<li class="nav-item hover-link" >
						<a class="nav-link me-2" href="#contact">
						  <i class="fas fa-key  me-1"></i>
							<%=LanguageHelper.getMessage("contact", lang)%>
						</a>
					  </li>
					  
					  <li class="nav-item dropdown hover-link" style="padding-right:80px;">
						  <a class="nav-link d-flex align-items-center me-2 active dropdown-toggle"
							  href="#" id="languageDropdown" role="button" data-bs-toggle="dropdown"
							aria-expanded="false"> 
						<i class="fas fa-language me-1"></i>
						<%=LanguageHelper.getMessage("lang", lang)%>
            </a>
            <ul class="dropdown-menu" aria-labelledby="languageDropdown">
              <li><a class="dropdown-item" href="ChangeLanguageServlet?lang=en"> 🇬🇧 <%=LanguageHelper.getMessage("eng", lang)%> </a></li>
              <li><a class="dropdown-item" href="ChangeLanguageServlet?lang=mm"> 🇲🇲 <%=LanguageHelper.getMessage("myan", lang)%> </a></li>
            </ul>
						</li>

				</ul>

				<li class="nav-item d-flex align-items-center">
					<%
					if (session.getAttribute("accno") != null) {
					%> <a
					class="btn btn-round btn-sm mb-0 btn-outline-white me-2 gradient-hover"
					href="logout.jsp"><%=LanguageHelper.getMessage("logout", lang)%></a> <%
 } else {
 %> <a
					class="btn btn-round btn-sm mb-0 btn-outline-white me-2 gradient-hover"
					href="sign_in.jsp"><%=LanguageHelper.getMessage("login", lang)%></a> <%
 }
 %>
				</li>

				<ul class="navbar-nav d-lg-block d-none">
					<li class="nav-item"><a href="sign_up.jsp"
						class="btn btn-sm btn-round mb-0 btn-outline-white me-1 bg-gradient-light gradient-hover"><%=LanguageHelper.getMessage("signup", lang)%>
						</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- End Navbar -->

	<!--  ======================= End Header Area ============================== -->

	<!--  ======================= Start Main Area ================================ -->
	<main class="site-main">
		<!--  ======================= Start Banner Area =======================  -->
		<section class="site-banner">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-6 col-md-12 site-title">
						<!-- <h3 class="title-text">Hey</h3> -->
						<h2 class="title-text text-white"><%=LanguageHelper.getMessage("Welcome_title_1", lang)%></h2>
						<h2 class="title-text text-white"><%=LanguageHelper.getMessage("Welcome_title_2", lang)%></h2>
						<h2 class="title-text text-white"><%=LanguageHelper.getMessage("Welcome_title_3", lang)%></h2>
						<p class="title-text text-white" style="padding: 30px 0 30px 0;"><%=LanguageHelper.getMessage("welcome_content", lang)%></p>
						<div class="site-buttons">
							<div class="d-flex flex-row flex-wrap "
								style="padding: 10px 0 80px 0;">
								<a href="sign_up.jsp" class="btn button bg-glass mr-4 text-uppercase">
    <%= LanguageHelper.getMessage("welcome_btn", lang) %>
</a>

							</div>
						</div>

					</div>

					<div class="col-lg-6 col-md-12 banner-image">
						<img src="img/side12.png" alt="banner-img" class="img-fluid">
					</div>
				</div>
			</div>
		</section>
		<!--  ======================= End Banner Area =======================  -->

		<!--  ====================== Start Services Area =============================  -->

		<section class="services-area" id="service">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-center services-title">
						<h1 class="text-uppercase title-text text-white"><%=LanguageHelper.getMessage("service_offers", lang)%></h1>
						<br>
						<p class="para text-white"><%=LanguageHelper.getMessage("index_sec1_p1", lang)%></p>
					</div>
				</div>
				<div class="container" style="margin-top: -70px;">
					<div class="row">
						<div class="col-lg-3 col-md-6 col-sm-12">
							<div class="services rounded-lg bg-glass">
								<div class="sevices-img text-center py-4">
									<img src="img/side10.png" alt="Services-1">
								</div>
								<div class="card-body text-center hover-text">
									<h5 class="card-title font-roboto"><%=LanguageHelper.getMessage("deposit", lang)%></h5>
									<p class="card-text"
										style="text-align: justify; padding: 20px;"><%=LanguageHelper.getMessage("index_sec1_p1_1", lang)%></p>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-6 col-sm-12">
							<div class="services rounded-lg bg-glass">
								<div class="sevices-img py-4">
									<img src="img/side13.png" alt="Services-2">
								</div>
								<div class="card-body text-center hover-text">
									<h5 class="card-title font-roboto"><%=LanguageHelper.getMessage("withdraw", lang)%></h5>
									<p class="card-text"
										style="text-align: justify; padding: 20px;"><%=LanguageHelper.getMessage("index_sec1_p1_2", lang)%></p>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-6 col-sm-12">
							<div class="services rounded-lg bg-glass">
								<div class="sevices-img text-center py-4">
									<img src="img/side14.png" alt="Services-3">
								</div>
								<div class="card-body text-center hover-text">
									<h5 class="card-title font-roboto"><%=LanguageHelper.getMessage("transfer", lang)%></h5>
									<p class="card-text"
										style="text-align: justify; padding: 20px;"><%=LanguageHelper.getMessage("index_sec1_p1_3", lang)%></p>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-6 col-sm-12">
							<div class="services rounded-lg bg-glass">
								<div class="sevices-img text-center py-4">
									<img src="img/side15.png" alt="Services-4">
								</div>
								<div class="card-body text-center hover-text">
									<h5 class="card-title font-roboto"><%=LanguageHelper.getMessage("currency_exchange", lang)%></h5>
									<p class="card-text"
										style="text-align: justify; padding: 20px;"><%=LanguageHelper.getMessage("index_sec1_p1_4", lang)%></p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!--  ====================== End Services Area =============================  -->

		<!--  ======================== Security Area ==============================  -->
		<!-- <div id="security">
            <br>
            <br>
        </div> -->
		<section id="security" class="about-area">
			<div class="container">
				<div class="row text-center">
					<div class="col-12">
						<div class="about-title">
							<h2 class="text-uppercase title-text text-white"><%=LanguageHelper.getMessage("index_sec2_h2_1", lang)%></h2>
							<p class="para text-white" style="margin-top: -20px;"><%=LanguageHelper.getMessage("index_sec2_p2", lang)%></p>
						</div>
					</div>
				</div>
			</div>

			<div class="container carousel py-lg-5" style="margin-top: -70px;">
				<div class="owl-carousel owl-theme">

					<div class="client row bg-glass">
						<div class="col-lg-4 col-md-12 client-img">
							<img src="img/side1.jpg" alt="img2" class="img-fluid">
						</div>
						<div class="col-lg-8 col-md-12 about-client">
							<h5 class=" text-white"><%=LanguageHelper.getMessage("index_sec2_h2_1", lang)%></h5>
							<br>
							<p class="para text-white align"><%=LanguageHelper.getMessage("index_sec2_p2_1", lang)%></p>
						</div>
					</div>
					<div class="client row bg-glass">
						<div class="col-lg-4 col-md-12 client-img">
							<img src="img/side1.jpg" alt="img1" class="img-fluid">
						</div>
						<div class="col-lg-8 col-md-12 about-client">
							<h5 class=" text-white"><%=LanguageHelper.getMessage("index_sec2_h2_2", lang)%></h5>
							<br>
							<p class="para text-white align"><%=LanguageHelper.getMessage("index_sec2_p2_2", lang)%></p>
						</div>
					</div>

					<div class="client row bg-glass">
						<div class="col-lg-4 col-md-12 client-img">
							<img src="img/side1.jpg" alt="img1" class="img-fluid">
						</div>
						<div class="col-lg-8 col-md-12 about-client">
							<h5 class=" text-white"><%=LanguageHelper.getMessage("index_sec2_h2_3", lang)%></h5>
							<p class="para text-white align"><%=LanguageHelper.getMessage("index_sec2_p2_3", lang)%></p>
						</div>
					</div>
					<div class="client row bg-glass">
						<div class="col-lg-4 col-md-12 client-img">
							<img src="img/side1.jpg" alt="img2" class="img-fluid">
						</div>
						<div class="col-lg-8 col-md-12 about-client">
							<h5 class=" text-white"><%=LanguageHelper.getMessage("index_sec2_h2_4", lang)%></h5>
							<br>
							<p class="para text-white align"><%=LanguageHelper.getMessage("index_sec2_p2_4", lang)%></p>
						</div>
					</div>
				</div>
			</div>

		</section>
		<!--  ======================== End About Me Area ==============================  -->

		<!-- ======================== Help and support ======================== -->
		<section class="support-area" id="support">
			<h4 class="text-center text-uppercase text-white"
				style="margin-top: -70px;"><%=LanguageHelper.getMessage("index_sec3", lang)%></h4>
			<br>
			<div class="container accordion-container bg-glass2">
				<div class="accordion" id="accordionExample">

					<!-- FAQ 1: How do I reset my password? -->
					<div class="accordion-item">
						<h2 class="accordion-header bg-glass2" id="headingOne">
							<button class="accordion-button" type="button"
								data-bs-toggle="collapse" data-bs-target="#collapseOne"
								aria-expanded="true" aria-controls="collapseOne"><%=LanguageHelper.getMessage("index_sec3_q1", lang)%></button>
						</h2>
						<div id="collapseOne"
							class="accordion-collapse collapse show bg-glass2"
							aria-labelledby="headingOne" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<strong><%=LanguageHelper.getMessage("index_sec3_a1_0", lang)%></strong>
								<li><%=LanguageHelper.getMessage("index_sec3_a1_1", lang)%></li>
								<li><%=LanguageHelper.getMessage("index_sec3_a1_2", lang)%></li>
								<li><%=LanguageHelper.getMessage("index_sec3_a1_3", lang)%></li>
								<%=LanguageHelper.getMessage("index_sec3_a1_4", lang)%>
							</div>
						</div>
					</div>

					<!-- FAQ 2: How can I contact customer support? -->
					<div class="accordion-item">
						<h2 class="accordion-header bg-glass2" id="headingTwo">
							<button class="accordion-button collapsed" type="button"
								data-bs-toggle="collapse" data-bs-target="#collapseTwo"
								aria-expanded="false" aria-controls="collapseTwo"><%=LanguageHelper.getMessage("index_sec3_q2", lang)%></button>
						</h2>
						<div id="collapseTwo"
							class="accordion-collapse collapse bg-glass2"
							aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<%=LanguageHelper.getMessage("index_sec3_a2_0", lang)%>
								<li><%=LanguageHelper.getMessage("index_sec3_a2_1", lang)%></li>
								<li><%=LanguageHelper.getMessage("index_sec3_a2_2", lang)%></li>
								<li><%=LanguageHelper.getMessage("index_sec3_a2_3", lang)%></li>
							</div>
						</div>
					</div>

					<!-- FAQ 3: What payment methods do you accept? -->
					<div class="accordion-item">
						<h2 class="accordion-header bg-glass2" id="headingThree">
							<button class="accordion-button collapsed" type="button"
								data-bs-toggle="collapse" data-bs-target="#collapseThree"
								aria-expanded="false" aria-controls="collapseThree">
								<%=LanguageHelper.getMessage("index_sec3_q3", lang)%></button>
						</h2>
						<div id="collapseThree"
							class="accordion-collapse collapse bg-glass2"
							aria-labelledby="headingThree" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<%=LanguageHelper.getMessage("index_sec3_a3_0", lang)%>
								<li><%=LanguageHelper.getMessage("index_sec3_a3_1", lang)%></li>
								<li><%=LanguageHelper.getMessage("index_sec3_a3_2", lang)%></li>
								<li><%=LanguageHelper.getMessage("index_sec3_a3_3", lang)%></li>
								<li><%=LanguageHelper.getMessage("index_sec3_a3_4", lang)%></li>
								<li><%=LanguageHelper.getMessage("index_sec3_a3_5", lang)%></li>
							</div>
						</div>
					</div>

					<!-- FAQ 4: Can I cancel or modify my order? -->
					<div class="accordion-item">
						<h2 class="accordion-header bg-glass2" id="headingFour">
							<button class="accordion-button collapsed" type="button"
								data-bs-toggle="collapse" data-bs-target="#collapseFour"
								aria-expanded="false" aria-controls="collapseFour"><%=LanguageHelper.getMessage("index_sec3_q4", lang)%></button>
						</h2>
						<div id="collapseFour"
							class="accordion-collapse collapse bg-glass2"
							aria-labelledby="headingFour" data-bs-parent="#accordionExample">
							<div class="accordion-body"><%=LanguageHelper.getMessage("index_sec3_a4_0", lang)%></div>
						</div>
					</div>

					<!-- FAQ 5: Is my personal information secure? -->
					<div class="accordion-item">
						<h2 class="accordion-header bg-glass2" id="headingFive">
							<button class="accordion-button collapsed" type="button"
								data-bs-toggle="collapse" data-bs-target="#collapseFive"
								aria-expanded="false" aria-controls="collapseFive"><%=LanguageHelper.getMessage("index_sec3_q5", lang)%>
							</button>
						</h2>
						<div id="collapseFive"
							class="accordion-collapse collapse bg-glass2"
							aria-labelledby="headingFive" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<%=LanguageHelper.getMessage("index_sec3_a5_0_1", lang)%> <strong><%=LanguageHelper.getMessage("index_sec3_a5_0_2", lang)%></strong> 
								<%=LanguageHelper.getMessage("index_sec3_a5_0_3", lang)%><strong><%=LanguageHelper.getMessage("index_sec3_a5_0_4", lang)%></strong>
								<%=LanguageHelper.getMessage("index_sec3_a5_0_5", lang)%>
							</div>
						</div>
					</div>

				</div>
			</div>
		</section>

		<!-- ======================== End Help and support ======================== -->

		<!--  ========================== contact Area ============================  -->
		<div class="contact-area">
			<section class="container" id="contact">
				<div class="contact-container" style="margin-top: -70px;">
					<h3 class="text-white"><%=LanguageHelper.getMessage("contat_us", lang)%></h3>
					<br>

					<div class="contact-info">
						<div class="col-md-4 ">
							<i class="bi bi-geo-alt-fill"></i>
							<p>
								<strong><%=LanguageHelper.getMessage("address", lang)%></strong><br>198 West 21th Street, Suite
								721 YANGON 10016
							</p>
						</div>
						<div class="col-md-4">
							<i class="bi bi-telephone-fill"></i>
							<p>
								<strong><%=LanguageHelper.getMessage("phone", lang)%></strong><br>+959 794 235 98
							</p>
						</div>
						<div class="col-md-4">
							<i class="bi bi-envelope-fill"></i>
							<p>
								<strong><%=LanguageHelper.getMessage("email", lang)%></strong><br>digitalwallet@gmail.com
							</p>
						</div>
					</div>

					<h4 class="text-white mb-3"><%=LanguageHelper.getMessage("touch", lang)%></h4>

					<%=(msg != null && !msg.isEmpty()) ? msg : ""%>

					<form action="index.jsp" method="post">
						<div class="mb-3 bg-glass2">
							<input type="text" name="name"
								class="form-control transparent-input " placeholder="<%=LanguageHelper.getMessage("name", lang)%>"
								required>
						</div>
						<div class="mb-3 bg-glass2">
							<input type="email" name="email"
								class="form-control transparent-input " placeholder="<%=LanguageHelper.getMessage("email", lang)%>"
								required>
						</div>
						<div class="mb-3 bg-glass2">
							<input type="text" name="subject"
								class="form-control transparent-input " placeholder="<%=LanguageHelper.getMessage("subject", lang)%>"
								required>
						</div>
						<div class="mb-3 bg-glass2">
							<textarea name="message" class="form-control transparent-input "
								rows="4" placeholder="<%=LanguageHelper.getMessage("message", lang)%>" required></textarea>
						</div>
						<button type="submit" name="submit"
							class="btn button w-50 bg-glass"><%=LanguageHelper.getMessage("send_message", lang)%></button>
					</form>
				</div>
			</section>
		</div>
		<!--  ========================== End Subscribe me Area ============================  -->


	</main>
	<!--  ======================= End Main Area ================================ -->

	<footer class="footer-area">
		<div class="container">
			<div class="">
				<div class="site-logo text-center py-4">
					<a href="#"><img src="img/logo.png" alt="logo"
						style="height: 35px; width: auto; vertical-align: middle;"></a>
				</div>
				<div class="social text-center">
					<h5 class="text-uppercase text-white">Follow me</h5>
					<a href="#"><i class="fab fa-facebook footercon"></i></a> <a
						href="#"><i class="fab fa-instagram footercon"></i></a> <a
						href="#"><i class="fab fa-youtube footercon"></i></a> <a href="#"><i
						class="fab fa-twitter footercon"></i></a>
				</div>
				<div class="copyrights text-center">
					<p class="para text-white">
						Copyright @ 2025 All rights reserved | <%=LanguageHelper.getMessage("index_footer1", lang)%>
						<a href="#"><span style="color: white"> <strong><%=LanguageHelper.getMessage("index_footer2", lang)%></strong></span></a>
					</p>
				</div>
			</div>
		</div>
	</footer>

	<script src="js/leaf.js"></script>
	<script>
		AOS.init({
			duration : 1000,
			delay : 400
		});
	</script>

	<!--  Jquery js file  -->
	<script src="js-update/jquery.3.4.1.js"></script>

	<!--  Bootstrap js file  -->
	<script src="js-update/bootstrap.min.js"></script>

	<!--  isotope js library  -->
	<script src="js-update/vendor/isotope/isotope.min.js"></script>

	<!--  Magnific popup script file  -->
	<script
		src="js-update/vendor/Magnific-Popup/dist/jquery.magnific-popup.min.js"></script>

	<!--  Owl-carousel js file  -->
	<script src="js-update/vendor/owl-carousel/js/owl.carousel.min.js"></script>

	<!--  custom js file  -->
	<script src="js-update/main.js"></script>

	<!-- Bootstrap 5 JS (Needed for Dropdowns) -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>