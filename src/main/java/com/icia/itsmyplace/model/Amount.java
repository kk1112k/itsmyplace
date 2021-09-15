/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.model
 * 파일명     : Amount.java
 * 작성일     : 2021. 2. 24.
 * 작성자     : mslim
 * </pre>
 */
package com.icia.itsmyplace.model;

import java.io.Serializable;

/**
 * <pre>
 * 패키지명   : com.icia.web.model
 * 파일명     : Amount.java
 * 작성일     : 2021. 2. 24.
 * 작성자     : mslim
 * 설명       :
 * </pre>
 */
public class Amount implements Serializable
{
	private static final long serialVersionUID = 2722346989429774731L;
	
	private int total;       // 전체 결제 금액
	private int tax_free;    // 비과세 금액
	private int vat;         // 부가세 금액
	private int point;       // 사용한 포인트 금액
	private int discount;    // 할인 금액

	/**
	 * 생성자
	 */
	public Amount()
	{
		total = 0;
		tax_free = 0;
		vat = 0;
		point = 0;
		discount = 0;
	}

	/**
	 * <pre>
	 * 메소드명   : getTotal
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getTotal()
	{
		return total;
	}

	/**
	 * <pre>
	 * 메소드명   : setTotal
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param total
	 */
	public void setTotal(int total)
	{
		this.total = total;
	}

	/**
	 * <pre>
	 * 메소드명   : getTax_free
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getTax_free()
	{
		return tax_free;
	}

	/**
	 * <pre>
	 * 메소드명   : setTax_free
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param tax_free
	 */
	public void setTax_free(int tax_free)
	{
		this.tax_free = tax_free;
	}

	/**
	 * <pre>
	 * 메소드명   : getVat
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getVat()
	{
		return vat;
	}

	/**
	 * <pre>
	 * 메소드명   : setVat
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param vat
	 */
	public void setVat(int vat)
	{
		this.vat = vat;
	}

	/**
	 * <pre>
	 * 메소드명   : getPoint
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getPoint()
	{
		return point;
	}

	/**
	 * <pre>
	 * 메소드명   : setPoint
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param point
	 */
	public void setPoint(int point)
	{
		this.point = point;
	}

	/**
	 * <pre>
	 * 메소드명   : getDiscount
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getDiscount()
	{
		return discount;
	}

	/**
	 * <pre>
	 * 메소드명   : setDiscount
	 * 작성일     : 2021. 2. 24.
	 * 작성자     : mslim
	 * 설명       :
	 * </pre>
	 * @param discount
	 */
	public void setDiscount(int discount)
	{
		this.discount = discount;
	}
	
	@Override
	public String toString()
	{
		return "{total:"+total+", tax_free:"+tax_free+", vat:"+vat+", point:"+point+", discount:"+discount+"}";
	}
}
