package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Paging;
import dto.Question;

// Table : question crud
public class QuestionDao {
	
	// 설문 전체 개수 구하는 메서드
	public int getTotal() throws ClassNotFoundException, SQLException {
		
		int total = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		String sql = "SELECT COUNT(*) cnt FROM question";
		stmt = conn.prepareStatement(sql);
		System.out.println("QuestionDao stmt: " + stmt);
		rs = stmt.executeQuery();
		rs.next();
		
		total = rs.getInt("cnt");
		
		conn.close();
		return total;
	}
	
	
	// 페이징, 리스트 메서드
	public ArrayList<HashMap<String, Object>> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		
		String sql = "SELECT q.num, q.title, q.startdate, q.enddate, q.createdate, q.type, t.cnt"
						+ " FROM question q INNER JOIN"
						+ " (SELECT qnum, sum(count) cnt FROM item GROUP BY qnum) t"
						+ " ON q.num = t.qnum LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		System.out.println("QuestionDao stmt: " + stmt);
		rs = stmt.executeQuery();
	
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("num", rs.getInt("q.num"));			
			map.put("title", rs.getString("q.title"));			
			map.put("startdate", rs.getString("q.startdate"));			
			map.put("enddate", rs.getString("q.enddate"));			
			map.put("createdate", rs.getString("q.createdate"));			
			map.put("type", rs.getInt("q.type"));			
			map.put("cnt", rs.getInt("t.cnt"));			
			list.add(map);
		}
		
		conn.close();
		return list;
	}
	
	
	public Question selectQuestionOne(int num) throws ClassNotFoundException, SQLException {
		Question q = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT num, title, startdate, enddate, createdate, type FROM question WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			q = new Question();
			q.setNum(num);
			q.setTitle(rs.getString("title"));
			q.setStartdate(rs.getString("startDate"));
			q.setEnddate(rs.getString("enddate"));
			q.setType(rs.getInt("type")); // checkbox or radio
		}
		return q;
	}
	
	
	// 입력 후 자동으로 생성된 키값을 반환값으로 받기
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; // 키값을 받아올 때 사용 (입력 X)
		
		String sql = "INSERT INTO question(title, startdate, enddate, type) VALUES(?,?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		// Statement.RETURN_GENERATED_KEYS 옵션: insert 후 select max(pk) from ... 실행
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		
		int row = stmt.executeUpdate(); // insert
		rs = stmt.getGeneratedKeys(); // select max(num) from question
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		conn.close();
		return pk;
	}
	
	
	// 삭제 메서드
	public int deleteQuestion(Question d) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM question WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, d.getNum());
		
		int row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	
	// 전체 수정 메서드
	public int updateQuestion(Question u) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE question SET title = ? startdate = ? enddate = ? type = ? WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, u.getTitle());
		stmt.setString(2, u.getStartdate());
		stmt.setString(3, u.getEnddate());
		stmt.setInt(4, u.getType());
		stmt.setInt(5, u.getNum());
		
		int row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	
	// 종료 날짜 수정 메서드
	public int updateEnddate(Question ue) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE question SET enddate = ? WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, ue.getEnddate());
		stmt.setInt(2, ue.getNum());
		
		int row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
}
