<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>


<!-- IMPORTANT -->
<!--This JSP takes whatever is in the session and it adds it to the customers cart.   -->

<!-- -	First it finds the most recent cart that is not in shipped products, if there is no cart,
 	or no cart not in shipped products, then create new cart-->

<!-- -When saving, it deletes what ever is in the current cartcontains for the current cart, and then
writes in new products
 -->


<%
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
	String uid = "group11";
	String pw = "group11";
	Connection con = null;

	//Get Product and user sessions
	@SuppressWarnings({ "unchecked" })
	HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
			.getAttribute("productList");

	//Get customer id
	int customerId = (int) Integer.parseInt(userSession.get("CustomerID"));
	String province = userSession.get("province");
	System.out.println("Cusomter ID: " + customerId);

	//Determine if there are products in the shopping cart
	if (productList.size() != 0) {
		try {
			//Get current cart for customer, make sure it has not been shipped. 
			String sql = "SELECT MAX(C.cID) AS cartID FROM Cart C LEFT JOIN Shipment S ON C.cID = S.cID WHERE S.cID IS NULL AND C.customerID = ?";

			int cartID = 0;
					
			con = DriverManager.getConnection(url, uid, pw);
			PreparedStatement prep = con.prepareStatement(sql);
			//Set customerId
			prep.setInt(1, customerId);

			ResultSet rs = prep.executeQuery();

			//If there is an active cart then delete the cart products and save current cart session
			if (rs.next()) {
				if (rs.getInt("cartID") > 0) {
					//There is an active cart, so we drop its cartcontents and replace with cart session info
					cartID = rs.getInt("cartID");
					System.out.println("Active Cart is: " + cartID);
					
					//Delete all rows from cart contains with current customer ID
					sql = "DELETE FROM CartContains WHERE cID= ?";
					prep = con.prepareStatement(sql);
					prep.setInt(1, cartID);
					prep.executeUpdate();						

				} else {

					System.out.println("No active cart, creating cart...");
					//there is no active cart, then we must make one
					sql = "INSERT INTO Cart (customerID,province) VALUES (?,?)";
					prep = con.prepareStatement(sql);
					prep.setInt(1, customerId);
					prep.setString(2, province);
					prep.executeUpdate();	
					
					//Also get the newly created cartID by redirecting here. 
					response.sendRedirect("saveCart.jsp");
				}

			}
			
			//After cart is either created, or CartContains has been emptied, we will fill with session cart
		double totalAmount = 0.0;	
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();		
		
		while (iterator.hasNext())
		{ 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
			int prodId = Integer.parseInt(productId);
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();
			
			totalAmount = totalAmount + (double) (qty * pr);
			
			// Insert each item into OrderedProduct table using OrderId from previous INSERT
			sql = "INSERT INTO CartContains(cID,customerID,pID,quantity) VALUES (?, ?, ?, ?)";
			prep = con.prepareStatement(sql);	
			prep.setInt(1, cartID);
			prep.setInt(2, customerId);
			prep.setInt(3, prodId);
			prep.setDouble(4, qty);
			prep.executeUpdate();
		}
		
		//Finally update cart totalAmount and GST and stuff
		sql = "UPDATE Cart SET totalAmount = ? WHERE cID = ?";
		prep = con.prepareStatement(sql);	
		prep.setDouble(1, totalAmount);
		prep.setInt(2, cartID);	
		prep.executeUpdate();
		
		response.sendRedirect("showcart.jsp");
			

		} catch (SQLException ex) {
			String fullClassName = ex.getStackTrace()[2].getClassName();
			String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
			String methodName = ex.getStackTrace()[2].getMethodName();
			int lineNumber = ex.getStackTrace()[2].getLineNumber();
			System.err.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
					out.println(ex);
				}
			}
		}

	} else {
		//No products in cart but it technically "saved" nothing
	}
	
%>
</BODY>
</HTML>

