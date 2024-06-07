package user;

import function.function;
import data.Account;
import data.resend;
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
import java.sql.SQLException;

@WebServlet("/change_password")
public class change_password extends HttpServlet {
    private static final long serialVersionUID = 1L;



    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String password = req.getParameter("password");
        password = function.hashPassword(password);
        Account account = (Account) session.getAttribute("account");
        String username = account.getUsername();
        resend send = (resend) session.getAttribute("resend");

        try(Connection connection = DBConnection.getConnection()){
            String sql = "update account set password=? where username=?";
            try(PreparedStatement ps = connection.prepareStatement(sql)){
                ps.setString(1, password);
                ps.setString(2, username);
                int row =  ps.executeUpdate();

                if(row>0){
                    req.setAttribute("des", "Change Password Successfully!Please Try Login!");
                    req.setAttribute("page", "login");

                    session.removeAttribute("account");
                    session.removeAttribute("resend");
                    RequestDispatcher rd = req.getRequestDispatcher("Success.jsp");
                    rd.forward(req, resp);
                }else{
                    req.setAttribute("des", "Change Password failed!<br>Please contact admin!");
                    req.setAttribute("page", "login");
                    session.removeAttribute("account");
                    session.removeAttribute("resend");
                    RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                    rd.forward(req, resp);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error connecting to the database: " + e.getMessage());
            req.setAttribute("des", "Change Password failed!<br>Please contact admin!");
            req.setAttribute("page", "login");
            session.removeAttribute("account");
            session.removeAttribute("resend");
            RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
            rd.forward(req, resp);

        } catch (ClassNotFoundException e) {
            req.setAttribute("des", "Change Password failed!<br>Please contact admin!");
            req.setAttribute("page", "login");
            session.removeAttribute("account");
            session.removeAttribute("resend");
            RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
            rd.forward(req, resp);
            throw new RuntimeException(e);

        }
    }


}
