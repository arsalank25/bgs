<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
String uid = "group11";
String pw = "group11";
Connection con = null; 
ResultSet res, res2,  keys, resCustName = null;
String sql, sql2, insertProduct, update, insert, getCustName = "";
PreparedStatement prep, prep2, insertPrep, updatePrep, pstmt, prepCustName = null;

int customerId = 0;
boolean custumerIdNotANumber = false;

// Get customer id
int productID = Integer.parseInt(request.getParameter("productID"));
int customerID = Integer.parseInt(request.getParameter("customerID"));
String reviewText =  request.getParameter("reviewText");
int stars = Integer.parseInt(request.getParameter("stars"));
String boughtOrNot = "This customer Has not bought the item"

@SuppressWarnings({"unchecked"})



	try {
		// Make database connection
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	 	con = DriverManager.getConnection(url,uid,pw);
		sql = "SELECT * FROM CartContains INNER JOIN Shipment ON CartContains.cID =Shipment.cID    WHERE CartContains.customerId = ? AND pID= ?";
		prep = con.prepareStatement(sql);
		prep.setInt(1, customerId);
		prep.setInt(2, productID);
		res = prep.executeQuery();
		if (!res.next()){
			 boughtOrNot = "This customer Has bought the item"
		}
		
		// Save order information to database
		insert = "INSERT INTO Review(pID,customerId,comment,Stars,dateAndTime) VALUES (?,?,?,?,?)";		
					
		// Use retrieval of auto-generated keys.
		
		pstmt.setInt(1, pID);	
		pstmt.setInt(2, customerId);
		pstmt.setString(3, comment);
		pstmt.setInt(4, Stars);
		pstmt.setDate(5, java.sql.Date.valueOf(java.time.LocalDate.now()));
		pstmt.setInt(6, Stars);
		
		
		
		pstmt.executeUpdate();
	
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


%>
</BODY>
</HTML>

