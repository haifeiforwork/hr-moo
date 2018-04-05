package com.moorim.hr.common;

import java.text.MessageFormat;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
/**  
 * @Class Name : ImagePaginationRenderer.java
 * @Description : ImagePaginationRenderer Class
 * @Modification Information  
 * @
 * @  �닔�젙�씪      �닔�젙�옄              �닔�젙�궡�슜
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           理쒖큹�깮�꽦
 * 
 * @author 媛쒕컻�봽�젅�엫�썚�겕 �떎�뻾�솚寃� 媛쒕컻��
 * @since 2009. 03.16
 * @version 1.0
 * @see
 * 
 *  Copyright (C) by MOPAS All right reserved.
 */
public class EgovImgPaginationRenderer extends AbstractPaginationRenderer {
	
	/**
	    * PaginationRenderer
		* 
	    * @see 媛쒕컻�봽�젅�엫�썚�겕 �떎�뻾�솚寃� 媛쒕컻��
	    */
		public EgovImgPaginationRenderer() {
			/*
			String strWebDir = "/images/egovframework/cmmn/";

			firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" +
								"<image src='" + strWebDir + "btn_page_pre10.gif' border=0/></a>&#160;"; 
	        previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" +
	        						"<image src='" + strWebDir + "btn_page_pre1.gif' border=0/></a>&#160;";
	        currentPageLabel = "<span class='paging_on'>{0}</span>&#160;";
	        otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><class='paging_off'>{2}</span></a>&#160;";
	        nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" +
	        					"<image src='" + strWebDir + "btn_page_next1.gif' border=0/></a>&#160;";
	        lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" +
	        					"<image src='" + strWebDir + "btn_page_next10.gif' border=0/></a>&#160;";
	        */
			
//			firstPageLabel = "<span><a href=\"#\" onclick=\"{0}({1}); return false;\"><<</a></span>"; 
//			previousPageLabel = "<span><a href=\"#\" onclick=\"{0}({1}); return false;\"><</a></span>";
//			currentPageLabel = "<span class='on'>{0}</span>";
//			otherPageLabel = "<span><a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a></span>";
//			nextPageLabel = "<span><a href=\"#\" onclick=\"{0}({1}); return false;\">></a></span>";
//			lastPageLabel = "<span><a href=\"#\" onclick=\"{0}({1}); return false;\">>></a></span>";
			firstPageLabel = "<div class=\"table_nav\">"; 
			previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"prev_btn\"></a>";
			currentPageLabel = "<a href=\"#\" class=\"num_btn selected\">{0}</a>";
			otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"num_btn\">{2}</a>";
			nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"next_btn on01\">�떎�쓬�럹�씠吏�踰꾪듉</a> ";
			lastPageLabel = "</div>";
		}
		
		//�럹�씠吏� 遺�遺� override �븷�븣 �궗�슜 @ Override �꽔怨� 諛묒뿉 遺�遺� �닔�젙�븷 寃�
		@Override
		public String renderPagination( PaginationInfo paginationInfo, String jsFunction ) {
			
			StringBuffer strBuff = new StringBuffer();
	        
	        int firstPageNo = paginationInfo.getFirstPageNo();
	        int firstPageNoOnPageList = paginationInfo.getFirstPageNoOnPageList();
	        int totalPageCount = paginationInfo.getTotalPageCount();
			int pageSize = paginationInfo.getPageSize();
			int lastPageNoOnPageList = paginationInfo.getLastPageNoOnPageList();
			int currentPageNo = paginationInfo.getCurrentPageNo();
			int lastPageNo = paginationInfo.getLastPageNo();

			if( totalPageCount > pageSize ) {
				if( firstPageNoOnPageList > pageSize ) {
					strBuff.append(MessageFormat.format(firstPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNo)}));
					strBuff.append(MessageFormat.format(previousPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNoOnPageList-1)}));
		        } else {
		        	strBuff.append(MessageFormat.format(firstPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNo)}));
					strBuff.append(MessageFormat.format(previousPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNo)}));
		        }
			} else {
	        	strBuff.append(MessageFormat.format(firstPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNo)}));
				strBuff.append(MessageFormat.format(previousPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNo)}));
			}
			
			for( int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++ ) {
				if( i == currentPageNo ) {
	        		strBuff.append(MessageFormat.format(currentPageLabel,new Object[]{Integer.toString(i)}));
	        	} else {
	        		strBuff.append(MessageFormat.format(otherPageLabel,new Object[]{jsFunction,Integer.toString(i),Integer.toString(i)}));
	        	}
	        }
	        
			if( totalPageCount > pageSize ) {
				if( lastPageNoOnPageList < totalPageCount ) {
		        	strBuff.append(MessageFormat.format(nextPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNoOnPageList+pageSize)}));
		        	strBuff.append(MessageFormat.format(lastPageLabel,new Object[]{jsFunction,Integer.toString(lastPageNo)}));
		        } else {
		        	strBuff.append(MessageFormat.format(nextPageLabel,new Object[]{jsFunction,Integer.toString(lastPageNo)}));
		        	strBuff.append(MessageFormat.format(lastPageLabel,new Object[]{jsFunction,Integer.toString(lastPageNo)}));
		        }
			} else {
	        	strBuff.append(MessageFormat.format(nextPageLabel,new Object[]{jsFunction,Integer.toString(lastPageNo)}));
	        	strBuff.append(MessageFormat.format(lastPageLabel,new Object[]{jsFunction,Integer.toString(lastPageNo)}));
			}
			
			return strBuff.toString();
		}
}