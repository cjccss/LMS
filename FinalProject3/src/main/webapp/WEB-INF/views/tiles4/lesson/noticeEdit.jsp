<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>    

<style type="text/css">

.headerName{
	text-align:center;
	font-weight: bolder;
}

.headerCategoty{
	display: inline-block; 
	padding-bottom:5px; 
	border-bottom: 1px gray solid; 
	font-size: 13pt; 
	font-weight: bold;
}

th, td {text-align:center;}   

th{
	background-color: #f2f2f2;
	
}

tr{

	border-top: solid 0.5px #bfbfbf;
	border-bottom: solid 0.5px #bfbfbf;
	height:40px;
}

div#btn-board{
	margin-top: 10px;
	display:inline-block;
	float:right;
}
	
.btn-board{
 	width:100px;
	border:0.5px solid #bfbfbf;
 	font-weight: bold;
 	margin-left:10px;	 	
 	margin-right:5px;
 	padding:5px;
 	border-radius: 5px;
 	height: 30px;
}


 .long {width: 80%;}

</style>

<script type="text/javascript">
   $(document).ready(function(){
      
      <%-- === #167. 스마트 에디터 구현 시작 === --%>
   	  //전역변수
      var obj = [];
      
      //스마트에디터 프레임생성
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: obj,
          elPlaceHolder: "content",
          sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,            
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,    
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,
          }
      });
      
      <%-- === 스마트 에디터 구현 끝 === --%>
      
      // 완료버튼
      $("button#btnUpdate").click(function(){
      
         <%-- === 스마트 에디터 구현 시작 === --%>
         //id가 content인 textarea에 에디터에서 대입
         obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
         <%-- === 스마트 에디터 구현 끝 === --%>
         
          // 글제목 유효성 검사
         var subjectVal = $("input#subject").val().trim();
         if(subjectVal == "") {
            alert("글제목을 입력하세요!!");
            return;
         }
         
         // 글내용 유효성 검사(스마트에디터 사용 안 할시)
         <%--
         var contentVal = $("textarea#content").val().trim();
         if(contentVal == "") {
            alert("글내용을 입력하세요!!");
            return;
         }
         --%>
         
         <%-- === 스마트에디터 구현 시작 === --%>
         // 스마트에디터 사용시 무의미하게 생기는 p태그 제거
         var contentval = $("textarea#content").val(); 
         
         // === 확인용 ===
         // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
         // "<p>&nbsp;</p>" 이라고 나온다.
           
           
         // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
         // 글내용 유효성 검사 
         if(contentval == "" || contentval == "<p>&nbsp;</p>") {
              alert("글내용을 입력하세요!!");
              return;
         }  
           
         // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
         contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
         /*    
       	  	대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
            ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
                          그리고 뒤의 gi는 다음을 의미합니다.

              g : 전체 모든 문자열을 변경 global
              i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
         */    
         contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
         contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
         contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
       
         $("textarea#content").val(contentval);  
         
         <%-- === 스마트에디터 구현 끝 === --%>
         
         
         // 폼(form) 을 전송(submit)
         var frm = document.addFrm;
         frm.method = "POST";
         frm.action = "<%= ctxPath%>/lesson/noticeEditEnd.sam";
         frm.submit();   
      });
           
   });// end of $(document).ready(function(){})----------------
</script>

<div class="container">

	<div class="headerCategoty">
	<i class="fas fa-university "></i>
	&nbsp;>&nbsp;공지사항
	</div>
	<br>
	<h3 style="text-align: left; font-weight: bold;">| 공지사항</h3>
	<br>
	
 <form name="addFrm" enctype="multipart/form-data">
       <table id="table" style="width:100%; border-top: 1.5px #b3b3b3 solid; border-bottom: 1.5px #b3b3b3 solid;">
         <tr>
            <th style="width:200px;">제목</th>
            <td>
               <input type="text" name="subject" id="subject" class="long" value="${requestScope.lenotivo.subject}"/>   
              
            </td>
         </tr>
         
         <tr>
            <th>파일첨부</th>
            <td style="text-align:left;">
            	<input type="file" id="fileAddin" name="attach" value="<c:out value="${lenotivo.fileName}"/>"/> 
				<c:if test="${requestScope.lenotivo.fileName != null}">
					<label>삭제&nbsp;&nbsp;</label><input type="checkbox" name="delfileName" value="<c:out value="${requestScope.lenotivo.fileName}"/>">   
					&nbsp;&nbsp;<a href="<%=ctxPath%>/lesson/download.sam?seq=${requestScope.lenotivo.seq}&fk_subno=${lenotivo.fk_subno}"> ${requestScope.lenotivo.orgFilename}</a>
				</c:if>
            </td>
         </tr>
         
         <tr>
            <th>내용</th>
            <td>
               <textarea rows="10" cols="100" style="width: 80%; height: 612px;" name="content" id="content">${requestScope.lenotivo.content}</textarea>       
            </td>
         </tr>                
      </table>
  
		<div id="btn-board">
			<button type="button" class="btn-board" id="btnUpdate">완료</button>
		<button type="button"class="btn-board" onclick="javascript:history.back()">취소</button>
	</div>
    <input type="hidden" name="fk_perno" value="${sessionScope.loginuser.perno}"/>
    <input type="hidden" name="fk_subno" value="${lenotivo.fk_subno}" />
    <input type="hidden" name="seq" value="${lenotivo.seq}" />
     		
   </form>
   
</div>    