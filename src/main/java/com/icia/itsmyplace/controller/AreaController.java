//package com.icia.itsmyplace.controller;
//
//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.ModelMap;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.icia.common.util.StringUtil;
//import com.icia.itsmyplace.model.Area;
//import com.icia.itsmyplace.model.Response;
//import com.icia.itsmyplace.model.SubArea;
//import com.icia.itsmyplace.service.AreaService;
//import com.icia.itsmyplace.util.HttpUtil;
//import com.icia.itsmyplace.util.JsonUtil;
//
//@Controller("areaController")
//public class AreaController {
//   private static Logger logger = LoggerFactory.getLogger(AreaController.class);
//   
//   //쿠키명
//   @Value("#{env['auth.cookie.name']}")
//   private String AUTH_COOKIE_NAME;
//
//   @Autowired
//   private AreaService areaService;
//   
//   //지역 체크
//   @RequestMapping(value="/subAreaSelect", method=RequestMethod.POST)
//   @ResponseBody
//   public Response<Object> subAreaSelect(HttpServletRequest request, HttpServletResponse response)
//   {
//	   String areaNum = HttpUtil.get(request, "areaNum");
//	   Response<Object> ajaxResponse = new Response<Object>();
//   	   
//	   
//	   List<SubArea> list = null;
//   	   list = areaService.subAreaSelect(areaNum);
// 
//   	   return ajaxResponse;
//	  
//   }
//
//
//   
//   
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
