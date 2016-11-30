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



<script>
function update(newid, newqty)
{
	window.location="showcart.jsp?update="+newid+"&newqty="+newqty;
}
</script>
<FORM name="form1">

<%

//Get the user if it exists
HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");



// Get the current list of products
HashMap productList = (HashMap) session.getAttribute("productList");
ArrayList product = new ArrayList();
String id = request.getParameter("delete");
String update = request.getParameter("update");
String newqty = request.getParameter("newqty");

// check if shopping cart is empty
if (productList == null)
{	
	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	// if id not null, then user is trying to remove that item from the shopping cart
	if(id != null && (!id.equals(""))) {
		if(productList.containsKey(id)) {
			productList.remove(id);
		}
	}
	
	// if update isn't null, the user is trying to update the quantity
	if(update != null && (!update.equals(""))) {
		if (productList.containsKey(update)) { // find item in shopping cart
			product = (ArrayList) productList.get(update);
			product.set(3, (new Integer(newqty))); // change quantity to new quantity
		}
		else {
			productList.put(id,product);
		}
	}

	// print out HTML to print out the shopping cart
	if(userSession != null){
		String firstName = userSession.get("FirstName");
		out.println("<H1>"+firstName+"'s Shopping Cart</H1>");
	}else{
		out.println("<H1>Your Shopping Cart</H1>");
	}
	out.print("<TABLE><TR><TH>Product Id</TH><TH>Product Name</TH><TH>Quantity</TH>");
	out.println("<TH>Price</TH><TH style=\"width:150px\">Subtotal</TH><TH></TH><TH></TH></TR>");

	int count = 0;
	double total =0;
	// iterate through all items in the shopping cart
	Iterator iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) {
		count++;
		Map.Entry entry = (Map.Entry)(iterator.next());
		product = (ArrayList) entry.getValue();
		// read in values for that product ID
		out.print("<TR><TD>"+product.get(0)+"</TD>");
		out.print("<TD>"+product.get(1)+"</TD>");

		out.print("<TD ALIGN=CENTER><INPUT TYPE=\"text\" name=\"newqty"+count+"\" size=\"3\" value=\""
			+product.get(3)+"\"></TD>");
		double pr = Double.parseDouble( (String) product.get(2));
		int qty = ( (Integer)product.get(3)).intValue();
		
		// print out values for that product from shopping cart
		out.print("<TD ALIGN=RIGHT>"+currFormat.format(pr)+"</TD>");
		out.print("<TD ALIGN=RIGHT>"+currFormat.format(pr*qty)+"</TD>");
		// allow the customer to delete items from their shopping cart by clicking here
		out.println("<TD>&nbsp;&nbsp;&nbsp;&nbsp;<A HREF=\"showcart.jsp?delete="
			+product.get(0)+"\">Remove Item from Cart</A></TD>");
		// allow customer to change quantities for a product in their shopping cart
		out.println("<TD>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE=BUTTON OnClick=\"update("
			+product.get(0)+", document.form1.newqty"+count+".value)\" VALUE=\"Update Quantity\">");
		out.println("</TR>");
		// keep a running total for all items ordered
		total = total +pr*qty;
	}
	// print out order total
	out.println("<TR><TD COLSPAN=4 ALIGN=RIGHT><B>Order Total</B></TD>"
			+"<TD ALIGN=RIGHT>"+currFormat.format(total)+"</TD></TR>");
	out.println("</TABLE>");
	//Only allow checkout if logged in, and save cart before going to checkout page
	if(userSession != null){
		out.println("<H2><A HREF=\"saveCart.jsp?checkingout=true\">Check Out</A></H2>");
	}
}
// set the shopping cart
session.setAttribute("productList", productList);
// give the customer the option to add more items to their shopping cart

if(userSession != null){
	out.print("<h2><a href=\"saveCart.jsp\">Save Cart</a></h2>");
}else{
	out.print("<h2><a href=\"login.jsp\">Please create account to save cart</a></h2>");
}

%>
<h2 style="font-family:abel;"><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

