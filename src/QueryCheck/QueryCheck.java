package QueryCheck;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/QueryCheck")
public class QueryCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmpass = request.getParameter("confirmpass");
		boolean notmatch = false;
		
		if(!confirmpass.equals(password))
		{
			notmatch = true;
			String message = "The passwords do not match.";
			request.setAttribute("message", message);
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		}
		String insertTableSQL = "INSERT INTO homework3.check "
				+ "(Username, Password, Confirmpass) VALUES "
				+ "(?,?,?);";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		PreparedStatement st = null;
		String select = "SELECT * FROM homework3.check WHERE username='" + username + "'";
		String usernameCount;
		boolean exists = false;
		
		try 
		{

			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework3?user=root&password=YourNewPassword");
			ps = conn.prepareStatement(insertTableSQL);
			st = conn.prepareStatement(select);
			rs = st.executeQuery();
			while(rs.next())
			{
				usernameCount = rs.getString("username");
				if(usernameCount.equals(username))
				{
					exists = true;
					String checke = "This username is already taken.";
					request.setAttribute("checke", checke);
					request.getRequestDispatcher("/register.jsp").forward(request, response);
				}
				
			}
			if(!exists && !notmatch)
			{
				ps.setString(1, username); // set first variable in prepared statement
				ps.setString(2, password);
				ps.setString(3, confirmpass);
				ps.executeUpdate();
				request.getRequestDispatcher("/success.jsp").forward(request, response);
				
			}
			
		} 
		catch (SQLException sqle) 
		{
			System.out.println("sqle: " + sqle.getMessage());
		} 
		catch (ClassNotFoundException cnfe) 
		{
			System.out.println("cnfe: " + cnfe.getMessage());
		} 
		finally 
		{
			try
			{
				if(rs != null) {rs.close();}
				if(ps != null) {ps.close();}
				if(conn != null) {conn.close();}
			}
			catch (SQLException sqle)
			{
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}

}

