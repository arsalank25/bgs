<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.net.*"%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet"
	href="images/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Abel" />
<script>
	function validateForm() {
		var x = document.forms["loginForm"]["uname"].value;
		if (x == "") {
			alert("Please enter your username");
			return false;
		}

		var y = document.forms["loginForm"]["psw"].value;
		if (y == "") {
			alert("Please enter your password");
			return false;
		}
	}
</script>
<title>Log In</title>
</head>
<body>
	<!-- Navigation menus -->
	<!-- class="active" is used to change the colour of the tab of which page the user is on -->

	<ul>
		<li style="float: left"><img src="images/BGSLogo.jpg"
			style="width: 50px; height: 50px;"></li>
		<li class="dropdown" style="float: right"><a class="dropbtn"
			href="login.jsp">Account <i class="fa fa-user-circle"
				aria-hidden="true"></i></a>
			<div class="dropdown-content">
				<a href="logout.jsp">Logout</a>
			</div></li>
		<li style="float: right"><a href="wishList.jsp">WishList <i
				class="fa fa-heart" aria-hidden="true"></i></a></li>
		<li style="float: right"><a href="showcart.jsp">Cart <i
				class="fa fa-shopping-cart" aria-hidden="true"></i></a></li>

		<li><a href="shop.html">Home</a></li>
		<li class="dropdown"><a href="listprod.jsp" class="dropbtn">Shop</a>
			<div class="dropdown-content">
				<a href="TurtleNeck.jsp">Turtle Neck</a> <a href="T-Shirt.jsp">T-Shirt</a>
			</div></li>
		<li><a href="contact.jsp">Contact</a></li>
		<li style="float: left";>
			<div style="margin-left: auto; margin-right: auto; width: 50%;">
				<form align="center" method="get" action="listprod.jsp">
					<input type="text" name="productName" size="50"
						placeholder="Search.. Example: Red XL Wool"> <input
						type="submit" value="Submit"> <input type="submit"
						value="Clear Searches">
				</form>
			</div>
		</li>
	</ul>

	<br>

	<%
	
		//Get URL of reffering page
		URL refUrl = new URL(request.getHeader("referer")); 		
		System.out.println("\nLogin reffered from "+ refUrl.getPath());		
		
		//Get the reffering URL from the POST (do this because login reffers back to itself during login)	
		String fromURL = request.getParameter("from");
		System.out.print("\nLogin > FromURL > "+fromURL);
		
		//Get info from form
		String customerUserName = request.getParameter("uname");
		String password = request.getParameter("psw");
		

		//Check whether we are already logged in
		@SuppressWarnings({ "unchecked" })
		HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");

		//Not logged in, no userSession 
		if (userSession == null) {
			if (!(customerUserName == null || password == null)) {

				// No user session currently in list.  Create a user session list.
				userSession = new HashMap<String, String>();

				//Create new connection
				String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
				String uid = "group11";
				String pw = "group11";
				Connection con = null;

				String sql = "SELECT customerID, firstName, lastName, email, province, accessLevel FROM Customer WHERE password = ? AND customerUserName = ?";

				try {

					con = DriverManager.getConnection(url, uid, pw);
					PreparedStatement prep = con.prepareStatement(sql);

					prep.setString(1, password);
					prep.setString(2, customerUserName);

					ResultSet rs = prep.executeQuery();

					if (rs.next()) {

						//Add info from database to user session
						userSession.put("CustomerID", rs.getString("CustomerID"));
						userSession.put("FirstName", rs.getString("FirstName"));
						userSession.put("LastName", rs.getString("LastName"));
						userSession.put("email", rs.getString("email"));
						userSession.put("province", rs.getString("province"));
						System.out.print("\nLogged in access level is: "+rs.getString("accessLevel"));
						userSession.put("isAdmin",String.valueOf(rs.getInt("accessLevel")));
						
						//Update Session Variables					
						session.setAttribute("userSession", userSession);
						
						//Load users existing cart						
						response.sendRedirect("loadCart.jsp?from="+fromURL);
												
						
					}else{
						
						//Database query unsuccessful, don't create session and print error
						session.removeAttribute("userSession");
						out.print("<h1>Username Password combination invalid</h1>");
					}					

				} catch (SQLException ex) {
					String fullClassName = ex.getStackTrace()[2].getClassName();
					String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
					String methodName = ex.getStackTrace()[2].getMethodName();
					int lineNumber = ex.getStackTrace()[2].getLineNumber();
					out.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);

					//Don't create session. 			
					session.removeAttribute("userSession");
				}
			}

			//Login Form Html
			out.print(
					"<form name=\"loginForm\" method=\"POST\" action=\"login.jsp?from="+refUrl.toString()+"\" onsubmit=\"return validateForm()\">");
			out.print("<div class=\"imgcontainer\">");
			out.print("</div>");
			out.print("<div class=\"container\">");
			out.print("<label><b>Username</b></label>");
			out.print("<input type=\"text\" placeholder=\"Enter Username\" name=\"uname\" required>");
			out.print("<label><b>Password</b></label>");
			out.print("<input type=\"password\" placeholder=\"Enter Password\" name=\"psw\" required>");
			out.print("<button type=\"submit\">Login</button>");
			out.print("</div>");
			out.print("</form>");
			out.print("<form name=\"signupForm\" action=\"SignUp.html\">");
			out.print("<div id=\"member\"><button  class=\"cancelbtn\">Not a member?</button></div>");
			out.print("</form>");

			//Already Logged in
		} else {
			out.print("<h1 align=\"center\" >Already Logged in as " + userSession.get("FirstName") + "</h1>");

		}
	%>


</body>
</html>
