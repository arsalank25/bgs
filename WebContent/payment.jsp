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
<link rel="stylesheet" href="images/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Abel" />
<script>
function validateForm() {
    var x = document.forms["signupForm"]["uname"].value;
    var y = document.forms["signupForm"]["psw"].value;
    var z = document.forms["signupForm"]["fname"].value;
    var a = document.forms["signupForm"]["lname"].value;
    var b = document.forms["signupForm"]["email"].value;
    var c = document.forms["signupForm"]["housenum"].value;
    var d = document.forms["signupForm"]["street"].value;
    var e = document.forms["signupForm"]["city"].value;
    var f = document.forms["signupForm"]["province"].value;
    var g = document.forms["signupForm"]["pc"].value;
    if (x == "" || y == "" || z == "" || a == "" || b == "") {
        alert("Please fill in all fields");
        return false;
    }

}

</script>
<title>Payment</title>
</head>


<body>
<div style="background-color: orange; "><h2>Choose existing payment method</h2></div>


<%
	//Test link
//http://localhost:8080/testing/payment.jsp?pname=My+Payment+&fname=Eric&lname=Nelson&street=1234&city=Kelowna&province=BC&postalcode=V1V+1V8&ccnum=34&sec=342&exp=0312

//Test one of the variable to see if we are being POST'd anything
String pname = request.getParameter("pname");


//Get customer ID from session
HashMap<String, String> userSession = (HashMap<String, String>) session.getAttribute("userSession");
int customerId = (int) Integer.parseInt(userSession.get("CustomerID"));

//We are going to save the payment to the database
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection con = null;
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_group11";
	String uid = "group11";
	String pw = "group11";
	String sql;


if(pname != null){
	
	
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String street = request.getParameter("street");
	String city = request.getParameter("city");
	String province = request.getParameter("province");
	String postalcode = request.getParameter("postalcode");
	String ccnum = request.getParameter("ccnum");
	int sec = Integer.parseInt(request.getParameter("sec"));
	int exp = Integer.parseInt(request.getParameter("exp"));
	
	
	
	try{
		sql = "INSERT INTO Payment (customerID,paymentName,firstName,lastName,street,city"
		+",province,postalCode,cardNo,cardSin,cardExpeiryDate)VALUES (?,?,?,?,?,?,?,?,?,?,?)";
		
		con = DriverManager.getConnection(url, uid, pw);
		PreparedStatement prep = con.prepareStatement(sql);		
		
		prep.setInt(1, customerId);
		prep.setString(2, pname);
		prep.setString(3, fname);
		prep.setString(4, lname);
		prep.setString(5, street);
		prep.setString(6, city);
		prep.setString(7, province);
		prep.setString(8, postalcode);
		prep.setString(9, ccnum);
		prep.setInt(10, sec);
		prep.setInt(11, exp);			
		
		prep.executeUpdate();	
		
		//Redirect here to see changes
		response.sendRedirect("payment.jsp");
		
	} catch (SQLException ex) {
		String fullClassName = ex.getStackTrace()[2].getClassName();
		String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
		String methodName = ex.getStackTrace()[2].getMethodName();
		int lineNumber = ex.getStackTrace()[2].getLineNumber();
		System.err.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
	} 
	
	
	} else {
		//Display the options if there are any

		try {
			sql = "SELECT paymentName FROM Payment WHERE customerID = ?";

			con = DriverManager.getConnection(url, uid, pw);
			PreparedStatement prep = con.prepareStatement(sql);
			prep.setInt(1, customerId);
			ResultSet rs = prep.executeQuery();	
			
			while(rs.next()){
				out.print("<a href=\"pay.jsp\"><h2>"+rs.getString("paymentName")+"</h2></a>");
			}

		} catch (SQLException ex) {
			String fullClassName = ex.getStackTrace()[2].getClassName();
			String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
			String methodName = ex.getStackTrace()[2].getMethodName();
			int lineNumber = ex.getStackTrace()[2].getLineNumber();
			System.err.println(className + "." + methodName + "():" + lineNumber + "Message: " + ex);
		}

	}
%>

<!-- onsubmit="return validateForm()" -->
<div style="background-color: orange; "><h2>Add new Payment Information</h2></div>
<form name="paymentForm" method="POST" action="payment.jsp"  autocomplete="on">
  <div class="imgcontainer">
<!--     <img src="images/BGSLogo.jpg" alt="Avatar" class="avatar"> -->
  </div>
  <div class="container">  	
  
  	<label><b>Payment Name</b></label>
    <input type="text" placeholder="Enter Payment Name" name="pname" required>
  
    <label><b>First Name</b></label>
    <input type="text" placeholder="Enter First Name" name="fname" required>
    
     <label><b>Last Name</b></label>
    <input type="text" placeholder="Enter Last Name" name="lname" required>
    
    <label><b>Street</b></label><br>
    <input type="text" placeholder="Enter Street" name="street" required><br>
    
    <label><b>City</b></label>
    <input type="text" placeholder="Enter City" name="city" required>
    
    <label><b>Province</b></label>
    <input type="text" placeholder="Enter Province" name="province" required>
    
    <label><b>Postal Code</b></label>
    <input type="text" placeholder="Enter Postal Code" name="postalcode" required>
    <br>
    <br>
    <img src="images/cc.gif">
    <br>
    <br>
    
    <label><b>Card Number</b></label>
    <input type="text" placeholder="Enter City" name="ccnum" required autocomplete="shipping locality">
    
    <label><b>Card Security Code</b></label>
    <input type="text" placeholder="CardSecurity Code" name="sec" required>
    
    <label><b>Expiry date(mm/yy)</b></label>
    <input type="text" placeholder="mm/yy" name="exp" required>
        
    <button type="submit">Add new Payment</button>
    
  </div>
</form>

<script>

</script>
</body>

</html>
