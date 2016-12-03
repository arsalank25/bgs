<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.apache.commons.validator.EmailValidator" %>
<%@ page import="java.util.regex.*" %>

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

<%
// Add new product selected
// Get product information CustomerUserName


String customerUserName = request.getParameter("uname");
String firstName = request.getParameter("fname");
String lastName = request.getParameter("lname");
String email = request.getParameter("email");
String password = request.getParameter("psw");
String houseNo = request.getParameter("housenum");
String street = request.getParameter("street");
String city = request.getParameter("city");
String province = request.getParameter("province");
String postalCode = request.getParameter("postalCode");



String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
String uid = "group11";
String pw = "group11";
Connection con = null; 
ResultSet res, res2,  keys, resCustName = null;
String sql, sql2, insertProduct, update, insert, getCustName = "";
EmailValidator validator = EmailValidator.getInstance();
String regex = "^(?!.*[DFIOQU])[A-VXY][0-9][A-Z] ?[0-9][A-Z][0-9]$";//for postal code validation 
Pattern pattern = Pattern.compile(regex);
Matcher matcher = pattern.matcher(postalCode);


if(firstName.equals(null) || firstName.equals("")){    // Determine if invalid customer idname was entered
	%>
	<h2> out.println("Invalid First Name. Go back to the previous page and try again."); </h2> 
	<% 
}else if (customerUserName.equals(null) || customerUserName.equals("")){ // Determine if there are products in the shopping cart
	%>
	<h2> out.println("Invalid User Name. Go back to the previous page and try again."); </h2>  
	<%
}
else if (password.equals(null) || password.equals("")){ // Determine if there are products in the shopping cart
	%>
	<h2> out.println("Invalid User password. Go back to the previous page and try again."); </h2>  
	<%
}


else if (!validator.isValid(email)){ // Determine if there are products in the shopping cart
	%>
	<h2> out.println("Invalid email. Go back to the previous page and try again."); </h2>  
	<%
}else if(houseNo.equals(null) || houseNo.equals("")){    // Determine if invalid customer idname was entered
	%>
	<h2> out.println("Invalid houseNo. Go back to the previous page and try again."); </h2> 
	<% 
}else if (postalCode.equals(null) || postalCode.equals("")){ // Determine if there are products in the shopping cart
	%>
	<h2> out.println("Invalid postalCode. Go back to the previous page and try again."); </h2>  
	<%
}
else if (province.equals(null) || province.equals("") || province.length() != 2){ // Determine if there are products in the shopping cart
	%>
	<h2> out.println("Invalid User province. Go back to the previous page and try again."); </h2>  
	<%
	break;
}


	try{
		// Make database connection
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			 	con = DriverManager.getConnection(url,uid,pw);				
				PreparedStatement pstmt;	
				
				
				sql = " SELECT customerUserName,email FROM Customer WHERE customerUserName = ? OR email = ? ";
				pstmt  = con.prepareStatement(sql);
				pstmt.setString(1, customerUserName);
				pstmt.setString(2, email);
				resCustName = pstmt.executeQuery();
				if(resCustName.next()){
					%>
					<h2> out.println("The user name or Email already exists, go back and try agian"); </h2>  
					<%
					
				}
				
				
				
				//customerID auto increments
				sql = "INSERT INTO Customer(customerUserName,password,firstName,lastName,email,houseNo,street,city,province,postalCode, accessLevel) VALUES (?,?,?,?,?,?,?,?,?,?,0)";//by defult the access level will be zero 
				
				pstmt = con.prepareStatement(sql);	
				
				
				pstmt.setString(1, customerUserName);
				pstmt.setString(2, password);
				pstmt.setString(3, firstName);
				pstmt.setString(4, lastName);
				pstmt.setString(5, email);
				pstmt.setString(6, houseNo);
				pstmt.setString(7, street);
				pstmt.setString(8, city);
				pstmt.setString(9, province);
				pstmt.setString(10, postalCode);
				pstmt.executeUpdate();					
				
				//No error, so log the user in
				out.print("<h1>Account Created, please login!<h1>");
				//Login Form Html
				out.print(
						"<form name=\"loginForm\" method=\"POST\" action=\"login.jsp\" onsubmit=\"return validateForm()\">");
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
				out.print("<button class=\"cancelbtn\">Not a member?</button>");
				out.print("</form>");
				
				
		
	}
	catch(SQLException ex){	
		String fullClassName = ex.getStackTrace()[2].getClassName();
	    String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
	    String methodName = ex.getStackTrace()[2].getMethodName();
	    int lineNumber = ex.getStackTrace()[2].getLineNumber();	
	    out.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
	}catch(Exception e){
		out.print(e.toString());
	}
	finally {
		if(con != null){
			try{
				con.close();
			}catch(SQLException ex){	
				out.println(ex);
			}finally{
				
		}
	}
	
}


%>
