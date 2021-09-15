/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.service
 * 파일명     : KakaoPayService.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * </pre>
 */
package com.icia.itsmyplace.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.icia.itsmyplace.model.KakaoPayApprove;
import com.icia.itsmyplace.model.KakaoPayOrder;
import com.icia.itsmyplace.model.KakaoPayReady;

/**
 * <pre>
 * 패키지명   : com.icia.web.service
 * 파일명     : KakaoPayService.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * 설명       :
 * </pre>
 */
@Service("kakaoPayService")
public class KakaoPayService
{
	private static Logger logger = LoggerFactory.getLogger(KakaoPayService.class);
	
	// 카카오페이 호스트
	@Value("#{env['kakao.pay.host']}") 
	private String KAKAO_PAY_HOST;
	
	// 카카오페이 관리자 키
	@Value("#{env['kakao.pay.admin.key']}")
	private String KAKAO_PAY_ADMIN_KEY;
	
	// 카카오페이 가맹점 코드, 10자
	@Value("#{env['kakao.pay.cid']}")
	private String KAKAO_PAY_CID;
	
	// 카카오페이 결제 URL
	@Value("#{env['kakao.pay.ready.url']}")
	private String KAKAO_PAY_READY_URL;
	
	// 카카오페이 결제 요청 URL
	@Value("#{env['kakao.pay.approve.url']}")
	private String KAKAO_PAY_APPROVE_URL;
	
	// 카카오페이 결제 성공 URL
	@Value("#{env['kakao.pay.success.url']}")
	private String KAKAO_PAY_SUCCESS_URL;
	
	// 카카오페이 결제 취소 URL
	@Value("#{env['kakao.pay.cancel.url']}")
	private String KAKAO_PAY_CANCEL_URL;
	
	// 카카오페이 결제 실패 URL
	@Value("#{env['kakao.pay.fail.url']}")
	private String KAKAO_PAY_FAIL_URL;
	
	/**
	 * <pre>
	 * 메소드명   : kakaoPayReady
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       : 결제 준비
	 * </pre>
	 * @param kakaoPayOrder KakaoPayOrder
	 * @return KakaoPayReady
	 */
	public KakaoPayReady kakaoPayReady(KakaoPayOrder kakaoPayOrder)
	{
		KakaoPayReady kakaoPayReady = null;
		
		if(kakaoPayOrder != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			// 서버로 요청할 Header
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY); // admin key
	        // headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
	        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
	        
	        // 서버로 요청할 Body
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	        params.add("cid", KAKAO_PAY_CID);        // 가맹점 코드, 10자 (테스트 결제시 TC0ONETIME 사용)
	        params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());  // 가맹점 주문번호, 최대 100자
	        params.add("partner_user_id", kakaoPayOrder.getPartnerUserId()); // 가맹점 회원 id, 최대 100자
	        params.add("item_name", kakaoPayOrder.getItemName());     // 상품명, 최대 100자
	        params.add("item_code", kakaoPayOrder.getItemCode());     // 상품코드, 최대 100자
	        params.add("quantity", String.valueOf(kakaoPayOrder.getQuantity())); // 상품 수량
	        params.add("total_amount", String.valueOf(kakaoPayOrder.getTotalAmount()));      // 상품 총액
	        params.add("tax_free_amount", String.valueOf(kakaoPayOrder.getTaxFreeAmount()));    // 상품 비과세 금액
	        params.add("approval_url", KAKAO_PAY_SUCCESS_URL); // 결제 성공 시 redirect url, 최대 255자
	        params.add("cancel_url", KAKAO_PAY_CANCEL_URL);    // 결제 취소 시 redirect url, 최대 255자
	        params.add("fail_url", KAKAO_PAY_FAIL_URL); // 결제 실패 시 redirect url, 최대 255자	
	 
	        //요청하기 위해 Header(헤더)와 Body(데이터) 합치기
	        //Spring Framework에서 제공해주는 HttpEntity 클래스는 Header와 Body를 합쳐
	        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
	 
	        try 
	        {
	        	//POST 요청을 보내고 객체로 결과를 반환받는다
	            kakaoPayReady = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_READY_URL), body, KakaoPayReady.class);
	            
	            if(kakaoPayReady != null)
	            {
	            	kakaoPayOrder.settId(kakaoPayReady.getTid());
	            	
	            	logger.info("[KakaoPayService] kakaoPayReady : " + kakaoPayReady);
	            }
	            
	            
	        } 
	        catch (RestClientException e) 
	        {
	        	logger.error("[KakaoPayService] kakaoPayReady RestClientException", e);
	        } 
	        catch (URISyntaxException e) 
	        {
	        	logger.error("[KakaoPayService] kakaoPayReady URISyntaxException", e);
	        }
		}
		else
		{
			logger.error("[KakaoPayService] kakaoPayReady KakaoPayOrder is null");
		}
		
        return kakaoPayReady;
	}
	
	/**
	 * <pre>
	 * 메소드명   : kakaoPayApprove
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       : 결제 요청
	 * </pre>
	 * @param kakaoPayOrder KakaoPayOrder
	 * @return KakaoPayApprove
	 */
	public KakaoPayApprove kakaoPayApprove(KakaoPayOrder kakaoPayOrder)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		if(kakaoPayOrder != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			// 서버로 요청할 Header
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
	        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
	 
	        // 서버로 요청할 Body
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	        params.add("cid", KAKAO_PAY_CID);
	        params.add("tid", kakaoPayOrder.gettId());
	        params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());
	        params.add("partner_user_id", kakaoPayOrder.getPartnerUserId());
	        params.add("pg_token", kakaoPayOrder.getPgToken());
	        //params.add("total_amount", String.valueOf(kakaoPayOrder.getTotalAmount()));
	        
	        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
	        
	        try 
	        {
	        	kakaoPayApprove = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_APPROVE_URL), body, KakaoPayApprove.class);
	        	
	        	if(kakaoPayApprove != null)
	        	{
	        		logger.info("[KakaoPayService] kakaoPayApprove : " + kakaoPayApprove);
	        	}
	        
	        } 
	        catch (RestClientException e) 
	        {
	            logger.error("[KakaoPayService] kakaoPayApprove RestClientException", e);
	        } 
	        catch (URISyntaxException e) 
	        {
	            logger.error("[KakaoPayService] kakaoPayApprove URISyntaxException", e);
	        }
		}
		else
		{
			logger.error("[KakaoPayService] kakaoPayApprove KakaoPayOrder is null");
		}
		
		return kakaoPayApprove;
	}
}