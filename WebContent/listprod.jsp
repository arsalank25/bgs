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
				<a href="TurtleNeck.jsp">Turtle Neck</a> <a href="T-Shirt.jsp">T-Shirt</a>
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
		<!--  Main product table -->
		<table style="width: 100%">
			<%
				// Get product name to search for
				String search = request.getParameter("productName");
				String[] searches;
				out.print("<h1>" + search + "</h1>");
				boolean hasParameter = false;
				String sql = "";
				final int MAX_SEARCH_ITEMS = 10;
				final int NUM_OF_COLS_SEARCHED = 5;

				//Product Variables
				double price = 0.0;
				int productId = 0;
				String productColour, link = "";
				String productStyle, productSize = "";
				String img = null;

				//Used for HTML formatting
				int ITEMS_PER_ROW = 5;
				int count = 0;

				//Choose which query we are performing
				if (search == null) {
					search = "";
					searches = new String[] { "" };
				} else {
					//Split the search up to look for multiple words
					searches = search.split("\\s+");
				}
				//Displaying everything
				if (search.equals("")) {
					sql = "SELECT PID, color, size, style, price FROM Product";

				//Searching
				} else {
					hasParameter = true;
					//Search every property column for the search word
					sql = "SELECT PID, color, size, style, price FROM Product WHERE (style LIKE ? OR color LIKE ? OR brand LIKE ? OR material LIKE ? OR size LIKE ?)";
					
					//If we have more than one search word, increase the sql statement
					for (int i = 1; i < searches.length && i < MAX_SEARCH_ITEMS; i++) {
						sql = sql + " AND (style LIKE ? OR color LIKE ? OR brand LIKE ? OR material LIKE ? OR size LIKE ?)";
					}
				}				
				
				//Connection Information		
				String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
				String uid = "group11";
				String pw = "group11";
				Connection con = null;
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();

				//Main QUERY and Table generation
				try {
					con = DriverManager.getConnection(url, uid, pw);
					PreparedStatement pstmt = con.prepareStatement(sql);
					//If there is a parameter (we are searching)
					if (hasParameter) {
						//Only allow a max of 5 search criteria						
						for (int i = 0; i < searches.length && i < MAX_SEARCH_ITEMS; i++) {
							searches[i] = '%' + searches[i] + '%';
							for (int j = 1; j <= NUM_OF_COLS_SEARCHED; j++) {
								pstmt.setString((NUM_OF_COLS_SEARCHED* i + j), searches[i]);
							}
						}
					}

					ResultSet rst = pstmt.executeQuery();
					
					//Display search results (or list of all products)
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

							out.print("<th><td><img src=" + img + " style=\"width: 150px; height: 100px;\">");

							out.print("<p><b>" + productStyle + "</b>");
							out.print("<br>Available colour: " + productColour);
							out.print("<br>Available size: " + productSize);

							NumberFormat.getCurrencyInstance();
							out.print("<br>" + currFormat.format(price));
							out.print("</p><p>");
							out.print("<a href=\"addcart.jsp?id=" + productId + "&name=" + productStyle);
							out.print("&price=" + price + "\"> Add to Cart </a></p></td></th>");
						}
					}
					out.println("</table>");
				} catch (SQLException ex) {
					out.println(ex);
				} finally {
					try {
						if (con != null)
							con.close();
					} catch (SQLException ex) {
						out.println(ex);
					}
				}
			%>
		
</body>
</html>