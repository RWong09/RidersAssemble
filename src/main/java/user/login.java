package user;

import data.Card;
import function.function;
import data.Account;
import db.DBConnection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/home")
public class login extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        password = function.hashPassword(password);
        try(Connection connection = DBConnection.getConnection()){
            String select = "select * from account where username=? and password=?";
            String car = "SELECT * FROM card WHERE id = ?";
            try(PreparedStatement ps = connection.prepareStatement(select)){
                ps.setString(1, username);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    int status = rs.getInt("status");
                    if(status == 1){
                        req.setAttribute("des", "Your account is pending!<br>Please waiting admin approved!");
                        req.setAttribute("page", "login");
                        RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                        rd.forward(req, resp);
                    } else if (status == 2) {
                        int category = rs.getInt("category");
                        if(category == 4){
                            int userId = rs.getInt("userId");
                            String fullname = rs.getString("full_name");
                            String email = rs.getString("email");
                            String phone = rs.getString("phone");
                            String dob = rs.getString("dob");
                            String address = rs.getString("address");
                            Account account = new Account();
                            account.setUserId(userId);
                            account.setUsername(username);
                            account.setPassword(password);
                            account.setFull_name(fullname);
                            account.setEmail(email);
                            account.setPhone(phone);
                            account.setAddress(address);
                            account.setCategory(category);
                            account.setDOB(dob);
                            session.setAttribute("account", account);
                            RequestDispatcher rd = req.getRequestDispatcher("admin.jsp");
                            rd.forward(req, resp);
                        }else if(category == 1 || category == 2 || category == 3){
                            int userId = rs.getInt("userId");
                            String fullname = rs.getString("full_name");
                            String email = rs.getString("email");
                            String phone = rs.getString("phone");
                            String dob = rs.getString("dob");
                            String address = rs.getString("address");
                            Account account = new Account();
                            account.setUserId(userId);
                            account.setUsername(username);
                            account.setPassword(password);
                            account.setFull_name(fullname);
                            account.setEmail(email);
                            account.setPhone(phone);
                            account.setAddress(address);
                            account.setCategory(category);
                            account.setDOB(dob);

                            session.setAttribute("account", account);


                            Card card = new Card();
                            try(PreparedStatement stmt = connection.prepareStatement(car)){
                                stmt.setInt(1, userId);
                                ResultSet result = stmt.executeQuery();
                                if(result.next()){

                                   card.setCardNum(result.getString("number"));
                                   card.setCVV(result.getString("cvv"));
                                   card.setExpiryDate(result.getString("mmyy"));
                                   card.setPIN(result.getString("PIN"));
                                }
                            }
                            connection.close();
                            ps.close();
                            session.setAttribute("card", card);
                            req.setAttribute("account", account);
                            RequestDispatcher rd = req.getRequestDispatcher("t.jsp");
                            rd.forward(req, resp);
                        }else{
                            req.setAttribute("des", "Login failed!<br>Username or password is incorrect!");
                            req.setAttribute("page", "login");
                            RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                            rd.forward(req, resp);
                        }
                    } else{
                        req.setAttribute("des", "Your account is block!<br>Please contact admin!");
                        req.setAttribute("page", "login");
                        RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                        rd.forward(req, resp);
                    }
                }else{
                    req.setAttribute("des", "Login failed!<br>Username or password is incorrect!");
                    req.setAttribute("page", "login");
                    RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                    rd.forward(req, resp);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            req.setAttribute("des", "Login failed!<br>Please contact admin!");
            req.setAttribute("page", "login");
            RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
            rd.forward(req, resp);
            throw new RuntimeException(e);
        }
    }


}
