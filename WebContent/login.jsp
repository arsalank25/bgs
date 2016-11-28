<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
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

<% Connection con = null;
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
String uid = "group11";
String pw = "group11";
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
con = DriverManager.getConnection(url,uid,pw); %>


<body>
<!-- Navigation menus -->
<!-- class="active" is used to change the colour of the tab of which page the user is on -->

	<ul>
		<li style="float: right"><a href="login.jsp">Account</a></li>
		<li style="float: right"><a href="#about">WishList</a></li>
		<li style="float: right"><a href="checkout.jsp">Check Out</a></li>
		<li style="float: right"><a href="showcart.jsp">Cart</a></li>
		
	</ul>
	<ul>
		<li><a href="shop.html">Home</a></li>
		<li class="dropdown"><a href="listprod.jsp" class="dropbtn">Shop</a>
			<div class="dropdown-content">
				<a href="TurtleNeck.jsp">Turtle Neck</a>
				<a href="T-Shirt.jsp">T-Shirt</a>
			</div></li>
		<li><a href="#contact">Contact</a></li>
		<li style="float: right"><input type="text" name="search"
			placeholder="Search.."></li>
	</ul>

	<br>



<form name="loginForm" action="listprod.jsp" onsubmit="return validateForm()">
  <div class="imgcontainer">
    <img src="images/BGSLogo.jpg" alt="Avatar" class="avatar">
  </div>

  <div class="container">
    <label><b>Username</b></label>
    <input type="text" placeholder="Enter Username" name="uname" required>

    <label><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" required>
        
    <button type="submit">Login</button>
    
  </div>
</form>


</body>
</html>
