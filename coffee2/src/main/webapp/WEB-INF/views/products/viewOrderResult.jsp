<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<div class="container">
		<div class="row mb-3 mt-5">
	        <div class="col-md-4 col-lg-3 mb-4 mb-md-0">
	          <div class="media contact-info">
	            <span class="contact-info__icon"><i class="ti-home"></i></span>
	            <div class="media-body">
	              <h3>*결제완료 정보</h3>
	            </div>
	          </div>
	        </div>
        </div>
		<div class='row table-responsive'>
			<table class="table">
				<c:set var="stop" value="0"/>
				<c:forEach var="dto" items="${list}">
					<c:if test="${stop eq 0}">
                    <tr>
							<td colspan="2"><small>구매시간 : <fmt:formatDate value="${dto.oregdate}" pattern="yyyy-MM-dd HH:mm:ss"/></small></td>
							<td colspan="2">주문상태 : ${dto.ostatus }</td>
						</tr>
	               	  	<tr>
	               	  		<td colspan="2"><small>픽업매장 : ${dto.oaddr}</small></td>
	               	  		<td colspan="2"><small>픽업시간 : ${dto.odate}&nbsp;${dto.otime}</small></td>
	               	  	</tr>
               	  	</c:if>
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
               	  	<c:if test="${stop eq 0}">
               	  		<c:set var="onum" value="${dto.onum }"/>
               	  		<c:set var="stop" value="${stop + 1}"/>
               	  	</c:if>
               	  </c:forEach>
			</table>
		</div>
	</div>
<%@ include file="../include/footer.jsp" %>
<script>
	var onum = '<c:out value="${onum}" />'
	console.log("onum : " + onum);
	$("document").ready(function(){
		console.log("view order result...." + onum);
		setTimeout(function(){
			//socket.send("admin,"+onum);
			socket.send("admin|"+onum);
		},1000);
	});
</script>