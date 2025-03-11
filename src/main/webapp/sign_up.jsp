<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
  <!-- CSS Files -->
  <link id="pagestyle" href="../assets/css/soft-ui-dashboard.css?v=1.1.0" rel="stylesheet" />
  <!-- Nepcha Analytics (nepcha.com) -->
  <!-- Nepcha is a easy-to-use web analytics. No cookies and fully compliant with GDPR, CCPA and PECR. -->
  <script defer data-site="YOUR_DOMAIN_HERE" src="https://api.nepcha.com/js/nepcha-analytics.js"></script>
  <script type="text/javascript" src="js/nrc.js"></script>
  
  <link id="pagestyle" href="css_update/soft-ui-dashboard.css" rel="stylesheet">
  <link href="css_update/form.css" rel="stylesheet">
  <link href="css_update/user.css" rel="stylesheet">
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  
  <!-- Font Awesome 6 CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>

  <style>
    /* Body with Background Image */
    body{
      background: rgb(10,0,36);
	background: linear-gradient(135deg, rgba(10,0,36,1) 0%, rgba(0,0,14,1) 50%, rgba(45,5,102,0.9922093837535014) 100%, rgba(38,1,117,1) 100%, rgba(52,1,145,1) 100%);
  
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

	.success-alert {
            animation: fadeIn 1s ease-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

</style>
  
  <script>
        // Client-side password validation
        function validatePassword() {
            const password = document.getElementById("password").value;
            const re_password = document.getElementById("re_password").value;
            const message = document.getElementById("confirmMessage");

            // Regular expression for strong passwords
            const strongPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;

            if (!strongPassword.test(password)) {
                message.innerHTML = "<%=LanguageHelper.getMessage("psw1", lang)%>";
                message.style.color = "red";
                return false;
            } else if (password !== re_password) {
                message.innerHTML = "<%=LanguageHelper.getMessage("psw2", lang)%>";
                message.style.color = "red";
                return false;
            } else {
                message.innerHTML = "<%=LanguageHelper.getMessage("psw3", lang)%>";
                message.style.color = "green";
                return true;
            }
        }
    </script>
    
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
              <%=LanguageHelper.getMessage("currency", lang)%>
            </a>
          </li>
        </ul>
        
        <li class="nav-item d-flex align-items-center">
		    <% if (session.getAttribute("accno") != null) { %>
		        <a class="btn btn-round btn-sm mb-0 btn-outline-white me-2 gradient-hover" href="logout.jsp"><%=LanguageHelper.getMessage("login", lang)%></a>
		    <% } else { %>
		        <a class="btn btn-round btn-sm mb-0 btn-outline-white me-2 gradient-hover" href="sign_in.jsp"><%=LanguageHelper.getMessage("logout", lang)%></a>
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
    <section class="min-vh-100 mb-8">
      <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('img/form9.jpg');">
        <span class="mask bg-gradient-dark opacity-6"></span>
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-5 text-center mx-auto">
              <h2 class="text-white mb-2 mt-5"><%=LanguageHelper.getMessage("welcome", lang)%></h2><br>
              <p class="text-lead text-white"><%=LanguageHelper.getMessage("signup_content", lang)%></p>
            </div>
          </div>
        </div>
      </div>
      
      <div class="container">
        <div class="row mt-lg-n10 mt-md-n11 mt-n10">
          <div class="col-xl-4 col-lg-5 col-md-7 mx-auto">
            <div class="card z-index-0 bg-glass2">
              
              <h4 style="text-align: center; padding-top: 20px; color: #fff;"><%=LanguageHelper.getMessage("signup_title", lang)%></h4>

              
              <div class="card-body">
                
                <!--  
                  <div class="mb-3">
                    <input type="text" class="form-control" placeholder="Name" aria-label="Name" aria-describedby="email-addon">
                  </div>
                  <div class="mb-3">
                    <input type="email" class="form-control" placeholder="Email" aria-label="Email" aria-describedby="email-addon">
                  </div>
                  <div class="mb-3">
                    <input type="password" class="form-control" placeholder="Password" aria-label="Password" aria-describedby="password-addon">
                  </div>
                 --> 
                 
                <!-- Display Error Message (if exists) -->
                <% 
				    // Retrieve the error message from the request
				    String error = (String) request.getAttribute("errorMessage"); 
				%>
				
				<% if (error != null) { %>
				    <div class="alert alert-danger mt-3 text-center" role="alert">
				      <%= error %>
				    </div>
				  <% } %>
				  
				 <%
			        String successMessage = (String) request.getAttribute("successMessage");
			        if (successMessage != null) {
			    %>
			        <div class="alert alert-success text-center">
			            <%= successMessage %>
			        </div>
			        
			        <!-- Use JavaScript to delay the redirect -->
			        <script>
			            setTimeout(function() {
			                window.location.href = 'sign_in.jsp'; // Redirect to the sign-in page
			            }, 9000); // 9-second delay
			        </script>
			    <%
			        }
			    %>
						        
		        <form method="post" action="${pageContext.request.contextPath}/RegisterController" onsubmit="return validatePassword()">


		        <div class="col-sm-12">
                  <div class="row">
		            <div class="col-sm-6 form-group ">
		                <input type="text" name="fullname" class="form-control" placeholder="<%=LanguageHelper.getMessage("fullname", lang)%>" aria-describedby="email-addon" required>
              		</div>
              		
              		<div class="col-sm-6 form-group">
		                <input type="text" name="username" class="form-control" placeholder="<%=LanguageHelper.getMessage("username", lang)%>" aria-describedby="email-addon" required>
              		</div>
		        </div>
		        
		        <div class="row">
		            <div class="col-sm-6 form-group">
		                <input type="date" name="dob" id="dob" class="form-control" placeholder="<%=LanguageHelper.getMessage("dob", lang)%>" aria-describedby="email-addon" required>
		            </div>
		            <div class="col-sm-6 form-group">
		                <select name="gender" class="form-control" required>
		                	<option value="" disabled selected><%=LanguageHelper.getMessage("gender", lang)%></option>
		                    <option value="Male"><%=LanguageHelper.getMessage("Male", lang)%></option>
		                    <option value="Female"><%=LanguageHelper.getMessage("Female", lang)%></option>
		                    <option value="Other"><%=LanguageHelper.getMessage("Other", lang)%></option>
		                </select>
		            </div>
		        </div>
		        
				<div class="row">
					
				    <div class="d-flex align-items-center mb-3">
					    <span class="ms-2 text-white"><%=LanguageHelper.getMessage("nrc", lang)%></span>
					</div>
				    <!-- Region Dropdown -->
				    <div class="col-sm-4 form-group">
				         <select id="region" class="form-control" name="region" required>
				         	<option value="" disabled selected><%=LanguageHelper.getMessage("select", lang)%></option>
		                	<option value="1">1</option>
				            <option value="2">2</option>
				            <option value="3">3</option>
				            <option value="4">4</option>
				            <option value="5">5</option>
				            <option value="6">6</option>
				            <option value="7">7</option>
				            <option value="8">8</option>
				            <option value="9">9</option>
				            <option value="10">10</option>
				            <option value="11">11</option>
				            <option value="12">12</option>
				            <option value="13">13</option>
				            <option value="14">14</option>
				        </select>
				        </select>
				    </div>

				    <!-- Type Dropdown -->
				    <div class="col-sm-4 form-group">
				        <select id="state" class="form-control" name="state" required>
				            <option value="" disabled selected><%=LanguageHelper.getMessage("select", lang)%></option>
		                
				        </select>
				    </div>
				    
				    <!-- Type Dropdown -->
				    <div class="col-sm-4 form-group">
				         <select id="type" class="form-control" name="type" required>
				         	<option value="" disabled selected><%=LanguageHelper.getMessage("select", lang)%></option>
							<option value="C">(C) နိုင်</option>
							<option value="AC">(AC) ဧည့်</option>
							<option value="NC">(NC) ပြု</option>
							<option value="V">(V) စ</option>
							<option value="M">(M) သ</option>
							<option value="N">(N) သီ</option>
				        </select>
				    </div>

				    <!-- Integer Input for NRC -->
				    <div class="col-sm-4 form-group">
				        <input type="text" id="nrc_number" name="nrc_number" class="form-control" placeholder="<%=LanguageHelper.getMessage("digits", lang)%>" maxlength="6" pattern="\d{6}" required>
				    </div>
				
				    <!-- Hidden field to store the combined NRC value -->
				    <input type="hidden" id="nrc" name="nrc" value="">
				    
				</div>
				
				<div class="form-group">
	                <textarea name="address" class="form-control" placeholder="<%=LanguageHelper.getMessage("address", lang)%>" required></textarea>
	            </div>
	            
	            <div class="row">
		            <div class="col-sm-6 form-group">
		                <input type="email" name="email" class="form-control" placeholder="<%=LanguageHelper.getMessage("email", lang)%>" required>
		            </div>
		            <div class="col-sm-6 form-group">
		                <input type="tel" name="phone" class="form-control" 
		                placeholder="<%=LanguageHelper.getMessage("phone", lang)%> (+959)"
		            	maxlength="15" pattern="(\+959|959)[0-9]{8,11}" title="Phone number must start with +959 or 959, followed by 8 to 11 digits." required>
					</div>
		        </div>
		        
		        <div class="form-group">
				         <select id="acctype" class="form-control" name="acctype" required>
				         	<option value="" disabled selected><%=LanguageHelper.getMessage("acc_type", lang)%></option>
		                	<option value="Current Account"><%=LanguageHelper.getMessage("current_acc", lang)%></option>
				            <option value="Saving Account"><%=LanguageHelper.getMessage("saving_acc", lang)%></option>
				        </select>
				</div>
				
		        <div class="row">
		            <div class="col-sm-6 form-group">
		                <input type="password" name="password" id="password" class="form-control" placeholder="<%=LanguageHelper.getMessage("password", lang)%>" required>
		            </div>
		            <div class="col-sm-6 form-group">
		                <input type="password" name="re_password" id="re_password" class="form-control" placeholder="<%=LanguageHelper.getMessage("c_password", lang)%>" required>
		            </div>
		        </div>
		        
		        <div style="text-align: center; padding:20px;"><span id="confirmMessage"></span></div>
                  
                  <div class="text-center">
                      <button type="submit" class="btn btn-custom w-100 mt-4 mb-0 bg-glass" style="border:1px solid #9454f1;"><%=LanguageHelper.getMessage("sign_in", lang)%></button>
                    </div>
                  
               	</div>
        	</form>
        	
                  <p class="text-sm mt-3 mb-0" id="hover-text"><%=LanguageHelper.getMessage("already", lang)%><a href="sign_in.jsp" class="text-dark font-weight-bolder" id="hover-text"><%=LanguageHelper.getMessage("sign_in", lang)%></a></p>
                
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- -------- START FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
  <footer class="footer py-5">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 mb-4 mx-auto text-center">
		  <div class="text-white me-xl-5 me-3 mb-sm-0 mb-2 gradient-hover d-inline-block">
		    <%=LanguageHelper.getMessage("community", lang)%>
		  </div>
		  <div class="text-white me-xl-5 me-3 mb-sm-0 mb-2 gradient-hover d-inline-block">
		    <%=LanguageHelper.getMessage("about_us", lang)%>
		  </div>
		  <div class="text-white me-xl-5 me-3 mb-sm-0 mb-2 gradient-hover d-inline-block">
		    <%=LanguageHelper.getMessage("team", lang)%>
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
    <!-- Include Bootstrap JS (for modal functionality) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        let today = new Date();
        let minAge = 18;
        let maxDate = new Date(today.getFullYear() - minAge, today.getMonth(), today.getDate());

        document.getElementById("dob").setAttribute("max", maxDate.toISOString().split("T")[0]);
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
  <script src="../assets/js/soft-ui-dashboard.min.js?v=1.1.0"></script>
  </main>
</body>

</html>