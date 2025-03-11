<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.bank.LanguageHelper"%>
<%
String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="img/logo.png">
    <link rel="icon" type="image/png" href="img/logo.png">
    <title>
        Digital Wallet by Group-6
    </title>
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700,800" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="https://demos.creative-tim.com/soft-ui-dashboard/assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="https://demos.creative-tim.com/soft-ui-dashboard/assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Font Awesome 6 CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>
  
  <!-- CSS Files -->
  <link rel="stylesheet" href="css_update/user.css">
	<link id="pagestyle" href="../assets/css/soft-ui-dashboard.css?v=1.1.0" rel="stylesheet" />
  <!-- Nepcha Analytics (nepcha.com) -->
  <!-- Nepcha is a easy-to-use web analytics. No cookies and fully compliant with GDPR, CCPA and PECR. -->
  <script defer data-site="YOUR_DOMAIN_HERE" src="https://api.nepcha.com/js/nepcha-analytics.js"></script>
  <script type="text/javascript" src="js/nrc.js"></script>
  
  <link id="pagestyle" href="css_update/soft-ui-dashboard.css?v=1.1.0" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  
  <style>
    /* Body with Background Image */
    body{
      background: #080810;
    }

    .bg-glass {
      position: relative;
      background: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      color:white;
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
	  background: linear-gradient(135deg, #9454f1, #ffffff); /* Reverse gradient effect */
	  background-clip: padding-box;
	  color: rgb(255, 255, 255);
	  box-shadow: 5px 5px 20px 5px rgba(148, 84, 241, 0.6); /* More intense glow */
	  transition: all 0.3s ease-in-out;
	}
	
    #hover-link:hover{
    background: none;
    background-image: linear-gradient(135deg, #ffffff, #9454f1, #9454f1);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
	}
	
	/* Ensure both icon and text change color on hover */
	.gradient-hover:hover,
	.hover-link:hover .nav-link,
	.hover-link:hover .nav-link i {
    background: linear-gradient(135deg, #ffffff, #9454f1, #9454f1); 
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    transition: background 0.3s ease-in-out;
	}
	
    .hover-text {
    background: none;
    background-image:  linear-gradient(135deg, #ffffff, #9454f1, #9454f1);
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
    
    .btn-custom:hover {
    background: #9454f1;
    color: white;

}

</style>
</head>

<body class="">
        <!-- Navbar -->
		  <nav class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3 navbar-transparent mt-4">
		    <div class="container">
		    	<div class="">
					<img src="img/logo.png" alt="" class="logo">
		        </div>
		      <a class="navbar-brand font-weight-bolder ms-lg-0 ms-3 text-white " href="index.jsp" target="_blank">
		        <span class="ms-1 font-weight-bold">Digital Wallet</span>
		      </a>
      
		      <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
		        <span class="navbar-toggler-icon mt-2">
		          <span class="navbar-toggler-bar bar1"></span>
		          <span class="navbar-toggler-bar bar2"></span>
		          <span class="navbar-toggler-bar bar3"></span>
		        </span>
		      </button>
      <div class="collapse navbar-collapse" id="navigation" style="background:#;">
        <ul class="navbar-nav mx-auto ms-xl-auto me-xl-5">
          <li class="nav-item hover-link">
            <a class="nav-link me-2" href="deposit.jsp">
              <i class="fa-solid fa-money-bill-1-wave"></i>
              <%=LanguageHelper.getMessage("deposit", lang)%>
            </a>
          </li> 
          <li class="nav-item hover-link">
            <a class="nav-link me-2" href="withdraw.jsp">
              <i class="fa-solid fa-money-bills"></i>
  				<%=LanguageHelper.getMessage("withdraw", lang)%>
            </a>
          </li>
          
          
          <li class="nav-item hover-link">
            <a class="nav-link me-2" href="transfer.jsp">
              <i class="fa-solid fa-money-bill-transfer"></i>
              <%=LanguageHelper.getMessage("transfer", lang)%>
            </a>
          </li>
                       
          <li class="nav-item hover-link" style="padding-right:80px;">
            <a class="nav-link me-2" href="exchange_converter.jsp">
              <i class="fa-solid fa-money-bill-trend-up"></i>
              <%=LanguageHelper.getMessage("exchange_converter", lang)%>
            </a>
          </li>
        </ul>
        
        <li class="nav-item d-flex align-items-center">
		    <% if (session.getAttribute("accno") != null) { %>
		        <a class="btn btn-round btn-sm mb-0 btn-outline-white me-2 gradient-hover" href="logout.jsp"><%=LanguageHelper.getMessage("logout", lang)%></a>
		    <% } else { %>
		        <a class="btn btn-round btn-sm mb-0 btn-outline-white me-2 gradient-hover" href="sign_in.jsp"><%=LanguageHelper.getMessage("login", lang)%></a>
		    <% } %>
		</li>

        <ul class="navbar-nav d-lg-block d-none">
          <li class="nav-item">
            <a href="sign_up.jsp" class="btn btn-sm btn-round mb-0 btn-outline-white me-1 bg-gradient-light gradient-hover"><%=LanguageHelper.getMessage("signup", lang)%></a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- End Navbar -->
      
  <main class="main-content  mt-0">
    <section>
      <div class="page-header min-vh-75">
        <div class="container">
          <div class="row">
            <div class="col-xl-4 col-lg-5 col-md-6 d-flex flex-column mx-auto">
              <div class="card card-plain mt-8">
                <div class="card-header pb-0 text-left bg-transparent">
                  <h3 class="font-weight-bolder text-info" id="hover-text" ><%=LanguageHelper.getMessage("welcome_back", lang)%></h3>
                  
                  <% if (request.getAttribute("errorMessage") != null) { %>
				    <div class="alert alert-danger mt-3" role="alert">
				      <%= request.getAttribute("errorMessage") %>
				    </div>
				  <% } %>
				  <% if (request.getAttribute("successMessage") != null) { %>
				    <div class="alert alert-success mt-3" role="alert">
				      <%= request.getAttribute("successMessage") %>
				    </div>
				  <% } %>
				  
               </div>
                <div class="card-body" >
                  <form role="form" action="login" method="post">
                    <label class="text-white"><%=LanguageHelper.getMessage("acc_no", lang)%></label>
                    <div class="mb-3">
                    	<input type="text" name="accno" class="form-control transparent-input"
                    	 style="border:1px solid #9454f1;" aria-describedby="email-addon" required>
              		</div>
                    <label class="text-white"><%=LanguageHelper.getMessage("password", lang)%></label>
                    <div class="mb-3">
                      	<input type="password" name="password" class="form-control transparent-input" 
                      	style="border:1px solid #9454f1;"  required>
		           	</div>
                    <div class="form-check form-switch">
                      <a href="forgot_password.jsp" class="text-white me-xl-5 me-3 mb-sm-0 mb-2 gradient-hover"
                      style="padding-left:138px; font-size: 13px; text-decoration: underline;">
			            <%=LanguageHelper.getMessage("forgot_password", lang)%>
			          </a>
                    </div>
                    
                    <div class="text-center">
                      <button type="submit" class="btn btn-custom w-100 mt-4 mb-0 bg-glass" style="border:1px solid #9454f1;"><%=LanguageHelper.getMessage("sign_in", lang)%></button>
                    </div>
                    
                  </form>
                </div>
                
                <div class="card-footer text-center pt-0 px-lg-2 px-1" id="hover-text" >
                  <p class="mb-4 text-sm mx-auto">
                    <%=LanguageHelper.getMessage("no_acc", lang)%>
                    <a href="sign_up.jsp" class="text-info font-weight-bold" id="hover-text" ><%=LanguageHelper.getMessage("signup", lang)%></a>
                  </p>
                  
                  
                </div>
                
                
              </div>
            </div>
            <div class="col-md-6">
              <div class="oblique position-absolute top-0 h-100 d-md-block d-none me-n8">
                <div class="oblique-image bg-cover position-absolute fixed-top ms-auto h-100 z-index-0 ms-n6" style="background-image:url('img/side5.jpg')"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
  <!-- -------- START FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
  <footer class="footer py-5">
    <div class="container">
      <div class="row">
                
        
        
        
        <div class="col-lg-8 mb-4 mx-auto text-center">
        <a href="admin_login.jsp" class="text-white me-xl-5 me-3 mb-sm-0 mb-2 gradient-hover" style="text-decoration: underline;">
			  <%=LanguageHelper.getMessage("admin_login", lang)%>
			</a>
      <div class="text-white me-xl-5 me-3 mb-sm-0 mb-2 gradient-hover d-inline-block">
        <%=LanguageHelper.getMessage("community", lang)%>
      </div>
      <div class="text-white me-xl-5 me-3 mb-sm-0 mb-2 gradient-hover d-inline-block">
        <%=LanguageHelper.getMessage("about_us", lang)%>
      </div>
      <div class="text-white me-xl-5 me-3 mb-sm-0 mb-2 gradient-hover d-inline-block">
        <%=LanguageHelper.getMessage("FAQ", lang)%>
      </div>
    </div>
        
        <div class="col-lg-8 mx-auto text-center mb-4 mt-2">
          
          <a href="javascript:;" target="_blank" class="text-white me-xl-4 me-4 gradient-hover">
            <span class="text-lg fab fa-twitter"></span>
          </a>
          <a href="javascript:;" target="_blank" class="text-white me-xl-4 me-4 gradient-hover">
            <span class="text-lg fab fa-instagram"></span>
          </a>
          <a href="javascript:;" target="_blank" class="text-white me-xl-4 me-4 gradient-hover">
            <span class="text-lg fab fa-pinterest"></span>
          </a>
          <a href="javascript:;" target="_blank" class="text-white me-xl-4 me-4 gradient-hover">
            <span class="text-lg fab fa-github"></span>
          </a>
        </div>
      </div>
      <div class="row">
        <div class="col-8 mx-auto text-center mt-1">
          <p class="mb-0 text-white">
            Copyright @ <script>
              document.write(new Date().getFullYear())
            </script> J2EE Project by Group-6
          </p>
        </div>
      </div>
    </div>
  </footer>
  
  <!-- -------- END FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
  <!--   Core JS Files   -->
  <script src="js/core/popper.min.js"></script>
    <script src="js/core/bootstrap.min.js"></script>
    <script src="js/plugins/perfect-scrollbar.min.js"></script>
    <script src="js/plugins/smooth-scrollbar.min.js"></script>
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
  <script src="../assets/js/soft-ui-dashboard.min.js?v=1.1.0"></script>
  </div>
</body>

</html>