package logincheck;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logincheck")
public class logincheck extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		Connection conn = null;
		PreparedStatement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		String checkUser = "SELECT * FROM homework3.check WHERE username='" + username + "'";
		String checkPass = "SELECT * FROM homework3.check WHERE username='" + username + "' AND password='" + password + "'";
		
		String usernameCount;
		String passwordCount;
		boolean userexists = false;
		boolean passexists = false;
		
		
		
		try 
		{

			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework3?user=root&password=YourNewPassword");
			st = conn.prepareStatement(checkUser);
			ps = conn.prepareStatement(checkPass);
			rs = st.executeQuery();
			rs2 = ps.executeQuery();
			
			while(rs.next())
			{
				usernameCount = rs.getString("username");
				
				if(usernameCount.equals(username))
				{
					userexists = true;
				}
			}
			if(userexists)
			{
				while(rs2.next())
				{
					passwordCount = rs2.getString("password");
					if(passwordCount.equals(password))
					{
						passexists = true;
					}
				}
				
			}
			
			if(userexists && passexists)
			{
				request.getRequestDispatcher("/success.jsp").forward(request, response);
				
			}
			else if(!userexists)
			{
				String ude = "This user does not exist.";
				request.setAttribute("ude", ude);
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
			else if(!passexists)
			{
				String pde = "Incorrect Passowrd.";
				request.setAttribute("pde", pde);
				request.getRequestDispatcher("/login.jsp").forward(request, response);
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
				if(st != null) {st.close();}
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

