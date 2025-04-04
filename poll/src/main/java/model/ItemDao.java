package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	
	// udpateItemForm, questionOneResult
	public ArrayList<Item> selectItemListByQnum(int qnum) throws ClassNotFoundException, SQLException {
		// size를 return하는 것이 더 편함 
		// null값은 안 만들 수 있으면 안 만드는 게 좋음
		ArrayList<Item> list = new ArrayList<Item>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		
		String sql = "SELECT * FROM item WHERE qnum = ? ORDER BY inum ASC"; // ASC도 써주기
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery(); // ResultSet: 외부 라이브에 종속될 수밖에 없는 타입 (mysql)
		// 외부 JDBC 라이브러리에 의존하는 ResultSet을 ArrayList 타입으로 변경
		while(rs.next()) {
			Item i = new Item();
			i.setQnum(qnum); // 매개변수 값 쓰기
			i.setInum(rs.getInt("inum"));
			i.setContent(rs.getString("content"));
			i.setCount(rs.getInt("count"));
			list.add(i);
		}
		return list;
	}
	
	
	//
	public void updateItemCountPlus(int qnum, int inum) throws ClassNotFoundException, SQLException { // 반환값이 필요하지 않으니까 void로
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE item SET count = count+1 WHERE qnum = ? AND inum = ?"; 
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		stmt.setInt(2, inum);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("ItemDao.updateItemCountPlus#입력성공");	
		} else {
			System.out.println("ItemDao.updateItemCountPlus#입력실패");	
		}
	}
	
	
	
	// 
	public int selectItemCountByQnum(int qnum) throws ClassNotFoundException, SQLException {
		int count = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		
		String sql = "SELECT SUM(count) cnt FROM item GROUP BY qnum HAVING qnum = ?"; 
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("cnt");
		}
		return count;
	}
}
