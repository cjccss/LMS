<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
#table {
	width: 90%;
 	border-collapse: collapse;
 	border-top: 1px solid #ccc;
}
#table th, #table td {
	padding: 5px;
 	height: 40px; 
 	border-bottom: 1px solid #ccc;
}
#table th {background-color: #ccc;}
  
.subjectStyle {
	font-weight: bold;
   	color: navy;
	cursor: pointer;
}
#newhit{ 
	position: relative;
	left: 91%;
	margin-bottom: 5px;
}
#btnadd{
	background-color: white;
	border: solid #ccc 1px;
	position: relative;
	left: 90%;
	top: -28px;		
	height: 30px;
}
.boarda{
	color:black;
}     
#displayList{
	border:solid 1px gray; 
	border-top:0px; width: 
	302px; height:100px; 
	margin-left:70px; 
	overflow:auto;
	position: relative;
	top:-28px;
}
</style>

<script type="text/javascript">

	$(document).ready(function(){

		
		$("select#newhit").val(${requestScope.newhit});
		
		
		$("span.subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
		
		
		$("span.subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
		
		$("input#searchWord").bind("keydown", function(event){
			if(event.keyCode == 13){
				// 엔터를 했을 경우
				goSearch();
			}
		});
		
      	$("div#displayList").hide();
      
      	$("input#searchWord").keyup(function(){
         
       		var wordLength = $(this).val().trim().length;
         	// 검색어의 길이를 알아온다.
         
         	if(wordLength == 0) {
            	$("div#displayList").hide();
         	}
         	else {
            	$.ajax({
               		url:"<%= ctxPath%>/board/wordSearchShow.sam",
           		 	type:"get",
               		data:{"searchType":$("select#searchType").val()
                   		 ,"searchWord":$("input#searchWord").val()
                   		 ,"categoryno":$("input#catnoSearch").val()},
               		dataType:"json",
               		success:function(json){ 
                  		if(json.length > 0) {
                     
                     		var html = "";
                     
                     		$.each(json, function(index, item){
                        		var word = item.word;
		                        
		                        var index = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());
		                        
		                        var len = $("input#searchWord").val().length;
		                        
		                        word = word.substr(0,index) + "<span style='color:blue;'>"+word.substr(index,len)+"</span>" + word.substr(index+len);
		                        
		                        html += "<span style='cursor:pointer;' class='word'>"+word+"</span><br>";
                     		});
                     
                   			$("div#displayList").html(html);
                   			$("div#displayList").show();
                 		}
           	 		},
               		error: function(request, status, error){
                  		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               		}
            	});
         	}
         
      	}); // end of  $("input#searchWord").keyup(function(){}
      
	   	$(document).on("click","span.word",function(){
	 		$("input#searchWord").val($(this).text()); 
	 		$("div#displayList").hide();
	 	 	goSearch();
	   	});
		     
	if(${not empty requestScope.paraMap}){
		$("select#searchType").val("${requestScope.paraMap.searchType}");
		$("input#searchWord").val("${requestScope.paraMap.searchWord}");
	}
	
	

	});// end of $(document).ready(function(){})------------------
	
	
	function goView(seq) {
		
		
		var frm = document.goViewFrm;
		frm.seq.value=seq;
		frm.searchType.value = "${requestScope.paraMap.searchType}";
	    frm.searchWord.value = "${requestScope.paraMap.searchWord}"; 
		frm.method="get";
		frm.action="<%= ctxPath%>/board/view.sam";
		frm.submit();
	    
	}// end of function goView(seq) {}-----------------------
	
	// 검색하기
	function goSearch(){
		var frm = document.searchFrm;
		frm.method="get";
		frm.action="<%=ctxPath%>/board/list.sam";
		frm.submit();
		
	} // end of function goSearch(){}
	
	// 최신순, 인기순 선택
	function gonewhit(){
		var frm = document.newhitFrm;
	   	frm.method = "get";
	   	frm.action = "<%=ctxPath%>/board/list.sam";
	   	frm.submit();
	} // end of function gonewhit(){}
	
	
</script>
	

<c:if test="${categoryno == 1 || categoryno == 2 || categoryno == 3}"> 	

	<div id="boardmenu" style="padding-left: 25%;">
		<ul>
			<li style='display:inline-block; font-size: 20pt;'><a class="boarda" href="<%=ctxPath%>/board/list.sam?categoryno=1">자유게시판</a><span style="border-right: 2px black solid; margin: 0 80px 0 80px;"></span></li>
			<li style='display:inline-block; font-size: 20pt;'><a class="boarda" href="<%=ctxPath%>/board/list.sam?categoryno=2">중고거래</a><span style="border-right: 2px black solid; margin: 0 80px 0 80px;"></span></li>	
			<li style='display:inline-block; font-size: 20pt;'><a class="boarda" href="<%=ctxPath%>/board/list.sam?categoryno=3">동아리&공모전 모집</a></li>	
		</ul>	
	</div>	

</c:if>  


<div style="padding-left: 10%; padding-right:10%;">
	<h2 style="margin-bottom: 30px;">
		<c:if test="${categoryno == 1}">자유게시판</c:if>
 		<c:if test="${categoryno == 2}">중고거래</c:if>
 		<c:if test="${categoryno == 3}">동아리&공모전 모집</c:if> 
 		<c:if test="${categoryno == 4}">공지사항</c:if> 
 		<c:if test="${categoryno == 5}">Q&A</c:if> 
 	</h2>

	<c:if test="${categoryno == 1}">
	 	<form name="newhitFrm">
			<select id="newhit" name="newhit" onChange="gonewhit()">
				<option value="1">최신순</option>
				<option value="2">인기순</option>
			</select>
			<input type="hidden" name="categoryno" value="${categoryno}">
		</form>
	</c:if>

	<table id="table" style="width: 1100px;">
		<tr>
			<th style="width: 60px;  text-align: center;">번호</th>
			<th style="width: 390px; text-align: center;">제목</th>
			<th style="width: 60px; text-align: center;">추천</th>
			<th style="width: 60px;  text-align: center;">작성자</th>
			<th style="width: 130px; text-align: center;">작성일자</th>
			<th style="width: 60px;  text-align: center;">조회수</th>
		</tr>
		
		<c:forEach var="boardvo" items="${requestScope.boardList}" varStatus="status"> 
		   <tr>	
	   	   	   <td align="center">${boardvo.seq}</td>
		   	   <td align="left">
		   	   
		   	   <!-- 첨부파일이 없는 경우   -->
		   	   <c:if test="${empty boardvo.fileName}">
		   	   	   <!-- 답변글이 아닌 원글인 경우 -->
		   	   	   <c:if test="${boardvo.depthno == 0}">
			   	   	   <c:if test="${boardvo.commentCount > 0}">
				   	   		<span class="subject" onclick="goView('${boardvo.seq}')">${boardvo.subject} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${boardvo.commentCount}</span>]</span> </span> 
				   	   </c:if>
				   	   <c:if test="${boardvo.commentCount == 0}">
				   	   	 	<span class="subject" onclick="goView('${boardvo.seq}')">${boardvo.subject}</span>
			   	  	   </c:if>
			   	   </c:if>
			   	   
			   	   <!-- 답변글인 경우 -->
		   	   	   <c:if test="${boardvo.depthno > 0}">
			   	   	   <c:if test="${boardvo.commentCount > 0}">
				   	   		<span class="subject" onclick="goView('${boardvo.seq}')"><span style="color: red; font-style: italic; padding-left: ${boardvo.depthno * 5}px;">┗Re&nbsp;</span>${boardvo.subject} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${boardvo.commentCount}</span>]</span> </span> 
				   	   </c:if>
				   	   <c:if test="${boardvo.commentCount == 0}">
				   	   	 	<span class="subject" onclick="goView('${boardvo.seq}')"><span style="color: red; font-style: italic; padding-left: ${boardvo.depthno * 5}px;">┗Re&nbsp;</span>${boardvo.subject}</span>
			   	  		 </c:if>
			   	   </c:if>			 
	   	  	   </c:if>
	   	  	   
	   	  	   <!-- 첨부파일이 있는 경우   -->
		   	   <c:if test="${not empty boardvo.fileName}">
		   	   	   <!-- 답변글이 아닌 원글인 경우 -->
		   	   	   <c:if test="${boardvo.depthno == 0}">
			   	   	   <c:if test="${boardvo.commentCount > 0}">
				   	   		<span class="subject" onclick="goView('${boardvo.seq}')">${boardvo.subject} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${boardvo.commentCount}</span>]</span> </span> &nbsp;<img src="<%=ctxPath%>/resources/images/disk.gif" /> 
				   	   </c:if>
				   	   <c:if test="${boardvo.commentCount == 0}">
				   	   	 	<span class="subject" onclick="goView('${boardvo.seq}')">${boardvo.subject}</span> &nbsp;<img src="<%=ctxPath%>/resources/images/disk.gif" />
			   	  		 </c:if>
			   	   </c:if>
			   	   
			   	   <!-- 답변글인 경우 -->
		   	   	   <c:if test="${boardvo.depthno > 0}">
			   	   	   <c:if test="${boardvo.commentCount > 0}">
				   	   		<span class="subject" onclick="goView('${boardvo.seq}')"><span style="color: red; font-style: italic; padding-left: ${boardvo.depthno * 5}px;">┗Re&nbsp;</span>${boardvo.subject} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${boardvo.commentCount}</span>]</span> </span> &nbsp;<img src="<%=ctxPath%>/resources/images/disk.gif" /> 
				   	   </c:if>
				   	   <c:if test="${boardvo.commentCount == 0}">
				   	   	 	<span class="subject" onclick="goView('${boardvo.seq}')"><span style="color: red; font-style: italic; padding-left: ${boardvo.depthno * 5}px;">┗Re&nbsp;</span>${boardvo.subject}</span> &nbsp;<img src="<%=ctxPath%>/resources/images/disk.gif" />
			   	  		 </c:if>
			   	   </c:if>			 
	   	  	   </c:if>	 
	   	  		
		   	   </td>
		   	   <td align="center">${boardvo.good}</td>
		   	   <c:if test="${boardvo.namecheck == 0}">
		       		<td align="center">${boardvo.name}</td>
		       </c:if>
		       <c:if test="${boardvo.namecheck == 1}">
		       		<td align="center">익명</td>
		       </c:if>
		       <td align="center">${boardvo.regDate}</td>
		       <td align="center">${boardvo.readCount}</td>
		   </tr>
		</c:forEach>		
	</table>		

	<%-- 검색창(글쓴이,글제목) --%>
	<div id="bottomop" style="height: 30px;"> 
		<form name="searchFrm" style="margin-top: 20px; ">
			<input type="hidden" name="categoryno" id="catnoSearch" value="${categoryno}"/>
	   		<select name="searchType" id="searchType" style="height: 26px;">
	      		<option value="subject">글제목</option>
	       		<option value="name">글쓴이</option>
	     	</select>
	    	<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
	   	 	<button type="button" onclick="goSearch()">검색</button>
		</form>
		
		<c:if test="${categoryno != 4 || (categoryno == 4 && sessionScope.loginuser.identity == 2)}">
			<button type="button" id="btnadd" onclick="javascript:location.href='<%= ctxPath%>/board/add.sam?categoryno=${categoryno}'">게시글 등록</button>
		</c:if>
	
		<%-- 검색어 입력시 자동글 완성하기 1--%>
		<div id="displayList"></div>		
	</div>	
	
	<%-- 페이지 바 --%>
	<div style="text-align:center; width:70%; border:solid 0px grey; margin:20px auto;">
		${requestScope.pageBar}  
	</div>
</div>


<form name="goViewFrm">
	<input type="hidden" name="seq" />
	<input type="hidden" name="gobackURL" value="${requestScope.gobackURL}" />
	<input type="hidden" name="categoryno" value="${categoryno}">
	<input type="hidden" name="searchType" />
    <input type="hidden" name="searchWord" />
</form>
