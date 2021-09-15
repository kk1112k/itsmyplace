package com.icia.itsmyplace.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.itsmyplace.dao.BoardDao;
import com.icia.itsmyplace.model.Board;
import com.icia.itsmyplace.model.BoardFile;

@Service("boardService")
public class BoardService 
{
   private static Logger logger = LoggerFactory.getLogger(BoardService.class);
   
   //파일 저장 디렉토리
   @Value("#{env['upload.save.dir']}")
   private String UPLOAD_SAVE_DIR;
   
   @Autowired
   private BoardDao boardDao;
   
   //게시물 등록
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   public int boardInsert(Board board) throws Exception
   {
      int count = boardDao.boardInsert(board);
      
      //게시물 정상 등록 되고, 첨부파일이 있다면 첨부파일 등록
      if(count > 0 && board.getBoardFile() != null)
      {
         BoardFile boardFile = board.getBoardFile();
         
         boardFile.setBbsSeq(board.getBbsSeq());
         boardFile.setFileSeq((short)1);
         
         boardDao.boardFileInsert(board.getBoardFile());
      }
      
      return count;
   }
   
   //총 게시물 수
   public long boardListCount(Board board)
   {
      long count = 0;
      
      try
      {
         count = boardDao.boardListCount(board);
      }
      catch(Exception e)
      {
         logger.error("[BoardService] boardListCount Exception", e);
      }
      
      return count;
   }
   
   //게시물 리스트
   public List<Board> boardList(Board board)
   {
      List<Board> list = null;
      
      try
      {
         list = boardDao.boardList(board);
      }
      catch(Exception e)
      {
         logger.error("[BoardService] boardList Exception", e);
      }
      
      return list;
   }
   
   //게시물 보기
   public Board boardView(long bbsSeq)
   {
      Board board = null;
      
      try
      {
         board = boardDao.boardSelect(bbsSeq);
         
         if(board != null)
         {
            //조회수 증가
            boardDao.boardReadCntPlus(bbsSeq);
            
            //첨부파일 조회
            BoardFile boardFile = boardDao.boardFileSelect(bbsSeq);
            
            if(boardFile != null)
            {
               board.setBoardFile(boardFile);
            }
         }
         
      }
      catch(Exception e)
      {
         logger.error("[BoardService] boardView Exception", e);
      }
      
      return board;
   }
   
   //게시물 조회
   public Board boardSelect(long bbsSeq) {
	   Board board = null;
	   
	   try {
		   board = boardDao.boardSelect(bbsSeq);
	   } catch(Exception e) {
		   logger.error("[BoardService] boardSelect Exception", e);
	   }
	   return board;
   }
   
   //게시물 삭제시 답변글 체크
   public int boardAnswersCount(long bbsSeq) {
	   int count = 0;
	   
	   try {
		   count = boardDao.boardAnswersCount(bbsSeq);
	   } catch(Exception e) {
		   logger.error("[BoardService] boardAnswersCount Exception", e);
	   }
	   
	   return count;
   }
   
   //게시물 삭제(파일이 있으면 같이 삭제)
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) //테이블 2개 걸기 위해 트랜잭션 사용
   public int boardDelete(long bbsSeq) throws Exception{
	   int count = 0;
	   
	   Board board = boardDao.boardSelect(bbsSeq);
	   
	   if(board != null) {
		   count = boardDao.boardDelete(bbsSeq);
		   
		   if(count > 0) {
			   BoardFile boardFile = boardDao.boardFileSelect(bbsSeq);
			   
			   if(boardFile != null) {
				   //테이블 삭제, 파일 삭제
				   if(boardDao.boardFileDelete(bbsSeq) > 0) {
					   FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + boardFile.getFileName());
				   }
			   }
		   }
	   }
	   
	   return count;
   }
   
   //게시물 수정
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) //테이블 2개 걸기 위해 트랜잭션 사용
   public int boardUpdate(Board board) throws Exception{
	   int count = boardDao.boardUpdate(board);
	   
	   if(count > 0 && board.getBoardFile() != null) { //업데이트가 발생하면 && 파일 정보가 있다면
		   BoardFile delBoardFile = boardDao.boardFileSelect(board.getBbsSeq());
		   
		   // 기존파일이 있으면 삭제
		   if(delBoardFile != null) {
			   FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delBoardFile.getFileName());
			   boardDao.boardFileDelete(board.getBbsSeq());
		   }
		   
		   BoardFile boardFile = board.getBoardFile();
		   boardFile.setBbsSeq(board.getBbsSeq());
		   boardFile.setFileSeq((short)1);
		   
		   boardDao.boardFileInsert(boardFile);
	   }
	   
	   
	   return count;
   }
   
   //답글 등록, 같은 그룹내 순서 업데이트
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) //테이블 2개 걸기 위해 트랜잭션 사용
   public int boardReplyInsert(Board board) throws Exception{
	   boardDao.boardGroupOrderUpdate(board);
	   
	   int count = boardDao.boardReplyInsert(board);
	   
	   if(count > 0  && board.getBoardFile() != null) {
		   BoardFile boardFile = new BoardFile();
		   
		   boardFile.setBbsSeq(board.getBbsSeq());
		   boardFile.setFileSeq((short)1);
		   
		   boardDao.boardFileInsert(board.getBoardFile());
		   
	   }
	   
	   return count;
   }
   
   //첨부파일 조회
   public BoardFile boardFileSelect(long bbsSeq) {
	   BoardFile boardFile = null;
	   
	   try {
		   boardFile = boardDao.boardFileSelect(bbsSeq);
	   } catch(Exception e) {
		   logger.error("[BoardService] boardFileSelect Exception", e);
	   }
	   
	   return boardFile;
   }
   
}