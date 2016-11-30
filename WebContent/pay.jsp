<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet"
	href="images/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Abel" />

<title>Payment Complete!</title>
</head>


<body>
	<ul>	
		<li style="float:left"><img src="images/BGSLogo.jpg" style="width:50px;height:50px;"></li>	
		<li style="float: right"><a class="active" href="login.jsp">Account <i class="fa fa-user-circle" aria-hidden="true"></i></a></li>
		<li style="float: right"><a href="#about">WishList <i class="fa fa-heart" aria-hidden="true"></i></a></li>		
		<li style="float: right"><a href="showcart.jsp">Cart <i class="fa fa-shopping-cart" aria-hidden="true"></i></a></li>
		
		<li><a href="shop.html">Home</a></li>
		<li class="dropdown"><a href="listprod.jsp" class="dropbtn">Shop</a>
			<div class="dropdown-content">
				<a href="TurtleNeck.jsp">Turtle Neck</a> <a href="T-Shirt.jsp">T-Shirt</a>
			</div></li>
		<li><a href="contact.jsp">Contact</a></li>		
		<li style="float: left";>
		<div style="margin-left:auto;margin-right:auto;width: 50%;">		
		<form align="center" method="get" action="listprod.jsp">
			<input type="text" name="productName" size="50" placeholder="Search.. Example: Red XL Wool">			
			<input type="submit" value="Submit">
			<input type="submit" value="Clear Searches">
		</form>
		</div>
	</li>
	</ul>
	<h1 align="center" >Payment Complete! Thank you!</h1>
	<iframe id="yt" width="420" height="345" src="http://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1" frameborder="0" allowfullscreen></iframe>
	

	<%
	
	//Get user session
	HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");	
	
	int cartID = 0;
	int customerId = 0;
	
	//Make sure we have a cart and are logged in, because we're going to be adding it to the shipment list
	try {
		cartID = (int) Integer.parseInt(userSession.get("cartID"));
		customerId = (int) Integer.parseInt(userSession.get("CustomerID"));
	} catch (Exception e) {
		response.sendRedirect("login.jsp");
	}		

	
	//We are going to save the payment to the database
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection con = null;
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
	String uid = "group11";
	String pw = "group11";
	String sql;
		
	try{		
		//Add customers cart to shipment table		
		con = DriverManager.getConnection(url, uid, pw);
		sql = "INSERT INTO shipment (cID,customerID) VALUES (?,?)";
		
		PreparedStatement prep = con.prepareStatement(sql);
		
		prep.setInt(1, cartID);
		prep.setInt(2,customerId);
		
		prep.executeUpdate();
		
		//remove cart from session
		session.removeAttribute("productList");
		
	} catch (SQLException ex) {
		String fullClassName = ex.getStackTrace()[2].getClassName();
		String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
		String methodName = ex.getStackTrace()[2].getMethodName();
		int lineNumber = ex.getStackTrace()[2].getLineNumber();
		System.err.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
	}
		
		

		
	%>

	

	
</body>

</html>
