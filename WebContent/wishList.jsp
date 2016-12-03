<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!-- Navigation menus -->
	<!-- class="active" is used to change the colour of the tab of which page the user is on -->
	<ul>		
		<li style="float:left"><img src="images/BGSLogo.jpg" style="width:50px;height:50px;"></li>
		<li style="float: right"><a href="login.jsp">Account <i class="fa fa-user-circle" aria-hidden="true"></i></a></li>
		<li style="float: right"><a href="#about">WishList <i class="fa fa-heart" aria-hidden="true"></i></a></li>
		
		<%		
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
		
		int cartQTY = 0;
		String color = "black";
		if (productList != null)
		{			
			int size = productList.size();
			color = size>0 ? "orange" : "black";
		  	cartQTY = size;
		}
		
		out.print("<li style=\"float: right\"><a href=\"showcart.jsp\">Cart ("+cartQTY+") <i style=\"color:"+color+";\" class=\"fa fa-shopping-cart\" aria-hidden=\"true\"></i></a></li>");
		%>
		
 <li><a class="active" href="shop.html">Home</a></li>
 <li><a href="listprod.jsp">Shop</a></li>
 <li><a href="contact.jsp">Contact</a></li>
			
		<li style="float: left";>
		<div style="margin-left:auto;margin-right:auto;width: 50%;">		
		<form align="center" method="get" action="listprod.jsp">
			<input type="text" name="productName" size="50" placeholder="Search.. Example: Red XL Wool">			
			<input type="submit" value="Submit">
			<input type="submit" value="Clear Searches">
		</form>
		</div>
	</li>
	</ul>



<%
	HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");

	if (userSession != null) {
		int customerId = (int) Integer.parseInt(userSession.get("CustomerID"));
		
		
		
		//Create new connection
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
		String uid = "group11";
		String pw = "group11";
		Connection con = null;	
		

		try {
			
			//First get current cart if it exists //Same code as from saveCart
			String sql = "SELECT MAX(C.cID) AS cartID FROM Cart C LEFT JOIN Shipment S ON C.cID = S.cID WHERE S.cID IS NULL AND C.customerID = ?";

			int cartID = 0;
					
			con = DriverManager.getConnection(url, uid, pw);
			PreparedStatement prep = con.prepareStatement(sql);
			//Set customerId
			prep.setInt(1, customerId);

			ResultSet rs = prep.executeQuery();
			System.out.println("Getting Current cart to load for user..."+ customerId);
			//If there is an active/current cart, then load it
			if (rs.next()) {
				cartID = rs.getInt("cartID");
				if (cartID > 0) {					
					//Load cart
					sql = "SELECT C.pID AS prodID,style,price,quantity FROM CartContains C,Product P WHERE C.PID = P.PID AND C.CID = ?";
					prep = con.prepareStatement(sql);

					prep.setInt(1, cartID);					

					rs = prep.executeQuery();

					//Add query results to session
					while (rs.next()) {						
						
						String id    = String.valueOf(rs.getInt("prodID"));
						String name  = rs.getString("style");				
						String price = String.valueOf(rs.getDouble("price"));
						int quantity = rs.getInt("quantity");
						
						System.out.println("Cart id: " +id);
						
						ArrayList<Object> product = new ArrayList<Object>();
						product.add(id);
						product.add(name);
						product.add(price);
						product.add(quantity);
						
						productList.put(id,product);
					}
					
					session.setAttribute("productList", productList);
				}
			}
			
			//Redirect to cart
			response.sendRedirect("showcart.jsp");	
			
			
			
		} catch (SQLException ex) {
			String fullClassName = ex.getStackTrace()[2].getClassName();
			String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
			String methodName = ex.getStackTrace()[2].getMethodName();
			int lineNumber = ex.getStackTrace()[2].getLineNumber();
			out.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
		}
	}else{
		out.print("<h2 align=\"center\">>Wishlist available for registered users only. Please Log in<h2>");		
	}
%>
