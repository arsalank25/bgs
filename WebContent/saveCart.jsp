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
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");



if (productList.size() == 0){ // Determine if there are products in the shopping cart
	%>
	<h2> out.println("Your shopping cart is empty!"); </h2>  
	<%
} 
else {
	try {
		// Make database connection
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	 	con = DriverManager.getConnection(url,uid,pw);
		
	 	sql = "SELECT MAX(cID) as lastcID FROM Cart WHERE customerId="+customerId
	 	
	 	
		// Save order information to database
		insert = "INSERT INTO Cart(customerId) VALUES (?)";		
					
		// Use retrieval of auto-generated keys.
		pstmt = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);	
		pstmt.setInt(1, customerId);
		pstmt.executeUpdate();
		keys = pstmt.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);
					
		// Here is the code to traverse through a HashMap
		// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-price, 3-quantity

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
			insertProduct = "INSERT INTO OrderedProduct(orderId,productId,quantity,price) VALUES (?, ?, ?, ?)";
			insertPrep = con.prepareStatement(insertProduct);	
			insertPrep.setInt(1, orderId);
			insertPrep.setInt(2, prodId);
			insertPrep.setInt(3, qty);
			insertPrep.setDouble(4, pr);
			insertPrep.executeUpdate();
		}
		// Update total amount for order record
		update = "UPDATE Orders SET totalAmount = ? WHERE orderId = ?";
		updatePrep = con.prepareStatement(update);	
		updatePrep.setDouble(1, totalAmount);
		updatePrep.setInt(2, orderId);	
		updatePrep.executeUpdate();
		
		
		getCustName = "SELECT cname FROM Customer WHERE customerId = ?";
		prepCustName = con.prepareStatement(getCustName);
		prepCustName.setInt(1, customerId);
		resCustName = prepCustName.executeQuery();
		String cname = "";
		while(resCustName.next()){
			cname = resCustName.getString("cname");
		}
		
		String orderSummary = "Your order reference number is: " + orderId;
		String customerShipment = "Shipping to customer: " + customerId + " Name: " + cname;
		
		//Print out order summary
		%>		
		<h1><% out.println("Your Order Summary");%></h1>
		<table>
			<tbody>
				<tr>
					<th><% out.println("Product Id");%></th>
					<th><% out.println("Product Name");%></th>
					<th><% out.println("Quantity");%></th>
					<th><% out.println("Price");%></th>
					<th><% out.println("Subtotal");%></th>
				</tr>
				
				<% 
				sql2 = "SELECT OrderedProduct.productId, Product.productName, OrderedProduct.quantity, OrderedProduct.price " + 
					"FROM OrderedProduct JOIN Product ON OrderedProduct.productId = Product.productId WHERE orderId = ?";
 				prep2 = con.prepareStatement(sql2);
 				prep2.setInt(1, orderId);
 				res2 = prep2.executeQuery();
 				
 				double total = 0.0;
 				while(res2.next()){
 		  			int productId = res2.getInt("productId");
 		  			String productName = res2.getString("productName");
 		  			int quantity = res2.getInt("quantity");
 		  			double price = res2.getDouble("price");
					double subtotal = (double) quantity * price;
					total = total + subtotal;
 		 			%>
 						<tr>
 							<td><% out.println(productId);%></td>
 							<td><% out.println(productName);%></td>
 							<td align="center"><% out.println(quantity);%></td>
 							<td align="right"><% out.println("$" + price);%></td>
 							<td align="right"><% out.println("$" + subtotal);%></td>
 						</tr>
 		 
 		 			<% 
 		 		}
 				
 				%>
				<tr>
					<td colspan="4" align="right"><b><% out.println("Order Total");%></b></td>
					<td align="right"><% out.println("$" + total);%></td>
				</tr>
			</tbody>
		</table>
		
		<h1><% out.println("Order completed. Will be shipped soon...");%></h1>
		<h1><%=orderSummary%></h1>
		<h1><%=customerShipment%></h1>		
		<% 
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
}

%>
</BODY>
</HTML>

