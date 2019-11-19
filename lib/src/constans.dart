const String daumHtml = """
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>주소검색</title>
</head>
<style>
html,body{ margin:0; padding:0; height:100%; width:100%; }
#full-size{
  height: 100%;
  width: 100%;
  zoom: 5;
  overflow:hidden; /* or overflow:auto; if you want scrollbars */
}
</style>
<body>
<div id="full-size"></div>
</body>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript">
    var x = 'hello';
    try { testComplete.postMessage(x); } catch (err) {}

    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('full-size');

    daum.postcode.load(function() {

      function callbackMessage(message) {
        try { onComplete.postMessage(message); } catch(err) {}
      }

      new daum.Postcode({
          oncomplete: function(data) {
              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              callbackMessage(JSON.stringify(data));
          },
          width : '100%',
          height : '100%',
          maxSuggestItems : 5,
          alwaysShowEngAddr: false,
          hideMapBtn: true,
          hideEngBtn: true,
      }).embed(element_layer);

      // iframe을 넣은 element를 보이게 한다.
      element_layer.style.display = 'block';
    });

</script>
</html>
""";

const String jusoHtml = """
/*
파일명 : jusoPopup.jsp
내  용 : 팝업API 호출 소스(jusoPopup.jsp ↔ 도로명주소 팝업API )
*/
/*
모의 해킹 테스트 시 팝업API를 호출하시면 IP가 차단 될 수 있습니다.
주소팝업API를 제외하시고 테스트 하시기 바랍니다.
*/
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <%
    //request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
    //request.setCharacterEncoding("EUC-KR");  //해당시스템의 인코딩타입이 EUC-KR일경우에
    String inputYn = request.getParameter("inputYn");
    String roadFullAddr = request.getParameter("roadFullAddr");
    String roadAddrPart1 = request.getParameter("roadAddrPart1");
    String roadAddrPart2 = request.getParameter("roadAddrPart2");
    String engAddr = request.getParameter("engAddr");
    String jibunAddr = request.getParameter("jibunAddr");
    String zipNo = request.getParameter("zipNo");
    String addrDetail = request.getParameter("addrDetail");
    String admCd    = request.getParameter("admCd");
    String rnMgtSn = request.getParameter("rnMgtSn");
    String bdMgtSn  = request.getParameter("bdMgtSn");
    /** API 서비스 제공항목 확대 (2017.02) **/
    String detBdNmList  = request.getParameter("detBdNmList");
    String bdNm  = request.getParameter("bdNm");
    String bdKdcd  = request.getParameter("bdKdcd");
    String siNm  = request.getParameter("siNm");
    String sggNm  = request.getParameter("sggNm");
    String emdNm  = request.getParameter("emdNm");
    String liNm  = request.getParameter("liNm");
    String rn  = request.getParameter("rn");
    String udrtYn  = request.getParameter("udrtYn");
    String buldMnnm  = request.getParameter("buldMnnm");
    String buldSlno  = request.getParameter("buldSlno");
    String mtYn  = request.getParameter("mtYn");
    String lnbrMnnm  = request.getParameter("lnbrMnnm");
    String lnbrSlno  = request.getParameter("lnbrSlno");
    String emdNo  = request.getParameter("emdNo");
    %>
</head>
<script language="javascript">
// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("주소입력화면 소스"도 동일하게 적용시켜야 합니다.)
document.domain = "salondecode.io";

function init(){
    var x = 'hello';
    try { testComplete.postMessage(x); } catch (err) {}

    function callbackMessage(message) {
        try { onComplete.postMessage(message); } catch(err) {}
    }

	var url = location.href;
	var confmKey = "devU01TX0FVVEgyMDE5MTEwODE2MDI1MjEwOTE3ODM=";//승인키
	// resultType항목 추가(2016.10.06)
	var resultType = "4"; // 도로명주소 검색결과 화면 출력유형, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
	var inputYn= "<%=inputYn%>";
	if(inputYn != "Y"){
	    try { testComplete.postMessage("YES"); } catch (err) {}
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.resultType.value = resultType; // resultType항목 추가(2016.10.06)
		document.form.action="https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do"; // 모바일 웹인 경우, 인터넷망
		document.form.submit();
	}else{
        try { testComplete.postMessage("NO"); } catch (err) {}
		/** API 서비스 제공항목 확대 (2017.02) **/
        callbackMessage("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>", "<%=roadAddrPart2%>","<%=engAddr%>"
			, "<%=jibunAddr%>","<%=zipNo%>", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>", "<%=detBdNmList%>"
			, "<%=bdNm%>", "<%=bdKdcd%>", "<%=siNm%>", "<%=sggNm%>", "<%=emdNm%>", "<%=liNm%>", "<%=rn%>", "<%=udrtYn%>"
			, "<%=buldMnnm%>", "<%=buldSlno%>", "<%=mtYn%>", "<%=lnbrMnnm%>", "<%=lnbrSlno%>", "<%=emdNo%>")
		window.close();
	}
}
</script>
<body onload="init();">
<form id="form" name="form" method="post">
    <input type="hidden" id="confmKey" name="confmKey" value=""/>
    <input type="hidden" id="returnUrl" name="returnUrl" value=""/>
    <input type="hidden" id="resultType" name="resultType" value=""/> // resultType항목 추가(2016.10.06)
</form>
</body>
</html>
""";
