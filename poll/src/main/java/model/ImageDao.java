package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Image;
import dto.Paging;

public class ImageDao {
	public void insertImage(Image img) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt2 = null;
		String sql2 = "UPDATE board SET pos = pos+1 WHERE ref=? AND pos >= ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		

		PreparedStatement stmt = null;
		String sql = "INSERT INTO image(memo,filename) VALUES(?,?)";
		stmt= conn.prepareStatement(sql); 
		stmt.setString(1, img.getMemo());
		stmt.setString(2, img.getFilename());
		int row = stmt.executeUpdate();
		
		conn.close();	
	}
	
	
	public ArrayList<Image> selectImageList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<Image> list = new ArrayList<Image>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		String sql = "SELECT * FROM image ORDER BY num DESC LIMIT ?, ?";
		
		stmt= conn.prepareStatement(sql); 
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		while(rs.next()) {
			Image img = new Image();
			img.setNum(rs.getInt("num"));
			img.setMemo(rs.getString("memo"));
			img.setFilename(rs.getString("filename"));
			img.setCreatedate(rs.getString("createdate"));
			list.add(img);
		}
		
		rs = stmt.executeQuery();
		return list;
	}
	
	
	public void deleteImage(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		String sql = "DELETE FROM image WHERE num = ?";
		
		stmt= conn.prepareStatement(sql); 
		stmt.setInt(1, num);
		int row = stmt.executeUpdate();
		
		conn.close();	
	}
}
