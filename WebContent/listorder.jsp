<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>
<% Connection con = null;
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_tsiemens";
String uid = "tsiemens";
String pw = "26744145";
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
con = DriverManager.getConnection(url,uid,pw); %>

<style>table, td { border: 1px solid black}</style>
<table style="width:100%">

<tr> 
<th>OrderId</th>
<th>CustomerId</th>
<th>Customer Name</th>
<th>Total Amount</th>
</tr>


<%
int orderId, customerId, productId, quantity = 0;
String customerName, sql, sql2 = "";
double totalAmount, price = 0.0;
ResultSet rst, rst2 = null;
PreparedStatement prep, prep2 = null;
try{
 Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
  con = DriverManager.getConnection(url,uid,pw);
  sql = "SELECT O.orderId, O.customerId, C.cname, O.totalAmount FROM Orders O, Customer C WHERE C.customerId = O.customerId";
  prep = con.prepareStatement(sql);
  rst = prep.executeQuery();
  while(rst.next()){
    orderId = rst.getInt("orderId");
    customerId = rst.getInt("customerId");
    customerName = rst.getString("cname");
    totalAmount = rst.getDouble("totalAmount");
%>
  <tr>
  <td><% out.println(orderId);%></td>
  <td><% out.println(customerId);%></td>
  <td><% out.println(customerName);%></td>
  <td><% out.println("$" + totalAmount);%></td>
  </tr>

  <tr>
   <th></th>
   <th></th>
   <th>Product Id</th>
  <th>Quantity</th>
   <th>Price</th>
  </tr>

   <% 
   sql2 = "SELECT productId, quantity, price FROM OrderedProduct WHERE orderId = ?";
   prep2 = con.prepareStatement(sql2);
   prep2.setInt(1, orderId);
   rst2 = prep2.executeQuery();
   
   while(rst2.next()){
     productId = rst2.getInt("productId");
     quantity = rst2.getInt("quantity");
     price = rst2.getDouble("price");

   %>
   <tr>
   <td></td>
   <td></td>
   <td><% out.println(productId);%></td>
   <td><% out.println(quantity);%></td>
   <td><% out.println("$" + price);%></td>
   </tr>
 
   <% 
   }
  }
} catch(SQLException ex){
  System.err.println(ex);
} finally{
  try{
    if( con != null){
      con.close();
    }
  } catch(SQLException ex){
    System.err.println(ex);
  }
}
%> 
</table>
</body>
</html>
