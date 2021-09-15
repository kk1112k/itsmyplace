package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Comm;
import com.icia.itsmyplace.model.CommCmt;
import com.icia.itsmyplace.model.CommPht;

@Repository("commDao")
public interface CommDao {
	
	//커뮤니티 총 게시물 수 조회
	public long commListCount(Comm comm);
	
	//커뮤니티 게시물 리스트 조회
	public List<Comm> commList(Comm comm);
	
	//커뮤니티 게시물 단일 조회
	public Comm commSelect(long bbsSeq);
	
	//커뮤니티 게시물 작성
	public int commInsert(Comm comm);
	
	//커뮤니티 게시글 수정
	public int commUpdate(Comm comm);
	
	//커뮤니티 게시물 사진첨부
	public int commPhtInsert(CommPht commPht);
	
	//조회수 증가
	public int bbsReadCntPlus(long bbsSeq);
	
	//첨부사진 리스트 조회
	public List<CommPht> commPhtList(long bbsSeq);
	
	//첨부사진 조회
	public CommPht commPhtSelect(CommPht commPht);
	
	//댓글 리스트 조회
	public List<CommCmt> commCmtList(CommCmt commCmt);
	
	//댓글 단일 조회
	public CommCmt commCmtSelect(CommCmt commCmt);
	
	//댓글 작성
	public int commCmtInsert(CommCmt commCmt);
	
	//댓글 수정
	public int commCmtUpdate(CommCmt commCmt);
	
	//댓글 한 개 삭제
	public int commCmtDelete(CommCmt commCmt);
	
	//댓글 전부 삭제
	public int commCmtDeleteAll(CommCmt commCmt);
	
	//게시글 삭제
	public int commDelete(long bbsSeq);
	
	//게시글 첨부사진 전부 삭제
	public int commPhtDeleteAll(long bbsSeq);
	
	//게시물 첨부사진 하나 삭제
	public int commPhtDelete(CommPht commPht);
	
	//게시물 첨부사진 삭제후 phtNum 업데이트
	public int commPhtUpdate(CommPht commPht);
	
}
