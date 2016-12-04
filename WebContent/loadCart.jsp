<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<%
	System.out.print("\nLoadCart.jsp Called");
	HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");

	if (userSession != null) {
		int customerId = (int) Integer.parseInt(userSession.get("CustomerID"));
		
		//Create new list to add cart to. 
		HashMap<String, ArrayList<Object>>  productList = new HashMap<String, ArrayList<Object>>();
		
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
			System.out.println("\nGetting Current cart to load for user..."+ customerId);
			//If there is an active/current cart, then load it
			if (rs.next()) {
				cartID = rs.getInt("cartID");
				System.out.println("\n Cart Id: " +cartID);
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
			
			//Get the reffering URL from the GET (do this because login reffers back to itself during login)	
			String fromURL = request.getParameter("from");
			
			//Redirect to where we were before logging in
			System.out.print("\nLoadcart > FromURL > "+fromURL);
			if(fromURL.contains("register")||fromURL.contains("login")||fromURL.contains("logout")||fromURL.equals(null)){
				System.out.print("\nRedirecting to shop.html");
				response.sendRedirect("shop.html");
			}
			else if(fromURL!=null){
				response.sendRedirect(fromURL);
			}
			
			
			
			
		} catch (SQLException ex) {
			String fullClassName = ex.getStackTrace()[2].getClassName();
			String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
			String methodName = ex.getStackTrace()[2].getMethodName();
			int lineNumber = ex.getStackTrace()[2].getLineNumber();
			out.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
		}
	}
%>
