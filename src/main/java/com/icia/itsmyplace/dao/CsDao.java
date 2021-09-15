package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Cs;

@Repository("csDao")
public interface CsDao {
	
	//게시물 등록
	public int csInsert(Cs cs);
	
	//게시물 총수
	public long csListCount(Cs cs);
	
	//게시물 리스트
	public List<Cs> csList(Cs cs);
	
	//게시물 조회
	public Cs csSelect(long bbsSeq);
	
	//게시물 조회수 증가
	public int csReadCntPlus(long bbsSeq);

	//게시물 삭제시 답변글 체크
	public int csAnswersCount(long bbsSeq);
	
	//게시물 삭제
	public int csDelete(long bbsSeq);
	
	//게시물 수정
	public int csUpdate(Cs cs);
	
	//게시물 그룹 순서 변경
	public int csGroupOrderUpdate(Cs cs);
	
	//게시물 답글 등록
	public int csReplyInsert(Cs cs);
	
}
