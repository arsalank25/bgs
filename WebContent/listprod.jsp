<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="javax.imageio.*"%>

<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import= "java.io.File" %>
<!DOCTYPE html>
<html>
<head>
<style>
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
				<a href="listprod.jsp">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
					3</a>
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
			<span style="color: orange">C</span>urrent Favourites
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
				String productColour, link, sql = "";
				PreparedStatement prep = null;
				try {
					Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
					con = DriverManager.getConnection(url, uid, pw);
					if (name != null && !name.isEmpty()) { // search is not an empty search
						sql = "SELECT price FROM Product WHERE color LIKE '%"+ name + "%'";
						prep = con.prepareStatement(sql);
					} else { // no search, so show all products
						sql = "SELECT price FROM Product";
						prep = con.prepareStatement(sql);
					}
					ResultSet rst = prep.executeQuery();
					BufferedImage img = null;

					while (rst.next()) {
						productId = rst.getInt("price");
						/* img = ImageIO
								.read(new File("product" + productId + ".jpg")); */
						//productColour = rst.getString("color");
						price = rst.getDouble("price");
						//link = "addcart.jsp?id=" + productId + "&name="+ productColour + "&price=" + price;
			%>

			<tr>
				<div style="background-color: silver">
					<tr>
						<td><img src=img style="width: 150px; height: 100px;">
							<h4>
								<%
									//out.print('\n' + productColour);
								%>
							</h4>
							<p>
								<%
									NumberFormat currFormat = NumberFormat.getCurrencyInstance();
											out.print(currFormat.format(price));
								%>
							<!--  <a href=<%//=link%>> Add to Cart </a></p> -->
				</div>
				</td>
			</tr>
			<%
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