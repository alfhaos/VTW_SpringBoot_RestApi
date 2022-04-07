package com.example.demo.common.utils;

public class Utils {
	
	
	
	public static String getPageBar(int cPage, int numPerPage, int totalContent, String url) {
		
		StringBuilder pagebar = new StringBuilder(); 
		url = url + "?cPage="; // pageNo 추가전 상태
		
		final int pagebarSize = 5;
		final int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		final int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
		int pageNo = pageStart;

		pagebar.append("<nav id = \"pageBar\"\r\n"
				+ "			  <ul class=\"pagination justify-content-center pagination-sm\">\r\n"
				+ "			    ");
		
		
		
		// pageNo
		while(pageNo <= pageEnd) {
			if(pageNo == cPage) {
				// 현재페이지
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\r\n");
			}
			else {
				// 현재페이지가 아닌 경우
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\r\n");
			}
			
			pageNo++;
		}
		
		

		
		pagebar.append("			  </ul>\r\n"
				+ "			</nav>\r\n"
				+ "<script>"
				+ "function paging(pageNo){"
				
						+ "$.ajax({"
						+ "url:`" + url+"${pageNo}`,"
						+ "method:\"GET\","
						+ "success(resp){"
						+ "displayBoard(resp.board,resp.pagebar,resp.board.length);"
						+ "},"
						+ "error: console.log"
						+ "});"
								+ "}"

				+ "</script>");
		
		
		
		/*				+ "function paging(pageNo){"
				+ "location.href = `" + url + "${pageNo}`;}"
*/
		
		return pagebar.toString();
		
	}

}
