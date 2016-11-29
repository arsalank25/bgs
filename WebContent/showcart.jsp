<%@ page import="java.util.HashMap" %>
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
<li style="float:right"><a  href="#about">WishList</a></li>
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
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

//Price Variable
double pr = 0.0f;

if (productList == null)
{	out.println("<H2><span style='color:orange;'>Y</span>ou have no items in your cart..</H1>");%>
	<img align="center" src="images/sad_bb_goat.jpg"  style="width:430px;height:228px;">
<% 
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		
		//Makes sure that there is a value for price not sure why,
		//but this was throwing a null pointer error before. 
		if(!(product.get(2)==null)){
			pr  = Double.parseDouble( (String) product.get(2));
		}
		int qty = ( (Integer)product.get(3)).intValue();

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<h4 style="font-family:Raleway;"><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

