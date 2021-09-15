/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.model
 * 파일명     : KakaoPayReady.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * </pre>
 */
package com.icia.itsmyplace.model;

import java.io.Serializable;
import java.util.Date;

/**
 * <pre>
 * 패키지명   : com.icia.web.model
 * 파일명     : KakaoPayReady.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * 설명       :
 * </pre>
 */
public class KakaoPayReady implements Serializable
{
	private static final long serialVersionUID = 5853380595046193205L;

	private String tid;                      // 결제 고유 번호, 20자
	private String next_redirect_app_url;    // 요청한 클라이언트(Client)가 모바일 앱일 경우 카카오톡 결제 페이지 Redirect URL
	private String next_redirect_mobile_url; // 요청한 클라이언트가 모바일 웹일 경우 카카오톡 결제 페이지 Redirect URL
	private String next_redirect_pc_url;     // 요청한 클라이언트가 PC 웹일 경우 카카오톡으로 결제 요청 메시지(TMS)를 보내기 위한 사용자 정보 입력 화면 Redirect URL
	private String android_app_scheme;       // 카카오페이 결제 화면으로 이동하는 Android 앱 스킴(Scheme)
	private String ios_app_scheme;           // 카카오페이 결제 화면으로 이동하는 iOS 앱 스킴
	private Date created_at;                 // 결제 준비 요청 시간
	
	/**
	 * 생성자 
	 */
	public KakaoPayReady()
	{
		tid = "";
		next_redirect_app_url = "";
		next_redirect_mobile_url = "";
		next_redirect_pc_url = "";
		android_app_scheme = "";
		ios_app_scheme = "";
		created_at = null;
	}

	/**
	 * <pre>
	 * 메소드명   : getTid
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getTid()
	{
		return tid;
	}

	/**
	 * <pre>
	 * 메소드명   : setTid
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param tid
	 */
	public void setTid(String tid)
	{
		this.tid = tid;
	}

	/**
	 * <pre>
	 * 메소드명   : getNext_redirect_app_url
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getNext_redirect_app_url()
	{
		return next_redirect_app_url;
	}

	/**
	 * <pre>
	 * 메소드명   : setNext_redirect_app_url
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param next_redirect_app_url
	 */
	public void setNext_redirect_app_url(String next_redirect_app_url)
	{
		this.next_redirect_app_url = next_redirect_app_url;
	}

	/**
	 * <pre>
	 * 메소드명   : getNext_redirect_mobile_url
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getNext_redirect_mobile_url()
	{
		return next_redirect_mobile_url;
	}

	/**
	 * <pre>
	 * 메소드명   : setNext_redirect_mobile_url
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param next_redirect_mobile_url
	 */
	public void setNext_redirect_mobile_url(String next_redirect_mobile_url)
	{
		this.next_redirect_mobile_url = next_redirect_mobile_url;
	}

	/**
	 * <pre>
	 * 메소드명   : getNext_redirect_pc_url
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getNext_redirect_pc_url()
	{
		return next_redirect_pc_url;
	}

	/**
	 * <pre>
	 * 메소드명   : setNext_redirect_pc_url
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param next_redirect_pc_url
	 */
	public void setNext_redirect_pc_url(String next_redirect_pc_url)
	{
		this.next_redirect_pc_url = next_redirect_pc_url;
	}

	/**
	 * <pre>
	 * 메소드명   : getAndroid_app_scheme
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getAndroid_app_scheme()
	{
		return android_app_scheme;
	}

	/**
	 * <pre>
	 * 메소드명   : setAndroid_app_scheme
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param android_app_scheme
	 */
	public void setAndroid_app_scheme(String android_app_scheme)
	{
		this.android_app_scheme = android_app_scheme;
	}

	/**
	 * <pre>
	 * 메소드명   : getIos_app_scheme
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getIos_app_scheme()
	{
		return ios_app_scheme;
	}

	/**
	 * <pre>
	 * 메소드명   : setIos_app_scheme
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param ios_app_scheme
	 */
	public void setIos_app_scheme(String ios_app_scheme)
	{
		this.ios_app_scheme = ios_app_scheme;
	}

	/**
	 * <pre>
	 * 메소드명   : getCreated_at
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public Date getCreated_at()
	{
		return created_at;
	}

	/**
	 * <pre>
	 * 메소드명   : setCreated_at
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param created_at
	 */
	public void setCreated_at(Date created_at)
	{
		this.created_at = created_at;
	}
	
	@Override
	public String toString()
	{
		/*
		tid = "";
		next_redirect_app_url = "";
		next_redirect_mobile_url = "";
		next_redirect_pc_url = "";
		android_app_scheme = "";
		ios_app_scheme = "";
		created_at = null;
		pg_token = "";
		*/
		return "{tid:"+tid+", next_redirect_app_url:"+next_redirect_app_url+", next_redirect_mobile_url:"+next_redirect_mobile_url+", next_redirect_pc_url:"+next_redirect_pc_url+", android_app_scheme:"+android_app_scheme+", ios_app_scheme:"+ios_app_scheme+", created_at:"+created_at+"}";
	}
}
