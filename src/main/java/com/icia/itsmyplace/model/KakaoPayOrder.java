/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.model
 * 파일명     : KakaoPayOrder.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * </pre>
 */
package com.icia.itsmyplace.model;

import java.io.Serializable;

/**
 * <pre>
 * 패키지명   : com.icia.web.model
 * 파일명     : KakaoPayOrder.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * 설명       :
 * </pre>
 */
public class KakaoPayOrder implements Serializable
{
	private static final long serialVersionUID = 757258850995727183L;
	
	private String partnerOrderId; // 가맹점 주문번호, 최대 100자
	private String partnerUserId;  // 가맹점 회원 id, 최대 100자
	private String itemName;       // 상품명, 최대 100자
	private String itemCode;       // 상품코드, 최대 100자
	private int quantity;          // 상품 수량
	private int totalAmount;       // 상품 총액
	private int taxFreeAmount;     // 상품 비과세 금액
	private int vatAmount;         // 상품 부가세 금액 값을 보내지 않을 경우 다음과 같이 VAT 자동 계산 (상품총액 - 상품 비과세 금액)/11 : 소숫점 이하 반올림
	
	private String tId;            // 결제 고유 번호, 20자  
	private String pgToken;        // 결제승인 요청을 인증하는 토큰 사용자 결제 수단 선택 완료 시, approval_url로 redirection해줄 때 pg_token을 query string으로 전달
	 	
	/**
	 * 생성자
	 */
	public KakaoPayOrder()
	{
		partnerOrderId = "";
		partnerUserId = "";
		itemName = "";
		itemCode = "";
		quantity = 0;
		totalAmount = 0;
		taxFreeAmount = 0;
		vatAmount = 0;
		tId = "";
		pgToken = "";
	}

	/**
	 * <pre>
	 * 메소드명   : getPartnerOrderId
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPartnerOrderId()
	{
		return partnerOrderId;
	}

	/**
	 * <pre>
	 * 메소드명   : setPartnerOrderId
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param partnerOrderId
	 */
	public void setPartnerOrderId(String partnerOrderId)
	{
		this.partnerOrderId = partnerOrderId;
	}

	/**
	 * <pre>
	 * 메소드명   : getPartnerUserId
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPartnerUserId()
	{
		return partnerUserId;
	}

	/**
	 * <pre>
	 * 메소드명   : setPartnerUserId
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param partnerUserId
	 */
	public void setPartnerUserId(String partnerUserId)
	{
		this.partnerUserId = partnerUserId;
	}

	/**
	 * <pre>
	 * 메소드명   : getItemName
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getItemName()
	{
		return itemName;
	}

	/**
	 * <pre>
	 * 메소드명   : setItemName
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param itemName
	 */
	public void setItemName(String itemName)
	{
		this.itemName = itemName;
	}

	/**
	 * <pre>
	 * 메소드명   : getItemCode
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getItemCode()
	{
		return itemCode;
	}

	/**
	 * <pre>
	 * 메소드명   : setItemCode
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param itemCode
	 */
	public void setItemCode(String itemCode)
	{
		this.itemCode = itemCode;
	}

	/**
	 * <pre>
	 * 메소드명   : getQuantity
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getQuantity()
	{
		return quantity;
	}

	/**
	 * <pre>
	 * 메소드명   : setQuantity
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param quantity
	 */
	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}

	/**
	 * <pre>
	 * 메소드명   : getTotalAmount
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getTotalAmount()
	{
		return totalAmount;
	}

	/**
	 * <pre>
	 * 메소드명   : setTotalAmount
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param totalAmount
	 */
	public void setTotalAmount(int totalAmount)
	{
		this.totalAmount = totalAmount;
	}

	/**
	 * <pre>
	 * 메소드명   : getTaxFreeAmount
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getTaxFreeAmount()
	{
		return taxFreeAmount;
	}

	/**
	 * <pre>
	 * 메소드명   : setTaxFreeAmount
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param taxFreeAmount
	 */
	public void setTaxFreeAmount(int taxFreeAmount)
	{
		this.taxFreeAmount = taxFreeAmount;
	}

	/**
	 * <pre>
	 * 메소드명   : getVatAmount
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getVatAmount()
	{
		return vatAmount;
	}

	/**
	 * <pre>
	 * 메소드명   : setVatAmount
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param vatAmount
	 */
	public void setVatAmount(int vatAmount)
	{
		this.vatAmount = vatAmount;
	}
	
	/**
	 * <pre>
	 * 메소드명   : gettId
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String gettId()
	{
		return tId;
	}

	/**
	 * <pre>
	 * 메소드명   : settId
	 * 작성일     : 2021. 2. 23.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param tId
	 */
	public void settId(String tId)
	{
		this.tId = tId;
	}

	/**
	 * <pre>
	 * 메소드명   : getPgToken
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPgToken()
	{
		return pgToken;
	}

	/**
	 * <pre>
	 * 메소드명   : setPgToken
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param pgToken
	 */
	public void setPgToken(String pgToken)
	{
		this.pgToken = pgToken;
	}

	@Override
	public String toString()
	{
		return "{partnerOrderId:"+partnerOrderId+", partnerUserId:"+partnerUserId+", itemName:"+itemName+", itemCode:"+itemCode+", quantity:"+quantity+", totalAmount:"+totalAmount+", taxFreeAmount:"+taxFreeAmount+", vatAmount:"+vatAmount+", tId:"+tId+", pgToken:"+pgToken+"}";
	}
}
