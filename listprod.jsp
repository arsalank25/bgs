<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="javax.imageio.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<title>Shop</title>
</head>
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
		<li class="dropdown"><a class="active" href="listprod.jsp" class="dropbtn">Shop</a>
			<div class="dropdown-content">
				<a href="TurtleNeck.jsp">Turtle Neck</a>
				<a href="T-Shirt.jsp">T-Shirt</a>				
			</div></li>
		<li><a href="contact.jsp">Contact</a></li>
		
 <li style="float:right"><form method="get" action="listprod.jsp">
		<input type="text" name="productName" placeholder="Search.."> 
	</form></li>
	
	</ul>
	<br>

<!-- Search Menu -->
	<h4 style="font-family: Raleway;">
		<i>Shop by category</i>
		</h3>
		<form method="get" action="listprod.jsp">
			<input type="text" name="productName" size="50"> <input
				type="submit" value="Submit"><input type="reset"
				value="Reset"> 
		</form>
		<br>

<!-- Products listed in a Table -->
		<h1 style="font-family: Raleway;" align="center">
			<span style="color: orange">C</span>urrent Favourites
		</h1>
		<!--  Main product table -->
		<table style="width: 100%">
			<%
					// Get product name to search for
					String name = request.getParameter("productName");	
					boolean hasParameter = false;
					String sql = "";
					
					//Product Variables
					double price = 0.0;
					int productId = 0;
					String productColour, linkToCart, linkToWishList = "";
					String productStyle, productSize = "";
					String img = null;
					
					
										
					//Used for HTML formatting
					int ITEMS_PER_ROW = 4;
					int count = 0;
							
					//Choose which query we are performing
					if (name == null)
						name = "";
	
					if (name.equals("")) {						
						sql = "SELECT PID, color, size, style, price FROM Product";
						
					} else {						
						hasParameter = true;
						sql = "SELECT PID, color, size, style, price FROM Product WHERE style LIKE ?";
						name = '%' + name + '%';
					}

					
					//Connection Information		
					String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
					String uid = "group11";
					String pw = "group11";
					Connection con = null;
					NumberFormat currFormat = NumberFormat.getCurrencyInstance();
					
					//Main QUERY and Table generation
					try 
					{
						con = DriverManager.getConnection(url, uid, pw);
						PreparedStatement pstmt = con.prepareStatement(sql);
						if (hasParameter)
							pstmt.setString(1, name);

						ResultSet rst = pstmt.executeQuery();
						
						while (rst.next()) {

							if (count == ITEMS_PER_ROW) {
								out.print("<tr></tr>");
								count = 0;
							} else {
								count++;

								productId = rst.getInt("PID");
								img = "images/product" + productId + ".jpg";

								productColour = rst.getString("color");
								price = rst.getDouble("price");
								productStyle = rst.getString("style");
								productSize = rst.getString("size");

								linkToCart = "addcart.jsp?id=" + productId + "&name=" + productStyle + "&price=" + price;
								//linkToWishList = "wishlist.jsp?id=" + productId + "&name=" + productStyle + "&price=" + price;
								
								out.print("<th><td><img src="+img+" style=\"width: 150px; height: 100px;\"><p><b>"+
								productStyle+"</b><br>");
				
										 	out.print("Available colour: " + productColour); %><br>
										<% out.print("Available size: " + productSize);%><br>
									
										<%NumberFormat.getCurrencyInstance();
											out.print(currFormat.format(price));%>
									</p>
									<p>
										<a href=<%=linkToCart%>> Add to Cart </a>
										<!--  insert link to save items to wishlist once "add to cart" works -->
									</p></td>
								</th>

								<%
									}
										}
						out.println("</table>");
					} 
					catch (SQLException ex) 
					{
						out.println(ex);
					} 
					finally 
					{
						try 
						{
							if (con != null)
								con.close();
						} 
						catch (SQLException ex) 
						{
							out.println(ex);
						}
					}
				%>
	
</body>
</html>