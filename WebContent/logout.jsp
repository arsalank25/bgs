<%
//Deletes the login session
session.removeAttribute("userSession");
%>
<jsp:forward page="login.jsp" />