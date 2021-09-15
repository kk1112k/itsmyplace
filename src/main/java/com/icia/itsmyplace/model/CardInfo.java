/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.model
 * 파일명     : CardInfo.java
 * 작성일     : 2021. 2. 24.
 * 작성자     : mslim
 * </pre>
 */
package com.icia.itsmyplace.model;

import java.io.Serializable;

/**
 * <pre>
 * 패키지명   : com.icia.web.model
 * 파일명     : CardInfo.java
 * 작성일     : 2021. 2. 24.
 * 작성자     : mslim
 * 설명       :
 * </pre>
 */
public class CardInfo implements Serializable
{
	private static final long serialVersionUID = 4760273473847172802L;

	private String purchase_corp;                // 매입 카드사 한글명
	private String purchase_corp_code;           // 매입 카드사 코드
	private String issuer_corp;                  // 카드 발급사 한글명
	private String issuer_corp_code;             // 카드 발급사 코드
	private String kakaopay_purchase_corp;       // 카카오페이 매입사명
	private String kakaopay_purchase_corp_code;  // 카카오페이 매입사 코드
	private String kakaopay_issuer_corp;         // 카카오페이 발급사명
	private String kakaopay_issuer_corp_code;    // 카카오페이 발급사 코드
	private String bin;                          // 카드 BIN
	private String card_type;                    // 카드 타입
	private String install_month;                // 할부 개월 수
	private String approved_id;                  // 카드사 승인번호
	private String card_mid;                     // 카드사 가맹점 번호
	private String interest_free_install;        // 무이자할부 여부(Y/N)
	private String card_item_code;               // 카드 상품 코드
	
	/**
	 * 생성자 
	 */
	public CardInfo()
	{
		purchase_corp = "";
		purchase_corp_code = "";
		issuer_corp = "";
		issuer_corp_code = "";
		kakaopay_purchase_corp = "";
		kakaopay_purchase_corp_code = "";
		kakaopay_issuer_corp = "";
		kakaopay_issuer_corp_code = "";
		bin = "";
		card_type = "";
		install_month = "";
		approved_id = "";
		card_mid = "";
		interest_free_install = "";
		card_item_code = "";
	}

	/**
	 * <pre>
	 * 메소드명   : getPurchase_corp
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPurchase_corp()
	{
		return purchase_corp;
	}

	/**
	 * <pre>
	 * 메소드명   : setPurchase_corp
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param purchase_corp
	 */
	public void setPurchase_corp(String purchase_corp)
	{
		this.purchase_corp = purchase_corp;
	}

	/**
	 * <pre>
	 * 메소드명   : getPurchase_corp_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPurchase_corp_code()
	{
		return purchase_corp_code;
	}

	/**
	 * <pre>
	 * 메소드명   : setPurchase_corp_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param purchase_corp_code
	 */
	public void setPurchase_corp_code(String purchase_corp_code)
	{
		this.purchase_corp_code = purchase_corp_code;
	}

	/**
	 * <pre>
	 * 메소드명   : getIssuer_corp
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getIssuer_corp()
	{
		return issuer_corp;
	}

	/**
	 * <pre>
	 * 메소드명   : setIssuer_corp
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param issuer_corp
	 */
	public void setIssuer_corp(String issuer_corp)
	{
		this.issuer_corp = issuer_corp;
	}

	/**
	 * <pre>
	 * 메소드명   : getIssuer_corp_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getIssuer_corp_code()
	{
		return issuer_corp_code;
	}

	/**
	 * <pre>
	 * 메소드명   : setIssuer_corp_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param issuer_corp_code
	 */
	public void setIssuer_corp_code(String issuer_corp_code)
	{
		this.issuer_corp_code = issuer_corp_code;
	}

	/**
	 * <pre>
	 * 메소드명   : getKakaopay_purchase_corp
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getKakaopay_purchase_corp()
	{
		return kakaopay_purchase_corp;
	}

	/**
	 * <pre>
	 * 메소드명   : setKakaopay_purchase_corp
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param kakaopay_purchase_corp
	 */
	public void setKakaopay_purchase_corp(String kakaopay_purchase_corp)
	{
		this.kakaopay_purchase_corp = kakaopay_purchase_corp;
	}

	/**
	 * <pre>
	 * 메소드명   : getKakaopay_purchase_corp_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getKakaopay_purchase_corp_code()
	{
		return kakaopay_purchase_corp_code;
	}

	/**
	 * <pre>
	 * 메소드명   : setKakaopay_purchase_corp_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param kakaopay_purchase_corp_code
	 */
	public void setKakaopay_purchase_corp_code(String kakaopay_purchase_corp_code)
	{
		this.kakaopay_purchase_corp_code = kakaopay_purchase_corp_code;
	}

	/**
	 * <pre>
	 * 메소드명   : getKakaopay_issuer_corp
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getKakaopay_issuer_corp()
	{
		return kakaopay_issuer_corp;
	}

	/**
	 * <pre>
	 * 메소드명   : setKakaopay_issuer_corp
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param kakaopay_issuer_corp
	 */
	public void setKakaopay_issuer_corp(String kakaopay_issuer_corp)
	{
		this.kakaopay_issuer_corp = kakaopay_issuer_corp;
	}

	/**
	 * <pre>
	 * 메소드명   : getKakaopay_issuer_corp_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getKakaopay_issuer_corp_code()
	{
		return kakaopay_issuer_corp_code;
	}

	/**
	 * <pre>
	 * 메소드명   : setKakaopay_issuer_corp_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param kakaopay_issuer_corp_code
	 */
	public void setKakaopay_issuer_corp_code(String kakaopay_issuer_corp_code)
	{
		this.kakaopay_issuer_corp_code = kakaopay_issuer_corp_code;
	}

	/**
	 * <pre>
	 * 메소드명   : getBin
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getBin()
	{
		return bin;
	}

	/**
	 * <pre>
	 * 메소드명   : setBin
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param bin
	 */
	public void setBin(String bin)
	{
		this.bin = bin;
	}

	/**
	 * <pre>
	 * 메소드명   : getCard_type
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getCard_type()
	{
		return card_type;
	}

	/**
	 * <pre>
	 * 메소드명   : setCard_type
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param card_type
	 */
	public void setCard_type(String card_type)
	{
		this.card_type = card_type;
	}

	/**
	 * <pre>
	 * 메소드명   : getInstall_month
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getInstall_month()
	{
		return install_month;
	}

	/**
	 * <pre>
	 * 메소드명   : setInstall_month
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param install_month
	 */
	public void setInstall_month(String install_month)
	{
		this.install_month = install_month;
	}

	/**
	 * <pre>
	 * 메소드명   : getApproved_id
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getApproved_id()
	{
		return approved_id;
	}

	/**
	 * <pre>
	 * 메소드명   : setApproved_id
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param approved_id
	 */
	public void setApproved_id(String approved_id)
	{
		this.approved_id = approved_id;
	}

	/**
	 * <pre>
	 * 메소드명   : getCard_mid
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getCard_mid()
	{
		return card_mid;
	}

	/**
	 * <pre>
	 * 메소드명   : setCard_mid
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param card_mid
	 */
	public void setCard_mid(String card_mid)
	{
		this.card_mid = card_mid;
	}

	/**
	 * <pre>
	 * 메소드명   : getInterest_free_install
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getInterest_free_install()
	{
		return interest_free_install;
	}

	/**
	 * <pre>
	 * 메소드명   : setInterest_free_install
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param interest_free_install
	 */
	public void setInterest_free_install(String interest_free_install)
	{
		this.interest_free_install = interest_free_install;
	}

	/**
	 * <pre>
	 * 메소드명   : getCard_item_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getCard_item_code()
	{
		return card_item_code;
	}

	/**
	 * <pre>
	 * 메소드명   : setCard_item_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param card_item_code
	 */
	public void setCard_item_code(String card_item_code)
	{
		this.card_item_code = card_item_code;
	}
	
	@Override
	public String toString()
	{
		return "{purchase_corp:"+purchase_corp+", purchase_corp_code:"+purchase_corp_code+", issuer_corp:"+issuer_corp+", issuer_corp_code:"+issuer_corp_code+", kakaopay_purchase_corp:"+kakaopay_purchase_corp+", kakaopay_purchase_corp_code:"+kakaopay_purchase_corp_code+", kakaopay_issuer_corp:"+kakaopay_issuer_corp+", kakaopay_issuer_corp_code:"+kakaopay_issuer_corp_code+", bin:"+bin+", card_type:"+card_type+", install_month:"+install_month+", approved_id:"+approved_id+", card_mid:"+card_mid+", interest_free_install:"+interest_free_install+", card_item_code:"+card_item_code+"}";
	}
}
