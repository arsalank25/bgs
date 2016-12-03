<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="images/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Abel" />
<title>Contact Us</title>
</head>
<body>
<!-- Navigation menus -->
<!-- class="active" is used to change the colour of the tab of which page the user is on -->


<ul>		
		<li style="float:left"><img src="images/BGSLogo.jpg" style="width:50px;height:50px;"></li>
		<li style="float: right"><a href="login.jsp">Account <i class="fa fa-user-circle" aria-hidden="true"></i></a></li>
		<li style="float: right"><a href="wishList.jsp">WishList <i class="fa fa-heart" aria-hidden="true"></i></a></li>		
		<li style="float: right"><a href="showcart.jsp">Cart <i class="fa fa-shopping-cart" aria-hidden="true"></i></a></li>
		
	
		
 <li><a class="active" href="shop.html">Home</a></li>
 <li><a href="listprod.jsp">Shop</a></li>
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
	<br>


<h2 style="font-family:Abel;"><span style="color:orange;">C</span>ontact Us</h2>
<p>You will receive a response within 24 hours</p>

<!--  Taylor's email is a placement holder  -->
<form action="taylorjsie@gmail.com" method="post" enctype="text/plain">
Name:<br>
<input type="text" name="name"><br>
E-mail:<br>
<input type="text" name="mail"><br>
Comment:<br>
<input type="text" name="comment" size="50"><br><br>
<input type="submit" value="Send">
<input type="reset" value="Reset">
</form>

</body>

</html>
