<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC 
%>

<style type="text/css">
    
div#adminhome {
	min-height: 700px;
	padding-top: 20px;
	font-family: 'Noto Sans KR', sans-serif;
}

div#adminside {
	border-right:1px solid #b0b0b5;
	float: left;
	width: 20%;
	padding-left: 50px;
	min-height: 600px;
}
    
div#admincontent {
	float: left;
	padding: 0 50px 0 50px;
	width: 80%;
}    

.admsubtitle {
	border-left:solid 5px black; 
 	clear: both;
 	font-size: 18pt;
 	font-weight:bold;	
 	padding-left: 5px;
 
}

div.admintitlesearch {
	float: right;
	margin-bottom: 30px;
}

div.admtitleoptions {
	border-bottom: 3px solid #b0b0b5; 
	border-top: 3px solid #b0b0b5; 
	height: 50px;	
	padding: 10px 10px 0 10px;
	
}

.admsubtsp {
	font-size: 12pt;
	margin: 0 20px 0 550px;
	font-weight:bold;
}

table {
	clear: both;
	width: 100%;
}

th {
	padding-right: 15px;
	height: 27px;
}

td {
	padding-right: 15px;
	margin-bottom: 50px;
}

tr {
	height: 27px;
	border-bottom: 1px solid #b0b0b5;
}

.admthtd {
	width: 30px;
}

.admth {
	margin-right: 70px;
}

.admthtdall {
	width: 100px;
}

.thall {
	font-weight: bold;
	font-size: 11pt;
}

</style>

<script>

	$(function(){
		
		$("input#searchWord").bind("keydown", function(event){
			if(event.keyCode == 13){
				// 엔터를 했을 경우
				goSearch();
			}
		}); // 검색 엔터를 했을 경우
		
		
		var checkbox_student = document.getElementsByName("PERNO");
		
		for(var i=0; i<checkbox_student.length; i++){
			
			checkbox_student[i].addEventListener('click', function(){
				var bool = this.checked;
				
				if(!bool){
					allCheckStudent.checked = false;
				}
				else {
					
					var bFlag = false;
					for(var j=0; j<checkbox_student.length; j++){
						
						if(!checkbox_student[j].checked) {
							// 체크박스가 체크가 되어진 경우이라면 
							bFlag = true;
							break;
						}
					} // end of for
					
					if(!bFlag){
						// 모든 하위체크박스에 체크가 되어진 경우
						allCheckStudent.checked = true; // allCheck 는 전체선택/전체해제에 해당하는 체크박스이다.
					}
					
				}
				
			});
			
		} // end of for // 체크박스 전체선택/해체	
		
		
	}); // end of $(function(){})
	
	function goSearch(){
		
		var frm = document.searchFrm;
		
		frm.method = "get";
		frm.action = "<%=ctxPath%>/admin/blacklist.sam";
		frm.submit();	
		
	} // end of function goSearch(){}
	
	function allCheckStart() {
		
		var bool = $("input#allCheckStudent").is(":checked");
		$("input.CheckStudent").prop("checked",bool);
		
	}// end of function allCheckStart()-------------------

</script>

<div id="adminhome">
	
	<div id="adminside" >
		<span style="font-family: 'Noto Sans KR', sans-serif;">관리자 페이지 홈</span>
		<br>
		<br>
		<span>회원/교수진 관리</span>
		<ul>
			<li>학생 관리</li>
			<li>교수진 관리</li>
			<li>활둥중지 회원</li>
		</ul>
		<br>
		<span>게시글 관리</span>
		<ul>
			<li>게시글 관리</li>
			<li>댓글 관리</li>
			<li>스팸글 관리</li>
		</ul>
		<br>
		<span>열람실 관리</span>		
		<br>
		<span>수업 관리</span>	
		<ul>
			<li>수업 개설</li>
		</ul> 	
	</div>
	
	<div id="admincontent">
	
		<div class="admsubtitle">
			<span >활동중지회원</span>
		</div>
		
		<div class="admintitlesearch">
			<form name="searchFrm">
				<select name="searchType" style="width: 100px;">
					<option value="name">이름</option>
					<option value="content">학과</option>
					<option value="email">이메일</option>
				</select>
				<input type="text" id="searchWord" name="searchWord"/>    
	     		<input type="text" style="display: none;"/>
	     		<button type="button" onclick="goSearch();">검색</button>
     		</form> 
		</div>
		
		<div style="clear: both;">
			<select style="display: inline-block; float: right; margin-right: 20px; height: 25px; margin-bottom: 10px;">
					<option>15개씩</option>
			</select>
		</div>
		
		<div style="clear: both;"></div>
			
		<div class="admtitleoptions" align="right">
			<span class="admsubtsp">선택한 회원</span>
			<select class="adminsearchoption">
					<option>게시판 활동</option>
					<option>열람실 이용</option>
			</select>
			<button style="background-color: #99ccff; border-radius: 10%; color: white;">중지 해제</button>
			<button style="background-color: #cdcbcb; border-radius: 10%; color: white;">강제탈퇴</button>
		</div>
				
		<div style="clear: both;">
			<table>
				<thead>
					<tr style="font-weight: bold;">
						<th class="admthtd"><input type="checkbox" id="allCheckStudent" onClick="allCheckStart();"><label for="allCheckStudent"></label></th>  
						<th class="thall" style="margin-right: 70px; width: 30px;">No</th>
						<th class="admthtdall thall">학과코드</th>
						<th class="admthtdall thall">학과</th>
						<th class="admthtdall thall">학번</th>
						<th class="admthtdall thall">성함</th>
						<th class="admthtdall thall">휴대전화</th>
						<th class="admthtdall thall">이메일</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="personMap" items="${requestScope.personList}" varStatus="status">			
						<form name="studentinfoFrm">
						<tr>		
							<td><input type="checkbox" class="CheckStudent student" name="PERNO" id="CheckStudent${status.index}" value="${personMap.PERNO}"><label for="CheckStudent${status.index}"></label></td>
							<td style="margin-right: 70px; width: 30px;">${status.count}</td>
							<td class="admthtdall goinfo">${personMap.FK_MAJSEQ}</td>
							<td class="admthtdall goinfo">${personMap.CONTENT}</td>
							<td class="admthtdall goinfo" onclick="goView('${personMap.PERNO}')">${personMap.PERNO}</td>
							<td class="admthtdall goinfo">${personMap.NAME}</td>
							<td class="admthtdall goinfo">${personMap.MOBILE}</td>
							<td class="admthtdall goinfo">${personMap.EMAIL}</td>						
						</tr>
						</form>
					</c:forEach>
				</tbody>
			</table>
			<div align="center" style="width: 70%; border: 0px gray solid; margin: 20px auto;">
		   		${requestScope.pageBar}
		   	</div>
		</div>
						
	</div>

</div>