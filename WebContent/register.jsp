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


out.println(customerUserName);
out.println(firstName);
out.println(lastName);
out.println(email);
out.println(password);
out.println(houseNo);
out.println(street);

out.print(postalCode);

String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
String uid = "group11";
String pw = "group11";
Connection con = null; 
ResultSet res, res2,  keys, resCustName = null;
String sql, sql2, insertProduct, update, insert, getCustName = "";
PreparedStatement prep, prep2, insertPrep, updatePrep, pstmt, prepCustName = null;
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
}


	try{
		// Make database connection
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			 	con = DriverManager.getConnection(url,uid,pw);
				sql = "SELECT * FROM Customer WHERE customerUserName = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, customerUserName);
				res = pstmt.executeQuery();
				if (res.next()){// if there is next we will get user to make new username as it is present 
					%>
					<h2> out.println("The User name is not available. Go back to the previous page and try again."); </h2> 
					<% 
				}
				
				// Save order information to database
				
				sql = "SELECT MAX(customerID) AS lastID FROM Customer";
				prep = con.prepareStatement(sql);
				res = prep.executeQuery();
							
				//Yes I know this is weird. If we don't have res.next() it doesn't work, but 
				//if we put the assignment of customerID in an if statement, then we would need to declare
				//int customerID = 0; but that would be dangerous. 
				if (!res.next()){
					out.print("<br>No results<br>");
				}else{
					out.print("<br>res.getInt() = "+res.getInt("lastID")+"<br>");
				}
				int customerID = res.getInt("lastID")+1; // this gets the max id and adds one to make new id for new cust
				
				
				
				
				insert = "INSERT INTO Customer(customerID,customerUserName,password,firstName,lastName,email,houseNo,street,city,province,postalCode, accessLevel) VALUES (?,?,?,?,?,?,?,?,?,?,?,0)";//by defult the access level will be zero 
				prep2 = con.prepareStatement(insert);			
				prep2.setInt(1, customerID);
				prep2.setString(2, customerUserName);
				prep2.setString(3, password);
				prep2.setString(4, firstName);
				prep2.setString(5, lastName);
				prep2.setString(6, email);
				prep2.setString(7, houseNo);
				prep2.setString(8, street);
				prep2.setString(9, city);
				prep2.setString(10, province);
				prep2.setString(11, postalCode);
				prep2.executeUpdate();	
				
		
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
