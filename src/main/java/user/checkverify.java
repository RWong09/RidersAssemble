package user;

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
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/verify")
public class checkverify extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String code = req.getParameter("code");
        resend send = (resend) session.getAttribute("send");
        Account account = (Account) session.getAttribute("account");
        int attempt = send.getResend();
        System.out.println(attempt);
        String code_c = account.getCode();
        if(attempt != 0){
            if(code.equals(code_c)){
                String password = account.getPassword();
                String email = account.getEmail();
                String phone = account.getPhone();
                String address = account.getAddress();
                String username = account.getUsername();
                String dob = account.getDOB();
                String full_name = account.getFull_name();

                try (Connection connection = DBConnection.getConnection()) {
                    String insert = "INSERT INTO account (username, full_name,password, email, phone,dob,address, status,category) VALUES (?,?,?,?,?,?,?,?,?)";
                    try (PreparedStatement statement = connection.prepareStatement(insert)) {
                        statement.setString(1, username);
                        statement.setString(2, full_name);
                        statement.setString(3, password);
                        statement.setString(4, email);
                        statement.setString(5, phone);
                        statement.setString(6, dob);
                        statement.setString(7, address);
                        statement.setInt(8, 1);
                        statement.setInt(9, 1);
                        int rowsAffected = statement.executeUpdate();

                        // Checking if the insertion was successful
                        if (rowsAffected > 0) {
                            statement.close();
                            connection.close();
                            try (Connection conn = DBConnection.getConnection()) {
                                String select = "SELECT * FROM account WHERE username = ?";
                                try (PreparedStatement ps = conn.prepareStatement(select)) {
                                    ps.setString(1, username);
                                    ResultSet rs = ps.executeQuery();
                                    if (rs.next()) {
                                        int id = rs.getInt("userId");
                                        ps.close();
                                        conn.close();
                                        try(Connection con = DBConnection.getConnection()) {
                                            String currency = "Insert INTO amount (cid,amount,userid) VALUES (?,?,?)";
                                            String select_1 = "SELECT * FROM currency";
                                            try (PreparedStatement ps2 = con.prepareStatement(currency)) {
                                                try(PreparedStatement ps3 = con.prepareStatement(select_1)) {
                                                    ResultSet rs2 = ps3.executeQuery();
                                                    while(rs2.next()){
                                                        ps2.setInt(1, rs2.getInt("id"));
                                                        ps2.setInt(2, 0);
                                                        ps2.setInt(3, id);
                                                        ps2.executeUpdate();
                                                    }
                                                }


                                                System.out.println("Insertion successful!");
                                                req.setAttribute("des", "Registered successfully!<br>Please waiting admin approved!");
                                                req.setAttribute("page", "login");
                                                account.clear();
                                                send.clear();
                                                RequestDispatcher rd = req.getRequestDispatcher("Success.jsp");
                                                rd.forward(req, resp);
                                            }
                                            catch (SQLException e) {
                                                req.setAttribute("des", "Registration failed!<br>Please contact admin!");
                                                req.setAttribute("page", "login");
                                                account.clear();
                                                send.clear();
                                                RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                                                rd.forward(req, resp);
                                                e.printStackTrace();
                                            }
                                        }
                                    }else{
                                        req.setAttribute("des", "Registration failed!<br>Please contact admin!");
                                        req.setAttribute("page", "login");
                                        account.clear();
                                        send.clear();
                                        RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                                        rd.forward(req, resp);
                                    }
                                }
                            }

                        } else {
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                            System.out.println("Insertion failed!");
                            req.setAttribute("des", "Registration failed!<br>Please contact admin!");
                            req.setAttribute("page", "login");
                            account.clear();
                            send.clear();
                            RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                            rd.forward(req, resp);
                        }
                        try {
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println("Error connecting to the database: " + e.getMessage());
                    req.setAttribute("des", "Registration failed!<br>Please contact admin!");
                    req.setAttribute("page", "login");
                    account.clear();
                    send.clear();
                    RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                    rd.forward(req, resp);

                } catch (ClassNotFoundException e) {
                    req.setAttribute("des", "Registration failed!<br>Please contact admin!");
                    req.setAttribute("page", "login");
                    account.clear();
                    send.clear();
                    RequestDispatcher rd = req.getRequestDispatcher("Failed.jsp");
                    rd.forward(req, resp);
                    throw new RuntimeException(e);

                }



            }else{
                attempt = attempt - 1;
                send.setResend(attempt);
                session.setAttribute("send",send);
                req.setAttribute("account", account);
                req.setAttribute("resend", send);
                RequestDispatcher rd = req.getRequestDispatcher("verify.jsp");
                rd.forward(req, resp);
            }
        }else{
            req.setAttribute("account", account);
            req.setAttribute("resend", send);
            RequestDispatcher rd = req.getRequestDispatcher("verify.jsp");
            rd.forward(req, resp);
        }
    }

}