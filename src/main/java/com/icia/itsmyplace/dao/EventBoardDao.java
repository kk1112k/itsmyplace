package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.EventBoard;
import com.icia.itsmyplace.model.EventBoardFile;





@Repository("eventBoardDao")
public interface EventBoardDao 
{
	//게시물 리스트
	public List<EventBoard> eventBoardList(EventBoard eventBoard);

	//게시물 조회
	public EventBoard eventBoardSelect(long bbsSeq);
	
	//게시물 카운트 create by 도움
	public long eventBoardListCount(EventBoard eventBoard);

	//게시물 등록
	public int eventBoardInsert(EventBoard eventBoard);
	
	//게시물 첨부파일 등록
	public int eventBoardFileInsert(EventBoardFile eventBoardFile);

	//이걸로타야되나..?
	public EventBoard eventBoardDetail(long bbsSeq);

	//게시물 조회수 증가
	public int eventBoardReadCntPlus(long bbsSeq);
		
	//게시물 첨부파일 조회
	public EventBoardFile eventBoardFileSelect(long bbsSeq);
	
	//게시물 삭제
	public int eventBoardDelete(long bbsSeq);
	
	//첨부파일 삭제
	public int eventBoardFileDelete(long bbsSeq);

	//게시물 수정
	public int eventBoardUpdate(EventBoard eventBoard);
	
	//Public 자동 업데이트
	public int eventPublicUpdate();

	
}
