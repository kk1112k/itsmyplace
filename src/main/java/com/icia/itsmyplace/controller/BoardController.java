package com.icia.itsmyplace.controller;

import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Board;
import com.icia.itsmyplace.model.BoardFile;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.service.BoardService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

@Controller("boardController")
public class BoardController {
	private static Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BoardService BoardService;
	
	private static final int LIST_COUNT = 5; 	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;	// 페이징 수
	
	
	@RequestMapping(value="/board/list")
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		//조회항목(1:작성자조회, 2:제목조회, 3:내용조회)
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Board> list = null;
		//조회 객체
		Board search = new Board();
		//페이징 객체
		Paging paging = null;
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		else {
			searchType = "";
			searchValue = "";
		}
		
		totalCount = BoardService.boardListCount(search);
		
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0) {
			paging = new Paging("/board/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = BoardService.boardList(search);  
		}
		
		model.addAttribute("list", list);   
		model.addAttribute("searchType", searchType);   
		model.addAttribute("searchValue", searchValue); 
		model.addAttribute("curPage", curPage); 
		model.addAttribute("paging", paging);  
		
		return "/board/list";		
	}
	
	//게시물 등록 폼
	@RequestMapping(value="/board/writeForm")
	public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//조회항목(1:작성자조회, 2:제목조회, 3:내용조회)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		User user = userService.userSelect(cookieUserId);
		
		model.addAttribute("searchType", searchType);//writeform.jsp에서 사용할 이름
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		// --- list 페이지에 가기 위한 용도
		model.addAttribute("user", user); // user객체도 담음
		return "/board/noticeWriteForm";
	}
	
	//게시물 등록 처리하는 폼
	@RequestMapping(value="/board/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOAD_SAVE_DIR);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			Board board = new Board();
			board.setUserId(cookieUserId);
			board.setBbsTitle(bbsTitle);
			board.setBbsContent(bbsContent);
			//첨부파일확인
			if(fileData != null && fileData.getFileSize() > 0) {
				BoardFile boardFile = new BoardFile();
				
				boardFile.setFileName(fileData.getFileName());
				boardFile.setFileOrgName(fileData.getFileOrgName());
				boardFile.setFileExt(fileData.getFileExt());
				boardFile.setFileSize(fileData.getFileSize());
				//hiboard.java -> hiBoardFile
				board.setBoardFile(boardFile); // 파일이 들어가는(set되는) 코드줄
			}
			
			try {
				if(BoardService.boardInsert(board) > 0) {
					ajaxResponse.setResponse(0, "Success / 500 in try in if");
				}
				else {
					ajaxResponse.setResponse(500, "Internal Server Error / 500 in try in else");
				}
				
			} catch(Exception e) {
				
				logger.error("[BoardController]/board/writeProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error / 500 in catch");
			}
		}
		
		else {
			ajaxResponse.setResponse(400, "Bad Request / 400");
		}
		
		logger.debug("[BoardController] /board/writeProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	//게시물 조회
	@RequestMapping(value="/board/view")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물 번호
		long BbsSeq = HttpUtil.get(request, "hiBbsSeq", (long)0);
		//조회항목(1.작성자, 2.제목, 3.내용)
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//본인글 여부
		String boardMe = "N";
		
		Board board = null;
		
		if(BbsSeq > 0)
		{
			board = BoardService.boardView(BbsSeq);
			if(board != null && StringUtil.equals(board.getUserId(), cookieUserId)) {
				boardMe = "Y"; // 본인 글임
			}
		}
		
		model.addAttribute("hiBbsSeq", BbsSeq);
		model.addAttribute("hiBoard", board);
		model.addAttribute("boardMe", boardMe);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		
		return "/board/view";
	}
	
	//게시물 삭제
	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response){ //ajax통신에대한결과값리턴
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(bbsSeq > 0) {
			Board board = BoardService.boardSelect(bbsSeq);
			
			if(board != null) {
				if(StringUtil.equals(board.getUserId(), cookieUserId)) {
					try {
						if(BoardService.boardAnswersCount(board.getBbsSeq()) > 0) {
							ajaxResponse.setResponse(-999, "Answers exist and cannot be deleted");
						}
						else {
							if(BoardService.boardDelete(board.getBbsSeq()) > 0) {
								ajaxResponse.setResponse(0, "success");
							}
							else {//게시물삭제실패
								ajaxResponse.setResponse(500, "Internal Server Error 500");
							}
						}		
					} catch(Exception e) {
						logger.error("[BoardController] /board/delete Exception", e);
						}
				}
				else {
					ajaxResponse.setResponse(400, "Not Found 400");
				}
			}
			else {
				ajaxResponse.setResponse(400, "Not Found 400");
			}
		}
		else {
			ajaxResponse.setResponse(400, "Bad Request 400");
		}
		
		logger.debug("[BoardController] /board/delete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	//게시물 수정 화면
	@RequestMapping(value="/board/updateForm")
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		//dispatcherservlet에서 받아서 
		//쿠키값 - 로그인확인용도 env에 들어있는 유저의 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물번호
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0); // 맨 마지막은 값 안들어왔을 때 대체하기 위한 디폴트값
		//조회항목(1:작성자, 2:제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		// 
		// --------- 게시물보기화면인 view.jsp에서 수정버튼을 눌렀을 때 처리되는 값들을 담기 위한 변수 선언
		//링크치고 한번에 들어오는거 방지
		Board board = null;
		User user = null;
		
		if(bbsSeq > 0) { //클라이언트에서 요청이 들어왔을 경우
			board = BoardService.boardView(bbsSeq);
			//삭제는 별도페이지를가져올필요가 없음 아작스통신으로 서버프로그램호출하고 결과값만가져오기만하면됨
			//수정은 따로 가져가야댐 현재잇는페이지 데이터를 가지고가서 수정할수잇는화면으로이동
			
			if(board != null) {
				if(StringUtil.equals(board.getUserId(), cookieUserId)) {
					user = userService.userSelect(cookieUserId);
				}
				else {
					board = null;
				}
			}
		}
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("hiBoard", board);
		model.addAttribute("user", user);
		return "/board/updateForm";
	}
	
	//게시물 수정 폼
	   @RequestMapping(value="/board/updateProc", method=RequestMethod.POST)
	   @ResponseBody
	   public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	   {
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
	      String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
	      String bbsContent = HttpUtil.get(request, "bbsContent", "");
	      FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOAD_SAVE_DIR);
	      
	      Response<Object> ajaxResponse = new Response<Object>();
	      
	      if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
	      {
	         Board board = BoardService.boardSelect(bbsSeq);
	         
	         if(board != null)
	         {
	            if(StringUtil.equals(board.getUserId(), cookieUserId))
	            {
	               board.setBbsSeq(bbsSeq);
	               board.setBbsTitle(bbsTitle);
	               board.setBbsContent(bbsContent);
	               
	               if(fileData != null && fileData.getFileSize() > 0)
	               {
	                  BoardFile boardFile = new BoardFile();
	                  
	                  boardFile.setFileName(fileData.getFileName());
	                  boardFile.setFileOrgName(fileData.getFileOrgName());
	                  boardFile.setFileExt(fileData.getFileExt());
	                  boardFile.setFileSize(fileData.getFileSize());
	                  
	                  board.setBoardFile(boardFile);
	               }
	            }
	            
	            try
	            {
	               if(BoardService.boardUpdate(board) > 0)
	               {
	                  ajaxResponse.setResponse(0, "Success"); 
	               }
	               else
	               {
	                  ajaxResponse.setResponse(500, "500 Internal Server Error");
	               }
	            }
	            catch(Exception e)
	            {
	               logger.error("[BoardController] /board/updateProc Exception", e);
	               ajaxResponse.setResponse(500, "500 Internal Server Error"); 
	            }
	         }      
	         else {
	            ajaxResponse.setResponse(404, "404 Not Found");  //본인 게시물이 아닙니다.
	         }
	      
	      }
	      else {
	         ajaxResponse.setResponse(400, "400 Bad Request");
	      }
	      logger.debug("[BoardController] /board/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
	      
	      return ajaxResponse;
	   }
	
	// 게시판 답변
	@RequestMapping(value="/board/replyForm", method=RequestMethod.POST)
	public String replyForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Board board = null;
		User user = null;
		
		if(bbsSeq > 0) { //클라이언트에서 요청이 들어왔을 경우
			board = BoardService.boardSelect(bbsSeq);

			if(board != null) {
					user = userService.userSelect(cookieUserId);
			}
		}
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("hiBoard", board);
		model.addAttribute("user", user);
		
		return "/board/replyForm";
	}
	
	// 게시물 답변 폼
	@RequestMapping(value="/board/replyProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyProc(MultipartHttpServletRequest request, HttpServletResponse response){
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOAD_SAVE_DIR);
		
		Response<Object> ajaxResponse = new Response<Object>();
		if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			Board parentBoard = BoardService.boardSelect(bbsSeq);
			
			if(parentBoard != null) {
				Board board = new Board();
				
				//Board에 대한 것 적용
				board.setUserId(cookieUserId);
				board.setBbsTitle(bbsTitle);
				board.setBbsContent(bbsContent);
				board.setBbsGroup(parentBoard.getBbsGroup());
				board.setBbsOrder(parentBoard.getBbsOrder() + 1);
				board.setBbsIndent(parentBoard.getBbsIndent() + 1);
				board.setBbsParent(bbsSeq);
				
				//File에 대한 것 적용
				if(fileData != null && fileData.getFileSize() > 0) {
					BoardFile boardFile = new BoardFile();
					
					boardFile.setFileName(fileData.getFileName());
					boardFile.setFileOrgName(fileData.getFileOrgName());
					boardFile.setFileExt(fileData.getFileExt());
					boardFile.setFileSize(fileData.getFileSize());
					
					board.setBoardFile(boardFile);
				}
				
			try {
				if(BoardService.boardReplyInsert(board) > 0) {
					ajaxResponse.setResponse(0,  "Success");
				}
				else {
					ajaxResponse.setResponse(500, "500 Internal Server Error");
				}
				
			} catch(Exception e) {
				logger.error("[HiboardController] /board/replyProc Exception");
				ajaxResponse.setResponse(500, "500 Internal Server Error");
			}
				
			}
			else {
				//부모글이 없다면
				ajaxResponse.setResponse(404, "404 Not Found");
			}
		}
		else {
			ajaxResponse.setResponse(400, "400 Bad Request");
		}
		
		logger.debug("[BoardController] /board/replyProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	//첨부파일 다운로드(게시글에 올라와있는)
	@RequestMapping(value="/board/download")
	public ModelAndView download(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		if(bbsSeq > 0) {
			BoardFile boardFile = BoardService.boardFileSelect(bbsSeq);
			
			if(boardFile != null) {
				File file = new File(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + boardFile.getFileName());
				
				logger.debug("UPLOAD_SAVE_DIR : " + UPLOAD_SAVE_DIR);
				logger.debug("FileUtil.getFileSeparator() : " + FileUtil.getFileSeparator());
				logger.debug("boardFile.getFileName() : " + boardFile.getFileName());
				
				if(FileUtil.isFile(file)) { // 파일이 존재하는지를 확인
					modelAndView = new ModelAndView();
					
					//servlet-context.xml에 정의한 ID
					modelAndView.setViewName("fileDownloadView");
					modelAndView.addObject(file);
					modelAndView.addObject("fileName", boardFile.getFileOrgName()); // 파일 이름 지정
					
					return modelAndView;
				}
			}
			
		}
		
		return modelAndView;
	}
	
	
	//예약하기
	@RequestMapping(value="/board/reservation")
	public String reservation(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		
		return "/board/reservation";		
	}
}
