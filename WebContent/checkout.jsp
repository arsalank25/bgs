<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="images/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Abel" />
</head>
<body>


<ul>
<li style="float:left"><img src="images/BGSLogo.jpg" style="width:50px;height:50px;"></li>
<li style="float:right"><a  href="login.jsp">Account</a></li>
<li style="float:right"><a  href="wishList.jsp">WishList</a></li>
<li style="float:right"><a href="checkout.jsp">Check Out</a></li>
<li style="float:right"><a class="active" href="showcart.jsp">Cart</a></li>

 <li><a href="shop.html">Home</a></li>
 <li class="dropdown">
    <a href="listprod.jsp" class="dropbtn">Shop</a>    
    <div class="dropdown-content">
      <a href="TurtleNeck.jsp">Turtle Neck</a>
      <a href="T-Shirt.jsp">T-Shirt</a>   
    </div></li>
 <li><a href="contact.jsp">Contact</a></li>
  
  
</ul>

<%

//Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

//Get user Session
HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");

//Get the province from user session
String province = userSession.get("province");
double gst = 0;
double pst = 0;

//Make connection to get tax information
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
String uid = "group11";
String pw = "group11";
Connection con = null;

try{
	String sql = "SELECT GST,PST FROM TAX WHERE province = ?";
			
	con = DriverManager.getConnection(url, uid, pw);
	PreparedStatement prep = con.prepareStatement(sql);
	//Set province
	prep.setString(1, province);
	ResultSet rs = prep.executeQuery();
	
	while(rs.next()){
		gst = ((double)rs.getInt("GST"))/100f;
		pst = ((double)rs.getInt("PST"))/100f;
	}
} catch (SQLException ex) {
	String fullClassName = ex.getStackTrace()[2].getClassName();
	String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
	String methodName = ex.getStackTrace()[2].getMethodName();
	int lineNumber = ex.getStackTrace()[2].getLineNumber();
	System.err.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
}

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Checkout</h1>");
	out.print("<table cellpadding=\"5\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Product Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		double pr = Double.parseDouble( (String) product.get(2));
		int qty = ( (Integer)product.get(3)).intValue();

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	
	
	
	gst = total*gst;
	pst = total*pst;
	double subtotal = total;
	total = total +gst+pst;
	out.println("</table><br><br>");
	
	
	// Payment/cost info
	out.println("<table cellpadding=\"5\"><tr><td><b>Subtotal</b></td>"
			+"<td style=\"width:125px\" align=\"right\">"+currFormat.format(subtotal)+"</td></tr>");
	out.println("<tr><td><b>GST</b></td>"
			+"<td style=\"width:125px\" align=\"right\">"+currFormat.format(gst)+"</td></tr>");
	out.println("<tr><td><b>PST</b></td>"
			+"<td style=\"width:125px\" align=\"right\">"+currFormat.format(pst)+"</td></tr>");
	out.println("<tr><td><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr></table>");
	
	
	//Shipment tracking info
	
	java.util.Date date = new java.util.Date(); //Get date
	Calendar cal = Calendar.getInstance();
	cal.setTime(date);
	cal.add(Calendar.DATE, 10); // add 10 days
	 
	java.util.Date dateArv = cal.getTime();
	
	out.print("<br><br><div style=\"background-color: grey; \"><h2>Shipment Tracking</h2></div>");	
		
	
	out.print("<table cellpadding=\"7\"><tr><th>Shipment Date</th><th>Estimated Delivery</th>");
	out.print("<tr><td>" +date.toString()+"</td>");
	out.print("<td>" +dateArv.toString()+"<td></tr>");	
	out.print("</table>");
		
	
	
	out.print("<h2>Note to Service</h2>");
	out.print("<textarea form=\"usrform\" maxlength=\"135\" rows=\"4\" cols=\"50\"></textarea>");
	
	out.print("<br><h2>Note on package</h2>");
	out.print("<textarea form=\"usrform\" maxlength=\"135\" rows=\"4\" cols=\"50\"></textarea>");
		
	
	out.println("<h2><a href=\"showcart.jsp\">Back to cart</a></h2>");
	
	out.print("<form name=\"signupForm\" method=\"GET\" action=\"payment.jsp\"  autocomplete=\"on\">");
	out.print("<button type=\"submit\"><h2 style = \"color:black;\"><b>Pay Now!</b></h2></button>");	
	
	
}

%>























</body>
</html>