<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, com.bank.database.DatabaseConnection"%>
    
<%
if (session.getAttribute("uname") == null) {
    response.sendRedirect("admin_login.jsp"); // Redirect if admin is not logged in
    return; // Stop further execution
}
String username = (String) session.getAttribute("uname");
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
String email = "", phone = "", profilePic = "img/No_Img.jpg", id = "", password = "";
try {
    con = DatabaseConnection.getConnection();
    String query = "SELECT a_id, username, password, email, phone, profile_picture FROM admin WHERE username=?";
    ps = con.prepareStatement(query);
    ps.setString(1, username);
    rs = ps.executeQuery();
    
    if (rs.next()) {
        id = rs.getString("a_id");
        password = rs.getString("password");
        email = rs.getString("email");
        phone = rs.getString("phone");
        String tempProfilePic = rs.getString("profile_picture");
        if (tempProfilePic != null && !tempProfilePic.isEmpty()) {
            profilePic = tempProfilePic;
        }
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
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
   
  <link href="css_update/soft-ui-dashboard.css" rel="stylesheet">
  <link id="pagestyle" href="css_update/dashboard.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style>
#hover-text {
    background: none;
    background-image: linear-gradient(135deg, #ff03c8, #6a00ff, #3d8afd);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.glass-effect {
  position: relative;
  background: transparent; /* Allows blur effect */
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-radius: 10px;
  border: 1px solid rgba(255, 255, 255, 0.18);
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.10);
  overflow: hidden; /* Ensures pseudo-element stays inside */
}

/* Gradient Layer */
.glass-effect::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(255, 3, 200, 0.3), rgba(106, 0, 255, 0.3), rgba(61, 138, 253, 0.3)); 
  border-radius: inherit;
  z-index: -1;
  opacity: 0.8; 
}
</style>

</head>

<body class="g-sidenav-show  bg-gray-100">

    <aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 " id="sidenav-main">
    
    <div class="sidenav-header sticky-top bg-white">
      <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
      <a class="navbar-brand m-0" href="index.jsp" target="_blank">
        <img src="img/vue.png" class="navbar-brand-img h-100" alt="main_logo">
        <span class="ms-1 font-weight-bold">Admin Dashboard</span>
      </a>
    </div>
    
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto vh-100" id="sidenav-collapse-main">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link " id="hover-link" href="dashboard.jsp">
            <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center me-2 d-flex align-items-center justify-content-center">
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
            <span class="nav-link-text ms-1">Dashboard</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link " id="hover-link" href="acc_requests.jsp">
            <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center me-2 d-flex align-items-center justify-content-center">
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
            <span class="nav-link-text ms-1">Account Requests</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link  " id="hover-link" href="deposit_approve.jsp">
            <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center me-2 d-flex align-items-center justify-content-center">
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
            <span class="nav-link-text ms-1">Deposit Approve</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link  " id="hover-link" href="transaction.jsp">
            <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center me-2 d-flex align-items-center justify-content-center">
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
            <span class="nav-link-text ms-1">Transaction</span>
          </a>
        </li>
        <li class="nav-item mt-3">
          <h6 class="ps-4 ms-2 text-uppercase text-xs font-weight-bolder opacity-6">Account pages</h6>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" id="hover-link" href="manage_acc.jsp">
            <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center me-2 d-flex align-items-center justify-content-center">
              <svg width="10px" height="10px" viewBox="0 0 40 40" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                          <title>settings</title>
                          <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                            <g transform="translate(-2020.000000, -442.000000)" fill="#FFFFFF" fill-rule="nonzero">
                              <g transform="translate(1716.000000, 291.000000)">
                                <g transform="translate(304.000000, 151.000000)">
                                  <polygon class="color-background" opacity="0.596981957" points="18.0883333 15.7316667 11.1783333 8.82166667 13.3333333 6.66666667 6.66666667 0 0 6.66666667 6.66666667 13.3333333 8.82166667 11.1783333 15.315 17.6716667"></polygon>
                                  <path class="color-background" d="M31.5666667,23.2333333 C31.0516667,23.2933333 30.53,23.3333333 30,23.3333333 C29.4916667,23.3333333 28.9866667,23.3033333 28.48,23.245 L22.4116667,30.7433333 L29.9416667,38.2733333 C32.2433333,40.575 35.9733333,40.575 38.275,38.2733333 L38.275,38.2733333 C40.5766667,35.9716667 40.5766667,32.2416667 38.275,29.94 L31.5666667,23.2333333 Z" opacity="0.596981957"></path>
                                  <path class="color-background" d="M33.785,11.285 L28.715,6.215 L34.0616667,0.868333333 C32.82,0.315 31.4483333,0 30,0 C24.4766667,0 20,4.47666667 20,10 C20,10.99 20.1483333,11.9433333 20.4166667,12.8466667 L2.435,27.3966667 C0.95,28.7083333 0.0633333333,30.595 0.00333333333,32.5733333 C-0.0583333333,34.5533333 0.71,36.4916667 2.11,37.89 C3.47,39.2516667 5.27833333,40 7.20166667,40 C9.26666667,40 11.2366667,39.1133333 12.6033333,37.565 L27.1533333,19.5833333 C28.0566667,19.8516667 29.01,20 30,20 C35.5233333,20 40,15.5233333 40,10 C40,8.55166667 39.685,7.18 39.1316667,5.93666667 L33.785,11.285 Z"></path>
                                </g>
                              </g>
                            </g>
                          </g>
              </svg>
            </div>
            <span class="nav-link-text ms-1">Manage Accounts</span>
          </a>
          <!--  
          		<ul id="manageUserDropdown1" class="collapse" style="list-style: none;">
                    <li class="nav-item">
                    	<a class="nav-link" href="freeze_acc.jsp">
                        <span class="nav-link-text" style="padding-left: 35px; margin: 0;"> Freeze Accounts</span>
                        </a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link" href="delete_acc.jsp">
                        <span class="nav-link-text" style="padding-left: 35px; margin: 0;">Delete Accounts</span>
                        </a>
                    </li>
               	</ul>
           -->     
        </li>
        
        <li class="nav-item">
          <a class="nav-link active" href="admin_profile.jsp">
            <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center me-2 d-flex align-items-center justify-content-center">
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
            <span class="nav-link-text ms-1">Admin Profile</span>
          </a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="#manageUserDropdown2" data-bs-toggle="collapse" aria-expanded="false">
            <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center me-2 d-flex align-items-center justify-content-center">
              <svg width="10px" height="10px" viewBox="0 0 40 40" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                          <title>settings</title>
                          <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                            <g transform="translate(-2020.000000, -442.000000)" fill="#FFFFFF" fill-rule="nonzero">
                              <g transform="translate(1716.000000, 291.000000)">
                                <g transform="translate(304.000000, 151.000000)">
                                  <polygon class="color-background" opacity="0.596981957" points="18.0883333 15.7316667 11.1783333 8.82166667 13.3333333 6.66666667 6.66666667 0 0 6.66666667 6.66666667 13.3333333 8.82166667 11.1783333 15.315 17.6716667"></polygon>
                                  <path class="color-background" d="M31.5666667,23.2333333 C31.0516667,23.2933333 30.53,23.3333333 30,23.3333333 C29.4916667,23.3333333 28.9866667,23.3033333 28.48,23.245 L22.4116667,30.7433333 L29.9416667,38.2733333 C32.2433333,40.575 35.9733333,40.575 38.275,38.2733333 L38.275,38.2733333 C40.5766667,35.9716667 40.5766667,32.2416667 38.275,29.94 L31.5666667,23.2333333 Z" opacity="0.596981957"></path>
                                  <path class="color-background" d="M33.785,11.285 L28.715,6.215 L34.0616667,0.868333333 C32.82,0.315 31.4483333,0 30,0 C24.4766667,0 20,4.47666667 20,10 C20,10.99 20.1483333,11.9433333 20.4166667,12.8466667 L2.435,27.3966667 C0.95,28.7083333 0.0633333333,30.595 0.00333333333,32.5733333 C-0.0583333333,34.5533333 0.71,36.4916667 2.11,37.89 C3.47,39.2516667 5.27833333,40 7.20166667,40 C9.26666667,40 11.2366667,39.1133333 12.6033333,37.565 L27.1533333,19.5833333 C28.0566667,19.8516667 29.01,20 30,20 C35.5233333,20 40,15.5233333 40,10 C40,8.55166667 39.685,7.18 39.1316667,5.93666667 L33.785,11.285 Z"></path>
                                </g>
                              </g>
                            </g>
                    </g>
              </svg>
            </div>
            <span class="nav-link-text ms-1">Manage Admin</span>
          </a>
          		<ul id="manageUserDropdown2" class="collapse" style="list-style: none;">
                    <li class="nav-item">
                    	<a class="nav-link " id="hover-link" href="add_admin.jsp">
                        <span class="nav-link-text" style="padding-left: 35px;">Add Admin</span>
                        </a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link " id="hover-link" href="view_admin.jsp" >
                        <span class="nav-link-text" style="padding-left: 35px; ">View Admin</span>
                        </a>
                    </li>
               	</ul>
        </li>
      </ul>
    </div>
  </aside>

<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
<!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur" navbar-scroll="true">
        <div class="container-fluid py-1 px-3">
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
              <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="dashboard.jsp">Admin</a></li>
              <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Digital Wallet</li>
            </ol>
            <h6 class="font-weight-bolder mb-0">Admin Profile</h6>
          </nav>
          <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
            <div class="ms-md-auto pe-md-3 d-flex align-items-center">
              <div class="input-group">
                </div>
            </div>
            <ul class="navbar-nav  justify-content-end">
              <li class="nav-item d-flex align-items-center">
                <a href="logout.jsp" class="nav-link text-body font-weight-bold px-0" id="hover-link">
                  <i class="fa fa-user me-sm-1"></i>
                  <span class="d-sm-inline d-none">LogOut</span>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
 		
 		<div class="main-content position-relative max-height-vh-100 h-100">
        
        	<div class="w-100 position-relative" style="padding-left:2rem;">
                    <div class="d-flex justify-content-between align-items-end">
                        <div class="d-flex align-items-center">
                        
                            <div class="avatar avatar-xl position-relative me-3">
                                <img src="<%= profilePic %>"  alt="profile_image"
                                    class="w-100 border-radius-lg shadow-sm imgborder">
                            </div>
                            <div>
                                <h5 class="mb-1 text-white font-weight-bolder" id="hover-text">
                                    Admin
                                </h5>
                                <h5 class="mb-1 text-white font-weight-bolder" id="hover-text">
                                    <%= username %>
                                </h5>
                                
                            </div>
                            
                        </div>
                    </div>
                </div>
                
        <div class="container-fluid py-4">
            <div class="row d-flex justify-content-center">
                <div class="col-12 col-xl-9">
                    <div class="card_admin h-100 glass-effect">
                        <div class="card-header pb-0 p-3 bg-transparent">
                            <div class="row">
                                <div class="col-md-8 d-flex align-items-center">
                                    <h5 class="mb-0 text-white">Admin Profile</h5>
                                </div>
                            </div>
                        </div>
                        <div class="card-body p-3">
                            <% String successMessage = (String) request.getAttribute("successMessage"); %>
							<% if (successMessage != null) { %>
							    <div class="alert alert-success">
							        <%= successMessage %>
							    </div>
							<% } %>
							
							<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
							<% if (errorMessage != null) { %>
							    <div class="alert alert-danger">
							        <%= errorMessage %>
							    </div>
							<% } %>

<form action="AdminProfileServlet" method="post" enctype="multipart/form-data">

 <input type="hidden" name="id" value="<%= id %>">
 <input type="hidden" name="username" value="<%= username %>">
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
               <label class="form-control-label text-white">ID</label>
                <input type="text" class="form-control transparent-input" name="id" value="<%= id %>" readonly>
      
               
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
             <label class="form-control-label text-white">Email</label>
                <input type="email" class="form-control transparent-input"name="email" value="<%= email %>" required>
                               
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
             
                  <label class="form-control-label text-white">Mobile</label>
                  <input type="text" name="phone"
					id="phone_num" class="form-control transparent-input"
					value="<%= phone %>" placeholder="+959" maxlength="15" pattern="(\+959|959)[0-9]{8,11}"
					title="Phone number must start with +959 or 959, followed by 8 to 11 digits." required>
					
             </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group">
            <label class="form-control-label text-white">Profile Picture</label>
            
<input type="hidden" name="existingProfilePic" value="<%= profilePic %>">

    
    <input type="file" class="form-control transparent-input mt-2" name="profilePic" id="profilePicInput" accept="image/*">
</div>

<script>
document.getElementById("profilePicInput").addEventListener("change", function(event) {
    var file = event.target.files[0];
    if (file) {
        var reader = new FileReader();
        reader.onload = function(){
            document.getElementById("profilePreview").src = reader.result;
        };
        reader.readAsDataURL(file);
        
        // Show selected file name
        document.getElementById("fileName").innerText = "Selected: " + file.name;
    } else {
        // If no file is selected, keep the existing profile picture
        document.getElementById("profilePreview").src = "<%= profilePic %>";
    }
});
</script>        </div>
    </div>
    
    <div class="d-flex justify-content-end mt-4 custom-gap">
        <a href="admin_profile.jsp" class="btn m-0 text-white cancel-btn">Cancel</a>
        <button type="submit" class="btn text-white m-0 confirm-btn">Save</button>
    </div>
</form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer pt-3  ">
        <div class="container-fluid">
          <div class="row align-items-center justify-content-lg-between">
            <div class="col-lg-6 mb-lg-0 mb-4">
              <div class="copyright text-center text-sm text-muted text-lg-start">
               Copyright © <script>
                  document.write(new Date().getFullYear())
                </script>,
                made with <i class="fa fa-money"></i> by <span class="font-weight-bold">Digital Wallet Team</span> for a better web.
              </div>
            </div>
            <div class="col-lg-6">
              <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                <li class="nav-item">
                  <a href="#" class="nav-link text-muted" target="_blank">Digital Wallet Team</a>
                </li>
                <li class="nav-item">
                  <a href="#" class="nav-link text-muted" target="_blank">About Us</a>
                </li>
                <li class="nav-item">
                  <a href="#" class="nav-link text-muted" target="_blank">Blog</a>
                </li>
                <li class="nav-item">
                  <a href="#" class="nav-link pe-0 text-muted" target="_blank">License</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </footer>

    </div>

</main>

<!--   Core JS Files   -->
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min2.js"></script>
  <script src="js/perfect-scrollbar.min.js"></script>
  <script src="js/smooth-scrollbar.min.js"></script>
  <script src="js/chartjs.min.js"></script>

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
</body>

</html>