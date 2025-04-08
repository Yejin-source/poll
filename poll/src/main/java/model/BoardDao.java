package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Board;
import dto.Paging;

public class BoardDao {
	// 페이징, 전체 내용 가져오는 메서드
	public ArrayList<Board> selectBoardList(Paging p) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM board ORDER BY ref DESC, pos LIMIT ?, ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		rs = stmt.executeQuery();
		ArrayList<Board> list = new ArrayList<>();
		// rs -> list
		while(rs.next()) {
			Board b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setCount(rs.getInt("count"));
			list.add(b);
		}
		conn.close();
		return list;
	}
	
	
	// 상세보기 메서드
	public Board selectBoardOne(int num) throws ClassNotFoundException, SQLException {
		Board b = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM board WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		
		// rs -> board
		if(rs.next()) {
			b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setRegdate(rs.getString("regdate"));
			b.setIp(rs.getString("ip"));
			b.setCount(rs.getInt("count"));
		}
		conn.close();
		return b;
	}
	

	// 새 글 입력(부모글)
	public void insertBoard(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; // 입력 직후 pk값을 반환 받기 위해
		String sql = "INSERT INTO board(name, subject, content, ref, pass, ip) VALUES (?,?,?,?,?,?)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		conn.setAutoCommit(false); // executeUpdate()시마다 자동 커밋기능을 false
		
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // ref==0인 경우 입력 직후 pk를 반환받기 위해서
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getRef());
		stmt.setString(5, b.getPass());
		stmt.setString(6, b.getIp());
		
		int row = stmt.executeUpdate(); 
		// ref==0인 경우 입력 직후 pk를 반환 받아서 ref값을 동일하게
		rs = stmt.getGeneratedKeys();
		int pk = 0;
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		
		System.out.println("BoardDao.insertBoard.jsp pk: "+ pk);
		
		
		System.out.println("BoardDao.insertBoard.jsp 답글 if문");
		PreparedStatement stmt2 = null;
		String sql2 = "UPDATE board SET ref = ? WHERE num = ?";
		
		stmt2 = conn.prepareStatement(sql2);
		// update 쿼리가 실패하면 이전의 insert도 롤백시켜야 함 -> con.rollback();
		
		stmt2.setInt(1, pk);
		stmt2.setInt(2, pk);
		stmt2.executeUpdate();
			
		conn.commit(); // conn.setAutoCommit(false); 코드 때문에 필요함
		conn.close();
	}
	
	
	// 답글 입력
	public void insertBoardReply(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		// 트랜잭션(2개 이상의 (CUD)쿼리 한 묶음처럼 처리하고자 할 때
		conn.setAutoCommit(false); // executeUpdate()시마다 자동 커밋기능을 false
		
		// ref가 같고 pos값이 현재글보다 크거나 같다면 pos = pos+1
				PreparedStatement stmt2 = null;
				String sql2 = "UPDATE board SET pos = pos+1 WHERE ref=? AND pos >= ?";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setInt(1, b.getRef());
				stmt2.setInt(2, b.getPos());
				int row2 = stmt2.executeUpdate();
		
		// 답글 입력
		String sql = "INSERT INTO board(name, subject, content, ref, pos, depth, pass, ip) VALUES (?,?,?,?,?,?,?,?)";
		PreparedStatement stmt = null;
		
		stmt = conn.prepareStatement(sql); // ref==0인 경우 입력 직후 pk를 반환받기 위해서
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		
		stmt.setInt(4, b.getRef());
		stmt.setInt(5, b.getPos());
		stmt.setInt(6, b.getDepth());
		
		stmt.setString(7, b.getPass());
		stmt.setString(8, b.getIp());
		
		int row = stmt.executeUpdate(); 
		
		conn.commit(); // conn.setAutoCommit(false); 코드 때문에 필요함
		conn.close();
	}
	
	
	// 수정 메서드
	public void updateBoard(Board u) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE board SET name = ?, subject = ?, content = ? WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, u.getName());
		stmt.setString(2, u.getSubject());
		stmt.setString(3, u.getContent());
		stmt.setInt(4, u.getNum());
		System.out.println("BoardDao.java updateBoard stmt: " + stmt);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("수정 완료");
		} else {
			System.out.println("수정 실패");
		}
		conn.close();
	}
	
	
	// 삭제 메서드
	public void deleteBoard(Board d) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// 비밀번호가 일치하면 바뀌는 것으로 수정
		String sql = "DELETE FROM board WHERE num = ? AND pass = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, d.getNum());
		stmt.setString(2, d.getPass());
		System.out.println("BoardDao.java deleteBoard stmt: " + stmt);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("삭제 완료");
		} else {
			System.out.println("삭제 실패");
		}
		conn.close();
	}
	
	
	/*
	 	int 매개변수 VS Board 객체 매개변수 
	 	
	 	int 매개변수
	 	특정 값만 전달하고 처리함 
	 	단순한 숫자 하나만 전달 
	   	추가적인 데이터가 필요할 경우 메서드를 수정해야 함
	   	
	   	객체 매개변수
	   	여러 관련된 데이터를 하나의 객체로 묶어서 전달함
	   	객체 안에 여러 데이터(속성)가 들어있음
	   	메서드를 변경하지 않아도 객체 속성을 추가해서 사용 가능함
	 */
}
