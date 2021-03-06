<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

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
    .subjectStyle {font-weight: bold;
                   cursor: pointer;} 
    #table th, #table td {padding: 5px;}       
	table{
		width:100%;
	
		border-bottom: solid 1.5px #b3b3b3;;
	}
	
	th{
		background-color: #f2f2f2;
	}
	
	tr{
		border-top: solid 0.5px #bfbfbf;
		border-bottom: solid 0.5px #bfbfbf;
		height:40px;
	}
	
	tr.list:hover{
		background-color: #fafafa;
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
	
	.select{
	 	padding:5px;
	 	border-radius: 5px;
	 	height: 30px;
		border:0.5px solid #a6a6a6;	 	
	}
	
	.search{
		width:320px;
		border:0.5px solid #a6a6a6;
	 	padding:5px;
	 	border-radius: 5px;
	 	height: 30px;	 	
	}
	
	.comment{
		display: inline-block;
		border:0.5px solid #a6a6a6;	
		border-radius: 7px;
		width: 20px;
		text-align: center;
		color:red;
		font-weight: bold;
		font-size: 8pt;
	}
	
	
	
</style>

<script type="text/javascript">

   $(document).ready(function(){
	   

 	  	$("select#page").val("${requestScope.page}");


		$(".subject").bind("mouseover",function(event){
			var $target=$(event.target);
			$target.addClass("subjectStyle");
		});
	   
		$(".subject").bind("mouseout",function(event){
			var $target=$(event.target);
			$target.removeClass("subjectStyle");			
		});

		$("input#searchWord").bind("keydown", function(event){
	          if(event.keyCode == 13){
	             goSearch();
	          }
	    });
		
	
		<%-- === #107. ????????? ????????? ????????? ???????????? 2 === --%>
	       $("div#displayList").hide();
	       
	       $("input#searchWord").keyup(function(){
	          
	          var wordLength = $(this).val().trim().length;
	          // ???????????? ????????? ????????????.
	          
	          if(wordLength == 0 ) {
	             $("div#displayList").hide();
	             // ???????????? ??????????????? ????????? ????????? ????????????????????? ????????? ???????????? ?????? ????????? ????????? ????????? ??? ???????????? ?????? ??????. 
	          }
	          else {
	             $.ajax({
	                url:"<%= ctxPath%>/admin/commentWordSearchShow.sam",
	                type:"get",
	                data:{"searchType":$("select#searchType").val()
	                    ,"searchWord":$("input#searchWord").val()
	                    ,"viewBoard":$("select#viewBoard").val()},
	                dataType:"json",
	                success:function(json){ // [] ??????  [{"word":"????????? ????????? java ???????????????"},{"word":"????????? ????????? JaVa ???????????????"}] 
	                   <%-- === ????????? ????????? ????????? ???????????? === --%> 
	                   if(json.length > 0) {
	                      // ????????? ???????????? ?????? ?????????.
	                      
	                      var html = "";
	                      
	                      $.each(json, function(index, item){
	                         var word = item.word;
	                         // word ==> "????????? ????????? java ???????????????"
	                         // word ==> "????????? ????????? JaVa ???????????????"
	                         
	                         var index = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());
	                         // word ==> "????????? ????????? java ???????????????"
	                         // word ==> "????????? ????????? java ???????????????"
	                         // ????????? ???????????? jAva ????????? index ??? 8 ??? ??????.
	                         
	                         var len = $("input#searchWord").val().length;
	                         // ???????????? ?????? len = 4
	                         
	                         word = word.substr(0,index) + "<span style='color:blue;'>"+word.substr(index,len)+"</span>" + word.substr(index+len);
	                         
	                         html += "<span style='cursor:pointer;' class='word' >"+word+"</span><br>";
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
	          
	       });

	       <%-- ??? === ????????? ????????? ????????? ????????????  === --%>
	       
	       <%-- === ????????? ????????? ????????? ????????????  === --%> 
	       $(document).on("click","span.word", function(){
	          $("input#searchWord").val($(this).text()); // ?????????????????? ????????? ????????? ???????????? ???????????????.
	          $("div#displayList").hide();
	          goSearch();
	       });
	        	       
	       //????????? ???????????? ??? ????????? ??? ???????????????
	       if( ${not empty requestScope.paraMap} ){   
	    	   if(${requestScope.paraMap.viewBoard eq ""}){
	    		   $("select#viewBoard").val("????????? ??????");
	    		   $("select#searchType").val("${requestScope.paraMap.searchType}");
	          		$("input#searchWord").val("${requestScope.paraMap.searchWord}");	  
	    	   }
	    	   else{
		    		$("select#viewBoard").val("${requestScope.paraMap.viewBoard}");
					$("select#searchType").val("${requestScope.paraMap.searchType}");
	          		$("input#searchWord").val("${requestScope.paraMap.searchWord}");	   
	    	   }
	       }


	       
	    // ?????? ??????   
	   	$("[name=checkAll]").click(function(){
		    allCheck(this);
		    //?????????????????? ???????????? ?????????
		});
		
	    // ?????? ??????
		$("[name=checkOne]").each(function(){
		    $(this).click(function(){
		        oneCheck($(this));
		    });
		});
	       
	    
	    
		 $("[name=checkOne]").change(function(){
			 var comseqArr = new Array();
		        if($("[name=checkOne]").is(":checked")){
		        	var checkCnt = $("input:checkbox[name=checkOne]:checked").length;
		        	var page=${requestScope.page};
		        	for(var i=0; i<page; i++) {
		        		if( $("input:checkbox[name=checkOne]").eq(i).is(":checked") ) {
							comseqArr.push( $("input:checkbox[name=checkOne]").eq(i).val());
		        		}
					}
		        }
		    });
   });// end of $(document).ready(function(){}---------------------------------------

		   
		   
// == ????????? ???????????? ?????? ?????? == //

   function allCheck(obj) {
       $("[name=checkOne]").prop("checked",$(obj).prop("checked")); 
		
   }// ?????? ????????????

   function oneCheck(a){
   	var allChkBox = $("[name=checkAll]");
   	var chkBoxName = $(a).attr("name");
   	
   	if( $(a).prop("checked") ){
   		    checkBoxLength = $("[name="+ chkBoxName +"]").length;
   		    //?????????????????? ???(?????????????????? ???????????? ??????)
   		    checkedLength = $("[name="+ chkBoxName +"]:checked").length;
   		    //????????? ???????????? ??? 
   		    if( checkBoxLength == checkedLength ) {
   		        allChkBox.prop("checked", true);
   		        //????????????????????? == ????????? ???????????? ??? ????????? ????????????
   		
   		    } else {
   		        allChkBox.prop("checked", false);
   		        
   		    }
   	}
   	else{
   	   allChkBox.prop("checked", false);
   	}
   }

   //== ????????? ???????????? ?????? ??? == //

	function goView(seq,categoryno){
	
		var frm = document.goViewFrm;
		frm.seq.value=seq;
		frm.searchType.value = "${requestScope.paraMap.searchType}";
	    frm.searchWord.value = "${requestScope.paraMap.searchWord}"; 
	    frm.categoryno.value = categoryno; 
		frm.method="get";
		frm.action="<%= ctxPath%>/board/view.sam";
		frm.submit();
		   
	} // end of function goView(seq)-----------------------------
	
	function goSearch(){
		   
		   var frm = document.searchFrm;
		   frm.method = "get";
		   frm.action = "<%=ctxPath%>/admin/commentList.sam";
		   frm.submit();
		   
	}// end of function goSearch()------------------------------------
	
	
	function goPage(){
		var frm = document.selectPage;
		   frm.method = "get";
		   frm.action = "<%=ctxPath%>/admin/commentList.sam";
		   frm.submit();
	}
	<%--
	function goBoard(){
		var frm = document.viewBoard;
		   frm.method = "get";
		   frm.action = "<%=ctxPath%>/admin/boardlist.sam";
		   frm.submit();
		   console.log($("#viewBoard option:selected").val());
	} 
	   --%>
	   
	function goDelete(){
		
		var checkCnt = $("input:checkbox[name=checkOne]:checked").length;
	    
		if(checkCnt < 1) {
	    	alert("???????????? ????????? ???????????????.");
	    	return; 
	    }	
		
		else{
			var bool = confirm("???????????? ????????? ?????? ???????????????????");
			var comseqArr = new Array();
	
        	var page=${requestScope.page};
        	
        	for(var i=0; i<page; i++) {
        		if( $("input:checkbox[name=checkOne]").eq(i).is(":checked") ) {
					comseqArr.push( $("input:checkbox[name=checkOne]").eq(i).val());
        		}
			}
	
			if(bool){
				$.ajax({
					url:"<%= ctxPath%>/admin/commentDelete.sam",
					type: "post",
					data: {"comseqArr" : comseqArr},					  
					dataType: "json",
					traditional : true,
					success:function(json){
							if(json.n==1){
								location.href="javascript:history.go(0);";
							}
					},
					 error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				     }  
				});
				
			}
			else{
				return;
			}
		}
	}	  
	   
	   
</script>   

<div id="adminhome">
	
	<div id="admincontent">
	
		
	

		<div style="padding-left: 3%;padding-right: 3%;">
		  <div class="admsubtitle">?????? ??????</div>
		   <div style="text-align:right; vertical-align:middle; margin:5px;  ">
			   <%-- === #101. ????????? ??? ???????????? : ?????????, ???????????? ????????? ????????? ??????. === --%>
				<form name="searchFrm" style="margin-top: 20px;">
					<select name="viewBoard" id="viewBoard" class="select" onChange="goBoard()">
					      <option >????????? ??????</option>
					      <option value="1">???????????????</option>
					      <option value="2">????????????</option>
					      <option value="3">?????????/?????????</option>
					</select>
			      <select name="searchType" id="searchType"  class="select">	
			         <option value="content">?????? ??????</option>
			         <option value="name">?????????</option>
			      </select>
			      <input type="text" name="searchWord" class="search" id="searchWord" size="15" autocomplete="off" /> 
			      <button type="button" onclick="goSearch()" class=" btn-board">??????</button>
			   </form>
			   <div style="height:70px; " >
				   <%-- === ????????? ????????? ????????? ????????????  === --%>
					<div id="displayList" style="border:solid 1px gray; border-top:0px; width:320px; height:70px; margin-right:118px; 
							overflow:auto; float:right; padding:5px; text-align: left;  border-radius: 5px;  box-shadow: 0.5px 0.5px 0.5px 0.5px gray;">	
					</div>
				</div>
		   </div>
		   
		 
		   <table id="table" style="width:100%; ">
		   	  <tr style="border-top: none; border-bottom: none;">
		   		<td colspan="3" style="text-align: left; font-size: 13pt; font-weight: bolder;">
		   			?????? <span style="color:#53c68c;">${requestScope.totalCount}</span></td>
		   		<td colspan="5" style="text-align: right;">
			      	<form name="selectPage">
				    <select name="page" id="page" style="width:100px; margin-right:5px;" class="select" onChange="goPage()">
				      <option>?????? ???</option>
				      <option value="5">5??????</option>
				      <option value="15">15??????</option>
				      <option value="30">30??????</option>
				    </select>
				    </form>
				</td>
		   	  </tr>
		      <tr style="border-top:solid 1.5px #b3b3b3;">
		         <td style="text-align: center;">
		         	<input type="checkbox"  name="checkAll" />
				 </td>
				 <td></td>
		         <td style="text-align: center;">
		
		         </td>
		         
		         <td colspan="5" style="text-align:right; vertical-align: middle;">
					<span style="font-weight: bold; font-size: 13pt;">????????? ???</span>
					<input type="button" value="??????" class=" btn-board" name="delete" onclick="goDelete()"/>
				</td>
						
		      </tr>
		      <tr>
		      	 <th style="width: 3%;  text-align: center;"></th>
		      	 <th style="width: 5%;  text-align: center;">No.</th>
		         <th style="width: 10%;  text-align: center;">????????? ???</th>
		         <th style="width: 23%;  text-align: left;">????????? ??????</th>
		         <th style="width: 30%;  text-align: left;">?????? ??????</th>
		         <th style="width: 14%; text-align: center;">?????????(??????)</th>
		         <th style="width: 15%;  text-align: center;">????????????</th>
		      
		      </tr>
		      
		      <c:forEach var="commentvo" items="${requestScope.commentList}" varStatus="status"> 
		         <tr class="list">  	
		         	<td style="text-align: center;">
		         		<input type="checkbox" name="checkOne" value="${commentvo.comseq}" />
				 	</td>
		         	<td align="center">${commentvo.comseq}</td>
		             <td align="center">
		             		<c:if test="${commentvo.categoryno==1}">
			             		<a class="subject" style=" text-align:center; width: 280px;" href="/finalproject3/board/list.sam?categoryno=1">???????????????</a>
			             	</c:if>
			             	<c:if test="${commentvo.categoryno==2}">
			             		<a class="subject"  style=" text-align:center; width: 280px;" href="/finalproject3/board/list.sam?categoryno=2">????????????</a>
			             	</c:if>
			             	<c:if test="${commentvo.categoryno==3}">
			             		<a class="subject" style=" text-align:center; width: 280px;" href="/finalproject3/board/list.sam?categoryno=3">????????? / ?????????</a>
			             	</c:if>
		             </td>
		             <td align="left">
		             	<span class="subject" onclick="goView('${commentvo.fk_seq}','${commentvo.categoryno}')">${commentvo.subject}</span>
		             </td>
		             <td>${commentvo.content}</td>       
		            <td align="center">${commentvo.name}(${commentvo.fk_perno})</td>
		            <td align="center">${commentvo.reregDate}</td>
		             
		         </tr>
		      </c:forEach>
		   </table>   
		
		       <%-- === #122. ???????????? ???????????? --%>
			<div align="center" style="width: 70%; border:solid 0px gray; margin:20px auto;">
				${requestScope.pageBar}
			</div>
		   
		</div>
	</div>
</div>

<form name="goViewFrm">
	<input type="hidden" name="seq" />
	<input type="hidden" name="gobackURL" value="${requestScope.gobackURL}" />
	<input type="hidden" name="categoryno"/>
	<input type="hidden" name="searchType" />
    <input type="hidden" name="searchWord" />
</form>


    