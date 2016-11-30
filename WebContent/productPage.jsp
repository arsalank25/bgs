<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
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
<title>Product Page</title>
</head>

<%

	String productID = request.getParameter("productID");
	System.out.println("ProductID: "+productID);
	
	Connection con = null;
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
	String uid = "group11";
	String pw = "group11";
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	con = DriverManager.getConnection(url, uid, pw);
%>


<body>
	<!-- Navigation menus -->
	<!-- class="active" is used to change the colour of the tab of which page the user is on -->

	<ul>
		<li style="float: left"><img src="images/BGSLogo.jpg"
			style="width: 50px; height: 50px;"></li>
		<li style="float: right"><a class="active" href="login.jsp">Account
				<i class="fa fa-user-circle" aria-hidden="true"></i>
		</a></li>
		<li style="float: right"><a href="#about">WishList <i
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
	<!--  END OF NAVIGATION MENU -->

	<table id="productPageTable" style="width: 100%">
		<colgroup>
			<col style="width: 20%" />
			<col style="width: 33%" />
			<col style="width: 33%" />
		</colgroup>


		<!--  TITLES -->
		<tr>
			<th style="font-family: Abel;">Categories</th>
			<th>image[placeholder]</th>
			<th>Details [placeholder]
		</tr>
		<!-- END OF TITLES -->
		<tr>
			<td><br></td>
		</tr>

		<!--  CONTENT -->

		<tr>
			<td align="center" style="text-decoration: none"><a href="listprod.jsp?productName=turtle+neck">Turtle Neck</a></td>
			<td align="center">[image here]</td>
			<td align="center">product name here[placeholder]<br>
			<p>Web ID: [pID]</p></td>
		</tr>

		<tr>
			<td align="center"><a href="listprod.jsp?productName=t-shirt">T-Shirt</a></td>
			<td></td>
			<td align="center"><b style="color: orange"><strong>CA$[price]</strong></b></td>
		</tr>


		<tr>
			<td align="center"><a href="listprod.jsp?productName=jacket">Jacket</a>
			<td></td>

			<td align="center"><br><b>Availability:</b> [inventory]<br> <b>Color:</b>
				[color]<br> <b>Size:</b> [size]</td>


			</td>
		</tr>


		<tr>
			<td align="center"><a href="listprod.jsp?productName=pjs">Pjs</a></td>
		</tr>

		<!--  END OF CONTENT -->
	</table>




</body>
</html>