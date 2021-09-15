/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.model
 * 파일명     : KakaoPayApprove.java
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
 * 파일명     : KakaoPayApprove.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * 설명       :
 * </pre>
 */
public class KakaoPayApprove implements Serializable
{
	private static final long serialVersionUID = -266108768930594609L;

	private String aid;                 // 요청 고유 번호
	private String tid;                 // 결제 고유 번호
	private String cid;                 // 가맹점 코드
	private String sid;                 // 정기결제용 ID, 정기결제 CID로 단건결제 요청 시 발급
	private String partner_order_id;    // 가맹점 주문번호, 최대 100자
	private String partner_user_id;     // 가맹점 회원 id, 최대 100자
	private String payment_method_type; // 결제 수단, CARD 또는 MONEY 중 하나
	private Amount amount;              // 결제 금액 정보
	private CardInfo card_info;         // 결제 상세 정보, 결제수단이 카드일 경우만 포함
	private String item_name;           // 상품 이름, 최대 100자
	private String item_code;           // 상품 코드, 최대 100자
	private int quantity;               // 상품 수량
	private Date created_at;            // 결제 준비 요청 시각
	private Date approved_at;           // 결제 승인 시각
	private String payload;             // 결제 승인 요청에 대해 저장한 값, 요청 시 전달된 내용
	
	/**
	 * 생성자
	 */
	public KakaoPayApprove()
	{
		aid = "";
		tid = "";
		cid = "";
		sid = "";
		partner_order_id = "";
		partner_user_id = "";
		payment_method_type = "";
		amount = null;
		card_info = null;
		item_name = "";
		item_code = "";
		quantity = 0;
		created_at = null;
		approved_at = null;
		payload = "";
	}

	/**
	 * <pre>
	 * 메소드명   : getAid
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getAid()
	{
		return aid;
	}

	/**
	 * <pre>
	 * 메소드명   : setAid
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param aid
	 */
	public void setAid(String aid)
	{
		this.aid = aid;
	}

	/**
	 * <pre>
	 * 메소드명   : getTid
	 * 작성일     : 2021. 2. 24.
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
	 * 작성일     : 2021. 2. 24.
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
	 * 메소드명   : getCid
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getCid()
	{
		return cid;
	}

	/**
	 * <pre>
	 * 메소드명   : setCid
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param cid
	 */
	public void setCid(String cid)
	{
		this.cid = cid;
	}

	/**
	 * <pre>
	 * 메소드명   : getSid
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getSid()
	{
		return sid;
	}

	/**
	 * <pre>
	 * 메소드명   : setSid
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param sid
	 */
	public void setSid(String sid)
	{
		this.sid = sid;
	}

	/**
	 * <pre>
	 * 메소드명   : getPartner_order_id
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPartner_order_id()
	{
		return partner_order_id;
	}

	/**
	 * <pre>
	 * 메소드명   : setPartner_order_id
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param partner_order_id
	 */
	public void setPartner_order_id(String partner_order_id)
	{
		this.partner_order_id = partner_order_id;
	}

	/**
	 * <pre>
	 * 메소드명   : getPartner_user_id
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPartner_user_id()
	{
		return partner_user_id;
	}

	/**
	 * <pre>
	 * 메소드명   : setPartner_user_id
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param partner_user_id
	 */
	public void setPartner_user_id(String partner_user_id)
	{
		this.partner_user_id = partner_user_id;
	}

	/**
	 * <pre>
	 * 메소드명   : getPayment_method_type
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPayment_method_type()
	{
		return payment_method_type;
	}

	/**
	 * <pre>
	 * 메소드명   : setPayment_method_type
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param payment_method_type
	 */
	public void setPayment_method_type(String payment_method_type)
	{
		this.payment_method_type = payment_method_type;
	}

	/**
	 * <pre>
	 * 메소드명   : getAmount
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public Amount getAmount()
	{
		return amount;
	}

	/**
	 * <pre>
	 * 메소드명   : setAmount
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param amount
	 */
	public void setAmount(Amount amount)
	{
		this.amount = amount;
	}

	/**
	 * <pre>
	 * 메소드명   : getCard_info
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public CardInfo getCard_info()
	{
		return card_info;
	}

	/**
	 * <pre>
	 * 메소드명   : setCard_info
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param card_info
	 */
	public void setCard_info(CardInfo card_info)
	{
		this.card_info = card_info;
	}

	/**
	 * <pre>
	 * 메소드명   : getItem_name
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getItem_name()
	{
		return item_name;
	}

	/**
	 * <pre>
	 * 메소드명   : setItem_name
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param item_name
	 */
	public void setItem_name(String item_name)
	{
		this.item_name = item_name;
	}

	/**
	 * <pre>
	 * 메소드명   : getItem_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getItem_code()
	{
		return item_code;
	}

	/**
	 * <pre>
	 * 메소드명   : setItem_code
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param item_code
	 */
	public void setItem_code(String item_code)
	{
		this.item_code = item_code;
	}

	/**
	 * <pre>
	 * 메소드명   : getQuantity
	 * 작성일     : 2021. 2. 24.
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
	 * 작성일     : 2021. 2. 24.
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
	 * 메소드명   : getCreated_at
	 * 작성일     : 2021. 2. 24.
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
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param created_at
	 */
	public void setCreated_at(Date created_at)
	{
		this.created_at = created_at;
	}

	/**
	 * <pre>
	 * 메소드명   : getApproved_at
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public Date getApproved_at()
	{
		return approved_at;
	}

	/**
	 * <pre>
	 * 메소드명   : setApproved_at
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param approved_at
	 */
	public void setApproved_at(Date approved_at)
	{
		this.approved_at = approved_at;
	}

	/**
	 * <pre>
	 * 메소드명   : getPayload
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getPayload()
	{
		return payload;
	}

	/**
	 * <pre>
	 * 메소드명   : setPayload
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param payload
	 */
	public void setPayload(String payload)
	{
		this.payload = payload;
	}
	
	@Override
	public String toString()
	{
		return "{aid:"+aid+", tid:"+tid+", cid:"+cid+", sid:"+sid+", partner_order_id:"+partner_order_id+", partner_user_id:"+partner_user_id+", payment_method_type:"+payment_method_type+", amount:"+(amount != null ? amount : "null")+", card_info:"+(card_info != null ? card_info : "null")+", item_name:"+item_name+", item_code:"+item_code+", quantity:"+quantity+", created_at:"+(created_at != null ? created_at : "null")+", approved_at:"+(approved_at != null ? approved_at : "null")+", payload:"+payload+"}";
	}
}
