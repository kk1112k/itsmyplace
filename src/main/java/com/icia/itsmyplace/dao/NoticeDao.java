package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Notice;
import com.icia.itsmyplace.model.NoticeFile;

@Repository("noticeDao")
public interface NoticeDao {
	//게시물 등록
	public int noticeInsert(Notice notice);
	//게시물 첨부파일 등록
	public int noticeFileInsert(NoticeFile noticeFile);
	//게시물 총수
	public long noticeListCount(Notice notice);
	//게시물 리스트
	public List<Notice> noticeList(Notice notice);
	//게시물 조회
	public Notice noticeSelect(long bbsSeq);
	//게시물 조회수 증가
	public int noticeReadCntPlus(long bbsSeq);
	//게시물 첨부파일 조회
	public NoticeFile noticeFileSelect(long bbsSeq);
	//게시물 삭제
	public int noticeDelete(long bbsSeq);
	//첨부파일 삭제
	public int noticeFileDelete(long bbsSeq);
	//게시물 수정
	public int noticeUpdate(Notice notice);
//	//게시물 삭제시 답변글 체크
//	public int noticeAnswersCount(long bbsSeq);
//	//게시물 그룹 순서 변경
//	public int noticeGroupOrderUpdate(Notice notice);
//	//게시물 답글 등록
//	public int noticeReplyInsert(Notice notice);
}
