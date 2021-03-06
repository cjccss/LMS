package com.spring.finalproject3.yeonha;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;



@Component
@Repository
public class BoardDAO implements InterBoardDAO {

	@Resource 
	private SqlSessionTemplate sqlsession; 

	// 게시판 글쓰기완료, 게시글 등록 ( 파일첨부X)
	@Override
	public int add(BoardVO boardvo) {
		int n = sqlsession.insert("board.add", boardvo);
		return n;
	}

	// 총 게시물 건수(totalCount) 구하기
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("board.getTotalCount", paraMap);
		return n;
	}

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한것)
	@Override
	public List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("board.boardListSearchWithPaging", paraMap);
		return boardList;
	}

	// 검색어 입력시 자동글 완성하기
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession.selectList("board.wordSearchShow", paraMap);
		return wordList;
	}

	// 글1개 조회하기
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = sqlsession.selectOne("board.getView", paraMap);
		return boardvo;
	}

	// 글조회수 1증가 하기
	@Override
	public void setAddReadCount(String seq) {
		sqlsession.update("board.setAddReadCount", seq);		
	}

	// 댓글쓰기
	@Override
	public int addComment(CommentVO commentvo) {
		int n = sqlsession.insert("board.addComment", commentvo);
		return n;
	}

	// tbl_board 테이블에 commentCount 컬럼의 값을 1증가(update)
	@Override
	public int updateCommentCount(String fk_seq) {
		int n = sqlsession.update("board.updateCommentCount", fk_seq);
		return n;
	}

	// 원게시물에 딸린 댓글들을 조회해오기
	@Override
	public List<CommentVO> getCommentList(String fk_seq) {
		List<CommentVO> commentList = sqlsession.selectList("board.getCommentList", fk_seq);
		return commentList;
	}

	// 원게시물에 딸린 댓글들을 페이징처리해서 조회해오기(Ajax 로 처리)
	@Override
	public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<CommentVO> commentList = sqlsession.selectList("board.getCommentListPaging", paraMap);
		return commentList;
	}

	// 원글 글번호(parentSeq)에 해당하는 댓글의 총 페이지수를 알아오기
	@Override
	public int getCommentTotalPage(Map<String, String> paraMap) {
		int totalPage = sqlsession.selectOne("board.getCommentTotalPage", paraMap);
		return totalPage;
	}

	// 이전글, 다음글 필요없이 조회수 증가없는 글 1개 받아오기
	@Override
	public BoardVO getViewNo(String seq) {
		BoardVO boardvo = sqlsession.selectOne("board.getViewNo", seq);
		return boardvo;
	}

	// 글수정 페이지 완료하기 
	@Override
	public int edit(BoardVO boardvo) {
		int n = sqlsession.update("board.edit", boardvo);
		return n;
	}

	// 게시글 삭제하기
	@Override
	public int del(int seqno) {
		int n = sqlsession.delete("board.del", seqno);
		return n;
	}

	// tbl_board 테이블에서 groupno 컬럼의 최대값 구하기
	@Override
	public int getGroupnoMax() {
		int max = sqlsession.selectOne("board.getGroupnoMax");
	    return max;
	}

	// 첨부파일이 있는 글쓰기
	@Override
	public int add_withFile(BoardVO boardvo) {
		int n = sqlsession.insert("board.add_withFile", boardvo);
		return n;
	}

	// 게시물 좋아요
	@Override
	public int goodAdd(String seq) {
		int n = sqlsession.update("board.goodAdd", seq);
		return n;
	}

	// tbl_comment에서 댓글 삭제
	@Override
	public int delcomment(int comseq) {
		int n = sqlsession.delete("board.delcomment", comseq);
		return n;
	}

	// tbl_board에서 commentCount -1 하기
	@Override
	public int minusCommentCount(String fk_seq) {
		int m = sqlsession.update("board.minusCommentCount", fk_seq);
		return m;
	}

	// tbl_comment 테이블에서 co_groupno 컬럼의 최대값 구하기
	@Override
	public int getco_GroupnoMax() {
		int max = sqlsession.selectOne("board.getco_GroupnoMax");
	    return max;
	}

	// 댓글 수정완료하기
	@Override
	public int comEditEnd(Map<String, String> paraMap) {
		int n = sqlsession.update("board.comEditEnd", paraMap);
		return n;
	}

	// 게시물 좋아요 수 알아오기
	@Override
	public int likeCount(String seq) {
		int likecnt = sqlsession.selectOne("board.likeCount", seq);
		return likecnt;
	}

	// 게시글에 첨부파일이 있는지 확인하기(수정)
	@Override
	public String isFilename(BoardVO boardvo) {
		String filename = sqlsession.selectOne("board.isFilename", boardvo);
		return filename;
	}

	// 첨부파일 삭제 체크시 첨부파일 삭제
	@Override
	public int delFile(BoardVO boardvo) {
		int n = sqlsession.delete("board.delFile", boardvo);
		return n;
	}

	// 첨부파일이 없는 경우라면(수정)
	@Override
	public int edit_withFile(BoardVO boardvo) {
		int n = sqlsession.update("board.edit_withFile", boardvo);
		return n;
	}






}
