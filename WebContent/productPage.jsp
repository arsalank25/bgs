<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.*"%>
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
	<!--  END OF NAVIGATION MENU -->

	<div></div>

	<%
		//Get customerID
		HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");

		//Get parameters
		int productID = Integer.parseInt(request.getParameter("productID"));
		String reviewParam = request.getParameter("review");
		String deleteParam = request.getParameter("delete");
		System.out.println("ProductID: " + productID);

		//Connection information
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
		String uid = "group11";
		String pw = "group11";

		con = DriverManager.getConnection(url, uid, pw);
		ResultSet res = null;
		String color, material, brand, size, sql, sqlUser, style, image = "";
		int weight, inventory = 0;
		double price = 0.0;
		String img = "images/product" + productID + ".jpg";
		PreparedStatement pstmtUser;

		ArrayList<Integer> cusIDs = new ArrayList<Integer>();

		try {
			// Make database connection
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection(url, uid, pw);

			PreparedStatement pstmt;

			//Get product information
			sql = "SELECT * FROM Product WHERE pID= ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, productID);

			res = pstmt.executeQuery();
			res.next();
			color = res.getString("color");
			material = res.getString("material");
			brand = res.getString("brand");
			size = res.getString("size");
			style = res.getString("style");
			image = res.getString("image");
			weight = res.getInt("weight");
			inventory = res.getInt("inventory");
			price = res.getDouble("price");

			//Print out product information
			out.print("<br><br><div style=\"background-color: grey; \"><h2>" + style + "</h2></div>");
			out.print("<table style=\"margin: 0 auto;\" ><tr><td><img src=" + img
					+ " style=\"width: 200px; height: 200px;\"></td>");
			out.print("<td align=\"Left\" style=\"vertical-align: top;\"><b>Availability: </b>" + inventory
					+ "<br> <b>Color:</b>" + color + "<br> <b>Size:</b>" + size + "<br>");
			out.print("<a href=\"addcart.jsp?id=" + productID + "&name=" + style);
			out.print("&price=" + price + "\"> Add to Cart </a></p></td></tr></table>");

			//print list of existing reviews
			sql = "SELECT C.customerId,customerUserName,R.comment,R.stars FROM Review R,Customer C WHERE R.customerID = C.customerId AND pid = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productID);

			res = pstmt.executeQuery();

			
			
			int admin = 0;
			if (userSession != null) {
				System.out.print("Got session info");
				if (userSession.get("isAdmin") != null) {	
					System.out.print("Admin session info is not null");
					if ((Integer.parseInt(userSession.get("isAdmin"))) > 0) {
						admin = 1;							
				}
			}					
			}
			if (admin>0){
				out.print("<table><th>User</th><th>Review</th><th>Rating</th><th>Remove Comment<th>");	
			}else{
				out.print("<table><th>User</th><th>Review</th><th>Rating</th>");
			}
			while (res.next()) {
				cusIDs.add(res.getInt("customerId"));
				//Print table					
				out.print("<tr>");
				out.print("<td>" + res.getString("customerUserName") + "</td>");
				out.print("<td>" + res.getString("comment") + "</td>");
				out.print("<td>" + res.getString("stars") + "/5</td>");
				if(admin>0){
					out.print("<td><a href=\"productPage.jsp?productID=" + productID + "&delete="+ res.getInt("customerId") + "\">Remove</a></td>");
				}

				out.print("</tr>");
				
			}			
			out.print("</table>");

			//Add review if any
			if (reviewParam != null) {
				int customerId = (int) Integer.parseInt(userSession.get("CustomerID"));
				sql = "INSERT INTO Review(pID,customerId,comment,Stars,dateAndTime) VALUES (?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, productID);
				pstmt.setInt(2, customerId);
				pstmt.setString(3, reviewParam);
				pstmt.setInt(4, Integer.parseInt(request.getParameter("stars"))); //Number of stars
				// Get the system date and time.
				java.util.Date utilDate = new java.util.Date();
				// Convert it to java.sql.Date
				java.sql.Date date = new java.sql.Date(utilDate.getTime());
				pstmt.setDate(5, date);
				pstmt.executeUpdate();
				response.sendRedirect("productPage.jsp?productID=" + productID);
			}
			
			
			//Delete review
			if (deleteParam != null) {
				int customerId = Integer.parseInt(deleteParam);
				sql = "DELETE FROM Review WHERE customerId=? AND pID = ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, customerId);
				pstmt.setInt(2, productID);
				pstmt.executeUpdate();
				response.sendRedirect("productPage.jsp?productID=" + productID);
			}

			if (userSession != null) {
				int customerId = (int) Integer.parseInt(userSession.get("CustomerID"));
				if (!cusIDs.contains(customerId)) {
					out.print("<form action=\"productPage.jsp\" id=\"usrform\">");
					out.print("<input type=\"hidden\" name=\"productID\" value=\"" + productID + "\" />");
					out.print("</form>");
					out.print("<br>");
					out.print(
							"<textarea maxlength=\"100\" rows=\"4\" cols=\"50\" name=\"review\" form=\"usrform\"></textarea>");
					out.print("<br>Rating:<select form=\"usrform\" name=\"stars\">");
					out.print("  <option value=\"5\">5</option>");
					out.print(" <option value=\"4\">4</option>");
					out.print("  <option value=\"3\">3</option>");
					out.print("  <option value=\"2\">2</option>");
					out.print("  <option value=\"1\">1</option>");
					out.print("	</select>");
					out.print(" <input type=\"submit\" form=\"usrform\">");
				}
			} else {
				out.print("<h2><a href=\"login.jsp?\">Login to submit review</h2>");
			}
		} catch (SQLException ex) {
			String fullClassName = ex.getStackTrace()[2].getClassName();
			String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
			String methodName = ex.getStackTrace()[2].getMethodName();
			int lineNumber = ex.getStackTrace()[2].getLineNumber();
			out.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
		} catch (Exception e) {
			out.print(e.toString());
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
					out.println(ex);
				}
			}

		}
	%>




</body>
</html>