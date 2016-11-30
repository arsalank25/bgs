<%
//Deletes the login session
session.removeAttribute("userSession");
session.removeAttribute("productList");
%>
<jsp:forward page="login.jsp" />