package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Item;

// Table: item crud
public class ItemDao {
	
	// 입력 메서드
	public void insertItem(Item item) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO item(qnum, inum, content) VALUES(?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3, item.getContent());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("ItemDao.insertItem - 입력 성공");
		} else {
			System.out.println("ItemDao.insertItem - 입력 실패");
		}
		conn.close();
	}
	
	
	// 투표한 인원이 있는지 확인하는 메서드
	public int sumCount(Item c) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT qnum, SUM(count) FROM item GROUP BY qnum HAVING qnum = ?";
		// SUM(count): 보기(content)를 선택한 수의 합 | HAVING: 집계 함수 결과를 필터링할 때 사용
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, c.getQnum());
		rs = stmt.executeQuery();
		
		rs.next();
		int count = rs.getInt("count");
		
		conn.close();
		return count;	
	}

	
	// 삭제 메서드
	public int deleteItem(Item d) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM item WHERE qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, d.getQnum());
		
		int row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
}
