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

<title>Product Page</title>
</head>
			
				
				
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
	
	<div></div>

<%	
	

	String productID = request.getParameter("productID");
	System.out.println("ProductID: "+productID);
	
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection con = null;
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
	String uid = "group11";
	String pw = "group11";
	
	con = DriverManager.getConnection(url, uid, pw);
	ResultSet res = null ;
	String color,material, brand, size ,sql,sqlUser,style,image = "";
	int weight ,inventory=0;
	double price = 0.0;
	String img = "images/product" + productID + ".jpg";
	PreparedStatement pstmtUser;

 	
	

	
	try{
		// Make database connection
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			 	con = DriverManager.getConnection(url,uid,pw);				
					
			 	PreparedStatement pstmt;
				sql = "SELECT * FROM Product WHERE pID= ?" ; // gets the product which was passed in so that the content can be retrieved
				
				pstmt = con.prepareStatement(sql);			
				
				pstmt.setString(1, productID);
				
				
				res =pstmt.executeQuery();
				res.next();
				color = res.getString("color");
				material = res.getString("material");
				brand= res.getString("brand");
				size= res.getString("size");
				style= res.getString("style");
				image= res.getString("image");
				weight= res.getInt("weight");
				inventory= res.getInt("inventory");
				price =res.getDouble("price");
				
				

				sql = "SELECT * FROM Review WHERE pID= ?" ; // gets the review 

				pstmt = con.prepareStatement(sql);			
				
				pstmt.setString(1, productID);
				res =pstmt.executeQuery();
				
				while (res.next()){
				sqlUser = "SELECT customerUserName FROM Customer WHERE customerID=" +res.getInt("customerID");//these get the username for the review from the Customer table
				pstmtUser = con.prepareStatement(sql);			//
				pstmtUser.setString(1, productID);//
				ResultSet resUser =pstmt.executeQuery();//
				
				resUser.next();
				String uName = resUser.getString("customerUserName");  // Use this User name for review
				String theComment = res.getString("Comment"); // the text inside a review
				int stars = res.getInt("Stars");  // the number of stars a product got
				
						
				java.util.Date date = new java.util.Date(); // gets back dateAndTime which tell when review was added 
	            date = res.getTime("dateAndTime");
	            String dateAndTime = date.toString();		
					
					//-------------------- please add your review code here so that it runs a few times to generate output for all review in review table taht are associated to one product 
					
				
					
					//-----------------
				}
				out.print("<br><br><div style=\"background-color: grey; \"><h2>"+style+"</h2></div>");	
				out.print("<table><tr><img src=" + img + " style=\"width: 150px; height: 100px;\"></td><tr></table>");
				
					
		
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
			}
	}
	
}
	
%>




<% %>

</body>
</html>