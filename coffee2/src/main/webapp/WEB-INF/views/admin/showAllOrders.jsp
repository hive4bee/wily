<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerA.jsp" %>
	
	<style>
		input{
			border:none;
		}
	</style>
	<div class="container">
		<div class="row mb-3 mt-5">
	        <div class="col-md-4 col-lg-3 mb-4 mb-md-0">
	          <div class="media contact-info">
	            <span class="contact-info__icon"><i class="ti-home"></i></span>
	            <div class="media-body">
	              <h3>*주문조회</h3>
	            </div>
	          </div>
	        </div>
        </div>
		<div class='row table-responsive'>
			<table class="table">
				<c:if test="${empty list }">
					<tr>
						<td colspan="4">
							구매한 목록이 없습니다.
						</td>
					</tr>
				</c:if>
				<c:if test="${!empty list}">
	               <c:set var="check" value="0"/>  	  
				<c:forEach var="dto" items="${list}">
				
				<c:choose>
					<c:when test="${dto.onum ne check}">
						<tr>
							<td colspan="4"><hr style="border:1px solid #808080"></td>
						</tr>
	               	  	<tr>
	               	  		<td colspan="2"><small>픽업매장 : ${dto.oaddr }</small></td>
	               	  		<td colspan="2"><small>${dto.onum}</small></td>
	               	  	</tr>
						<tr>
							<td><small>픽업시간 : ${dto.odate} ${dto.otime }</small></td>
							<%-- <td colspan="2"><strong><fmt:formatDate value="${dto.oregdate}" pattern="yyyy-MM-dd"/></strong></td> --%>
							<td>ID : ${dto.mid}</td>
							<td>
								<input type="hidden" class="mid" value="${dto.mid}"/>
								<input type="hidden" class="onum" value="${dto.onum }"/>
								<select class="selectC">
									<c:if test="${dto.ostatus eq '주문접수'}">
										<option value="주문접수" selected>주문접수</option>
										<option value="주문처리완료">주문처리완료</option>
									</c:if>
									<c:if test="${dto.ostatus eq '주문처리완료'}">
										<option value="주문접수">주문접수</option>
										<option value="주문처리완료" selected>주문처리완료</option>
									</c:if>
								</select>
							</td>
						</tr>
	               	  	<tr>
	               	  		<td>
	               	  			<div class="media">
	               	  				<div class="d-flex">
	               	  					<img src="/imgs/${dto.uploadpath}/s_${dto.uuid}_${dto.filename}" width="100" height="100">
	               	  				</div>
	               	  				<div class="media-body">
	               	  					<p>${dto.pname}</p>
	               	  				</div>
	               	  			</div>
	               	  		</td>
	               	  		<td>
	               	  			<p><fmt:formatNumber value="${dto.pprice}" type="currency"/></p>
	               	  		</td>
	               	  		<td>
	               	  			<div class="product_count">
	               	  				<input type="text" name="cqty" value="${dto.oqty}" title="Quantity:"
	               	  					class="input-text qty" readonly>
	               	  				
	               	  			</div>
	               	  		</td>
	               	  		<td>
	               	  			<p><span class="priceArea">
	               	  				<fmt:formatNumber value="${dto.oqty * dto.pprice}" type="currency"/>원
	               	  			</span></p>
	               	  		</td>
	               	  		
	               	  	</tr>
               	  		<c:set var="check" value="${dto.onum}"/>
               	  	</c:when>
               	  	<c:when test="${dto.onum eq check }">
	               	  	<tr>
	               	  		<td>
	               	  			<div class="media">
	               	  				<div class="d-flex">
	               	  					<img src="/imgs/${dto.uploadpath}/s_${dto.uuid}_${dto.filename}" width="100" height="100">
	               	  				</div>
	               	  				<div class="media-body">
	               	  					<p>${dto.pname}</p>
	               	  				</div>
	               	  			</div>
	               	  		</td>
	               	  		<td>
	               	  			<p><fmt:formatNumber value="${dto.pprice}" type="currency"/></p>
	               	  		</td>
	               	  		<td>
	               	  			<div class="product_count">
	               	  				<input type="text" name="cqty" value="${dto.oqty}" title="Quantity:"
	               	  					class="input-text qty" readonly>
	               	  				
	               	  			</div>
	               	  		</td>
	               	  		<td>
	               	  			<p><span class="priceArea">
	               	  				<fmt:formatNumber value="${dto.oqty * dto.pprice}" type="currency"/>원
	               	  			</span></p>
	               	  		</td>
	               	  	</tr>
               	  		<c:set var="check" value="${dto.onum}"/>
               	  	</c:when>
               	  </c:choose>
               	  </c:forEach>
               	  </c:if>
			</table>
		</div>
	</div>
<%@ include file="../include/footerA.jsp" %>
<script>
	function informComplete(mid, onum){
		console.log("inform completed...");
		socket.send("200|"+mid+"|"+onum);
	}
	$(document).ready(function(){
		$(".selectC").on("change", function(){
			console.log("changed....");
			var ostatus = $(this).val();
			console.log("value : " + ostatus);
			var onum = $(this).closest("td").find("input[class='onum']").val();
			var mid = $(this).closest("td").find("input[class='mid']").val();
			console.log("mid : " + mid);
			console.log("onum : " + onum);
			$.ajax({
				type:"get",
				url:"/admin/changeStatus",
				data:{onum:onum, ostatus:ostatus, mid:mid},
				success:function(check){
					if(check=='success'){
						console.log("success");
						checkOrderQuantity();
						getOrderList();
						informComplete(mid, onum);
					}else{
						console.log("fail");
					}
				}
			});
		});
	});
</script>