package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Board;
import com.icia.itsmyplace.model.BoardFile;

@Repository("boardDao")
public interface BoardDao 
{
	//게시물 등록
	public int boardInsert(Board board);
	
	//게시물 첨부파일 등록
	public int boardFileInsert(BoardFile boardFile);
	
	//게시물 총수
	public long boardListCount(Board board);
	
	//게시물 리스트
	public List<Board> boardList(Board board);
	
	//게시물 조회
	public Board boardSelect(long bbsSeq);
	
	//게시물 조회수 증가
	public int boardReadCntPlus(long bbsSeq);
	
	//게시물 첨부파일 조회
	public BoardFile boardFileSelect(long bbsSeq);
	
	//게시물 삭제시 답변글 체크
	public int boardAnswersCount(long bbsSeq);
	
	//게시물 삭제
	public int boardDelete(long bbsSeq);
	
	//첨부파일 삭제
	public int boardFileDelete(long bbsSeq);
	
	//게시물 수정
	public int boardUpdate(Board board);
	
	//게시물 그룹 순서 변경
	public int boardGroupOrderUpdate(Board board);
	
	//게시물 답글 등록
	public int boardReplyInsert(Board board);
}