<%@ page import="data.Account" %>
<%@ page import="db.DBConnection" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/20/2024
  Time: 3:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession session1 = request.getSession();
    Account account = (Account)session1.getAttribute("account");
    String username = account.getUsername();
    String password = account.getPassword();
    try(Connection connection = DBConnection.getConnection()){
        String select = "select * from account where username=? and password=?";
        try(PreparedStatement ps = connection.prepareStatement(select)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                request.setAttribute("checklogin", true);
            }else{
                request.setAttribute("checklogin", false);
            }
        }
    }catch (SQLException | ClassNotFoundException e) {
        request.setAttribute("checklogin", false);
        throw new RuntimeException(e);
    }
%>
