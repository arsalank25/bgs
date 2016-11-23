<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
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

<style>
form {
    border: 3px solid #f1f1f1;
}

input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

button {
    background-color: orange;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

.cancelbtn {
    width: auto;
    padding: 10px 18px;
    background-color: #f44336;
}

.imgcontainer {
    text-align: center;
   margin-top: 5px;
    margin-bottom: 5px;
    margin-right: 150px;
    margin-left: 80px;
}

img.avatar {
    width: 40%;
    border-radius: 50%;
}

.container {
    padding: 16px;
    font-family: "Raleway";

}

span.psw {
    float: right;
    padding-top: 16px;
}




ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background-color: #FFFFFF;
}

li {
	float: left;
}

li a {
	display: block;
	color: black;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
	font-family: "Raleway";
	font-weight: bold;
}

li a:hover {
	background-color: #C0C0C0;
}

.active {
	background-color: #4CAF50;
}

li.dropdown {
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	text-align: left;
}

.dropdown-content a:hover {
	background-color: #f1f1f1
}

.dropdown:hover .dropdown-content {
	display: block;
}

p {
	font-family: "Raleway";
}
</style>
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
				<a href="listprod.jsp">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
					3</a>
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
