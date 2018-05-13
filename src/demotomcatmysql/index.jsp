<%@page language="java" contentType="text/plain;charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*, java.io.*" %>

Entrypoint
========================
SOME_ENVIRONMENT_VAR = <%=System.getenv("SOME_ENVIRONMENT_VAR")%>




DB Entries
==========================
<%

String newFilename = System.currentTimeMillis()+"";
String dataStorePath = "/opt/datadir/";
Connection con = null;
String query = null;
Statement stmt = null;
try {
	DataSource dataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/dbressource");
	con = dataSource.getConnection();
	stmt = con.createStatement();
	
	// insert new entry into db
	query = "insert into filenametable(filename) values('"+newFilename+"')";
	stmt.executeUpdate(query);
	
	// create file with given name
    File newFile = new File(dataStorePath+newFilename);
    newFile.createNewFile();
	
	query = "select * from filenametable order by id";
	ResultSet rs = stmt.executeQuery(query);
	while(rs.next())
	{
		out.print(rs.getInt("id"));
		out.println("    " + rs.getString("filename"));
		
	}
	rs.close();
} finally {
    if (con != null) con.close();
}
%>

File Store Entries
==========================
<%
File folder = new File(dataStorePath);
File[] listOfFiles = folder.listFiles();

	for (int i = 0; i < listOfFiles.length; i++) {
		out.println(listOfFiles[i].getName());
	}
%>
