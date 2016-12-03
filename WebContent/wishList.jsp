<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet"
	href="images/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Abel" />
<title>Shop</title>
</head>
<body>
	<!-- Navigation menus -->
	<!-- class="active" is used to change the colour of the tab of which page the user is on -->
	<ul>
		<li style="float: left"><img src="images/BGSLogo.jpg"
			style="width: 50px; height: 50px;"></li>
		<li style="float: right"><a href="login.jsp">Account <i
				class="fa fa-user-circle" aria-hidden="true"></i></a></li>
		<li style="float: right"><a href="wishList.jsp">WishList <i
				class="fa fa-heart" aria-hidden="true"></i></a></li>
		<%
			HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
					.getAttribute("productList");

			int cartQTY = 0;
			String color = "black";
			if (productList != null) {
				int size = productList.size();
				color = size > 0 ? "orange" : "black";
				cartQTY = size;
			}
			out.print("<li style=\"float: right\"><a href=\"showcart.jsp\">Cart (" + cartQTY + ") <i style=\"color:"
					+ color + ";\" class=\"fa fa-shopping-cart\" aria-hidden=\"true\"></i></a></li>");
		%>
		<li><a class="active" href="shop.html">Home</a></li>
		<li><a href="listprod.jsp">Shop</a></li>
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
	
	<br>
	<div class="divider"><h2>Wishlist</h2></div>

	<%
		//Get user Session
		HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");

		//Variable for display layout
		final int ITEMS_PER_ROW = 5;

		//Array list to check if product ID already exists in wishlist
		ArrayList<Integer> prodList = new ArrayList<Integer>();	
				
		System.out.printf("\nUser is %s logged in", (userSession == null) ? "Not" : "");

		if (userSession != null) {
			int customerId = (int) Integer.parseInt(userSession.get("CustomerID"));

			//Create new connection
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
			String uid = "group11";
			String pw = "group11";
			Connection con = null;
			String sql;

			try {

				// Display Wish list //			
				
				con = DriverManager.getConnection(url, uid, pw);
				sql = "SELECT P.* from Product P, Wishlist W WHERE P.pID = W.pID AND customerId = ?";
				PreparedStatement prep = con.prepareStatement(sql);
				prep.setInt(1, customerId);
				ResultSet rs = prep.executeQuery();

				//Declare product variables for printing	
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				double price = 0.0;
				int productId = 0;
				String productColour, link = "";
				String productStyle, productSize = "";
				String img = null;

				int count = 0;

				out.print("<table style=\"width: 100%\">");

				while (rs.next()) {

					if (count == ITEMS_PER_ROW) {
						out.print("<tr></tr>");
						count = 0;
					} else {
						count++;

						productId = rs.getInt("PID");
						//Add product to list
						prodList.add(productId);
						
						img = "images/product" + productId + ".jpg";

						productColour = rs.getString("color");
						price = rs.getDouble("price");
						productStyle = rs.getString("style");
						productSize = rs.getString("size");

						out.print("<th><td><a href=\"productPage.jsp?productID=" + productId + "\"><img src=" + img
								+ " style=\"width: 150px; height: 100px;\"></a>");

						out.print("<p><b>" + productStyle + "</b>");
						out.print("<br>Available colour: " + productColour);
						out.print("<br>Available size: " + productSize);

						NumberFormat.getCurrencyInstance();
						out.print("<br>" + currFormat.format(price));
						out.print("</p><p>");
						out.print("<a href=\"addcart.jsp?id=" + productId + "&name=" + productStyle);
						out.print("&price=" + price + "\"> Add to Cart </a></p>");
						out.print("<p><a href=\"wishList.jsp?id=" + productId
								+ "> Add to Wish list </a></p></td></th>");
					}
				}
				con.close();
				out.println("</table>");

				// Add product //

				//Get product ID for adding if there is one. 

				if (request.getParameter("id") != null) {					
					int addProductId = Integer.parseInt(request.getParameter("id"));
					System.out.print("\nParameter ID found: "+addProductId);

					if (!(prodList.contains(addProductId))) {	
						con = DriverManager.getConnection(url, uid, pw);
						System.out.print("\nInserting product "+addProductId+" for customer "+customerId);
						sql = "INSERT INTO Wishlist (customerID,pID) VALUES (?,?)";
						prep = con.prepareStatement(sql);
						prep.setInt(1, customerId);
						prep.setInt(2, addProductId);
						prep.executeUpdate();	
						System.out.print("Finished inserting product "+addProductId+" for customer "+customerId);
						response.sendRedirect("wishList.jsp");
						
					}
					

				}

			} catch (SQLException ex) {
				String fullClassName = ex.getStackTrace()[2].getClassName();
				String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
				String methodName = ex.getStackTrace()[2].getMethodName();
				int lineNumber = ex.getStackTrace()[2].getLineNumber();
				out.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
			}catch(Exception e){
				out.print(e.toString());
			}
		} else {
			System.out.print("Not logged in");
			out.print("<br><h2 align=\"center\">Wishlist available for registered users only. Please Log in</h2>");
		}
	%>
</body>
</html>
