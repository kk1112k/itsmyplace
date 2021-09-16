/**
 * <pre>
 * 프로젝트명 : BasicBoard
 * 패키지명   : com.icia.common.model
 * 파일명     : FileData.java
 * </pre>
 */
package com.icia.common.model;

import java.io.Serializable;

/**
 * <pre>
 * 패키지명   : com.icia.common.model
 * 파일명     : FileData.java
 * 설명       : 파일 모델
 * </pre>
 */
public class FileData implements Serializable
{
	private static final long serialVersionUID = -2662137800290034364L;
	
	// input name
	private String name;
	// 파일명
	private String fileName;
	// 원본 파일명
	private String fileOrgName;
	// 파일 저장 경로
	private String filePath;
	// 파일 확장자
	private String fileExt;
	// 파일 크기(byte)
	private long fileSize;
	// 컨텐츠 타입
	private String contentType;
	
	/**
	 * 생성자 
	 */
	public FileData()
	{
		name = "";
		fileName = "";
		fileOrgName = "";
		filePath = "";
		fileExt = "";
		fileSize = 0;
		contentType = "";
	}

	/**
	 * <pre>
	 * 메소드명   : getName
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getName()
	{
		return name;
	}

	/**
	 * <pre>
	 * 메소드명   : setName
	 * 설명       :
	 * </pre>
	 * @param name
	 */
	public void setName(String name)
	{
		this.name = name;
	}

	/**
	 * <pre>
	 * 메소드명   : getFileName
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getFileName()
	{
		return fileName;
	}

	/**
	 * <pre>
	 * 메소드명   : setFileName
	 * 설명       :
	 * </pre>
	 * @param fileName
	 */
	public void setFileName(String fileName)
	{
		this.fileName = fileName;
	}

	/**
	 * <pre>
	 * 메소드명   : getFileOrgName
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getFileOrgName()
	{
		return fileOrgName;
	}

	/**
	 * <pre>
	 * 메소드명   : setFileOrgName
	 * 설명       :
	 * </pre>
	 * @param fileOrgName
	 */
	public void setFileOrgName(String fileOrgName)
	{
		this.fileOrgName = fileOrgName;
	}

	/**
	 * <pre>
	 * 메소드명   : getFilePathk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getFilePath()
	{
		return filePath;
	}

	/**
	 * <pre>
	 * 메소드명   : setFilePath
	 * 설명       :
	 * </pre>
	 * @param filePath
	 */
	public void setFilePath(String filePath)
	{
		this.filePath = filePath;
	}

	/**
	 * <pre>
	 * 메소드명   : getFileExt
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getFileExt()
	{
		return fileExt;
	}

	/**
	 * <pre>
	 * 메소드명   : setFileExt
	 * 설명       :
	 * </pre>
	 * @param fileExt
	 */
	public void setFileExt(String fileExt)
	{
		this.fileExt = fileExt;
	}

	/**
	 * <pre>
	 * 메소드명   : getFileSize
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public long getFileSize()
	{
		return fileSize;
	}

	/**
	 * <pre>
	 * 메소드명   : setFileSize
	 * 설명       :
	 * </pre>
	 * @param fileSize
	 */
	public void setFileSize(long fileSize)
	{
		this.fileSize = fileSize;
	}

	/**
	 * <pre>
	 * 메소드명   : getContentType
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getContentType()
	{
		return contentType;
	}

	/**
	 * <pre>
	 * 메소드명   : setContentType
	 * 설명      :
	 * </pre>
	 * @param contentType
	 */
	public void setContentType(String contentType)
	{
		this.contentType = contentType;
	}
}
