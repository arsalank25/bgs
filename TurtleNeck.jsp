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
			<span style="color: orange">T</span>urtle Neck Sweaters
		</h1>

		<table style="width: 100%">
			<%
				// Get product name to search for
				String name = request.getParameter("productColour");
				String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
				String uid = "group11";
				String pw = "group11";
				Connection con = null;
				double price = 0.0;
				int productId = 0;
				String productStyle, productSize = "";
				String productColour, link, sql = "";

				PreparedStatement prep = null;
				try {
					Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
					con = DriverManager.getConnection(url, uid, pw);
					sql = "SELECT pId,style,color,price,size FROM Product WHERE style = 'Turtle Neck'";
					prep = con.prepareStatement(sql);

					ResultSet rst = prep.executeQuery();
					String img = null;

					int count = 0;

					while (rst.next()) {
						if (count == 4) {
			%><tr></tr>
			<%
				count = 0;
						} else {
							count++;
							
							productId = rst.getInt("pId");
							img = "images/product" + productId + ".jpg";
							
							productColour = rst.getString("color");
							price = rst.getDouble("price");
							productStyle = rst.getString("style");
							productSize = rst.getString("size");
							
							link = "addcart.jsp?id=" + productId + "&name="+ productStyle + "&price=" + price;
			%>

			<th>
			<td><img src=<%=img %> style="width: 150px; height: 100px;">
			<p>
								
									<b><%out.print('\n' + productStyle);%></b><br>	
									<% 	out.print("Available colour: " + productColour); %><br>
									<% out.print("Available size: " + productSize);%><br>
								
									<%NumberFormat currFormat = NumberFormat.getCurrencyInstance();
										out.print(currFormat.format(price));%>
								</p>
				<p>
					<a href=<%=link%>> Add to Cart </a>
				</p></td>
			</th>

			<%
				}
					}
			%>

		</table>

		<%
			} catch (SQLException ex) {
				System.err.println(ex);
			} finally {
				try {
					if (con != null) {
						con.close();
					}
				} catch (SQLException ex) {
					System.err.println(ex);
				}
			}
		%>
	
</body>
</html>