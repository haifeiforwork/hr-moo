<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
</div><!-- container 끝-->		
<!-- 푸터 시작 -->
		<footer>
			<div class="footer_wrap">
				<!-- 하단 로고 영역 -->
				<a href="" class="logo" title="Moorim 채용 관리자 메인 바로가기"><img src="/resources/images/footer_logo.png" alt="Moorim 로고"></a>
				<!-- 하단 정보 영역 -->
				<div class="info">
					<!--<div class="location">
						<span>서울 강남구 강남대로 656(신사동)</span><span>tel 02.3485.1500</span><span>fax 02.3443.2997</span>
					</div>-->
					<span class="copy">Copyright(c) 2018 Moorim Paper. All right reserved.</span>
					<!--<span class="wa">본 웹사이트는 장애인을 비롯한 모든 분들이 이용에 불편이 없도록 웹 접근성 표준 지침을 준수했습니다.</span>-->
				</div>
				<!-- 하단 링크 영역 -->
				<!--<div class="link">
					<ul>
						<li><a href="">개인정보처리 방침</a></li>
						<li><a href="">이메일 무단수집 거부</a></li>
						<li><a href="">SITE MAP</a></li>
					</ul>
				</div>-->
			</div>
		</footer>
		<!-- 푸터 끝 -->

<script language="javascript">
  	$( ".gnb ul" ).mouseover(function() {
		$('.depth2').css("display", "block");
		$('#gnb_sub').css("display", "block");
	});
  	
  	$( ".gnb ul" ).mouseout(function() {
		$('.depth2').css("display", "none");
		$('#gnb_sub').css("display", "none");
  	});
  	
  	$( "#gnb_sub" ).mouseout(function() {
		$('.depth2').css("display", "none");
		$('#gnb_sub').css("display", "none");
	});
  	/*
  	$('#lnb_closebtn').on('click', function(e) {
  		if($('#lnb_wrap').attr("class").indexOf("close") > 1) {
  			$('#lnb_wrap').attr("class", "lnb_close");
  			$('#lnb_closebtn').attr("class", "lnb_openbtn");
  			//$(".contents_wrap").attr("class", "contents_wrap lnb_close");
  			$(".contents_wrap").toggleClass( "lnb_close" )
  		} else {
  			$('#lnb_wrap').attr("class", "lnb_open");
  			$('#lnb_closebtn').attr("class", "lnb_closebtn");
  			//$(".contents_wrap lnb_open").attr("class", "contents_wrap lnb_open");
  			$(".contents_wrap").toggleClass( "lnb_close" )
  		}
  	});*/	
</script>	
