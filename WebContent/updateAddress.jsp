<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.regex.*" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%




// Add new product selected
// Get product information CustomerUserName
int customerID = Integer.parseInt(request.getParameter("customerID"));// once the customer logs in, his id needs to be retrived and carried in the html so that their work is tracked
String houseNo = request.getParameter("houseNo");
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
PreparedStatement prep, prep2, insertPrep, updatePrep, pstmt, prepCustName = null;
String regex = "^(?!.*[DFIOQU])[A-VXY][0-9][A-Z] ?[0-9][A-Z][0-9]$";//for postal code validation 
Pattern pattern = Pattern.compile(regex);
Matcher matcher = pattern.matcher(postalCode);

if(houseNo.equals(null) || houseNo.equals("")){    // Determine if invalid customer idname was entered
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


else if (! matcher.matches()){ // Determine if there are products in the shopping cart
	%>
	<h2> out.println("Invalid Postal code. Go back to the previous page and try again."); </h2>  
	<%
}else {
	try{
		// Make database connection
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			 	con = DriverManager.getConnection(url,uid,pw);
				
				// Save order information to database
				
							
				update = "UPDATE  Customer SET houseNo= ?,street= ?,city= ?,province= ?,postalCode= ? WHERE customerID = ?";	
				prep = con.prepareStatement(update);	
				prep.setString(1, houseNo);
				prep.setString(2, street);
				prep.setString(3, city);
				prep.setString(4, province);
				prep.setString(5, postalCode);
				prep.setInt(5, customerID);
				
				prep.executeUpdate();			
							
				
		
		
		
	}
	catch(SQLException ex){	
		String fullClassName = ex.getStackTrace()[2].getClassName();
	    String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
	    String methodName = ex.getStackTrace()[2].getMethodName();
	    int lineNumber = ex.getStackTrace()[2].getLineNumber();	
	    System.err.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
	}
	finally {
		if(con != null){
			try{
				con.close();
			}catch(SQLException ex){	
				out.println(ex);
			}
		}
	}
	
}




%>
<jsp:forward page="showcart.jsp" />