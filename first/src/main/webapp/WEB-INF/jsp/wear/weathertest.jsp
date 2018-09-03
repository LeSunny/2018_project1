<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>���� �� ����?</title>
	<%@ include file="/WEB-INF/include/include-header-first.jspf" %>
	
	<style>
	#prev_btn {position:absolute;top:1250px;left:0px}
	#next_btn {position:absolute;top:1250px;right:0px}
	.btn {width:6em;height:80px;border:0;background:#4c4c4c;display:none;}
	
	#slider {position:relative;margin:0 auto;padding:0;list-style:none;width:560px;height:560px;overflow-x:hidden}
	#slider li {display:none;position:absolute;left:0;top:0}
	#slider img {width:560px;height:560px}
	
	#clothes img{width:200px; height:200px;}
	
	</style>
	
</head>
<body>
	<!-- Header -->
	<header id="header">
		<div class="inner">
			<a href="#this" id="home"><h2>What Do I Wear Today?</h2></a>
			<a href="#this" class="butn" id="logout"> �α׾ƿ�  </a>
			<a href="#this" class="butn" id="closet">  �� ����  </a>
		</div>
		���̵� : ${sessionScope.user.ID } ���� : ${sessionScope.user.SEX } ���� : ${sessionScope.user.MEM_LEVEL } <br />	
	</header>

	<div id="weather"></div>
	
	<button type="button" id="prev_btn" class="btn">����</button>
	<button type="button" id="next_btn" class="btn">����</button>
	<br>
	<h2>��¿� �´� ������</h2>
	<div id="clothes"></div>
	<br>
	<br>
	
	<h2>��õ �ڵ� ����</h2>	
	<ul id="slider">
		<div id="recommend"></div>
	</ul>	
		
		
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	 
<script>
	
	$(document).ready(function(){
		
		 $("#closet").on("click", function(e){
	            e.preventDefault();
	            fn_showMyCloset();
	        });
		 $("#logout").on("click", function(e){
	            e.preventDefault();
	            fn_logout();
	        });
		 
			$("#home").on("click", function(e){
		        e.preventDefault();
		        goHome();
		   });
			
		});
		   
	
	$(function() {
	    var time = 500;
	    var idx = idx2 = 0;
	    var slide_width = $("#slider").width();
	    var slide_count = $("#slider li").size();
	    $("#slider li:first").css("display", "block");
	    if(slide_count > 1)
	        $(".btn").css("display", "inline");
	 
	    $("#prev_btn").click(function() {
	        if(slide_count > 1) {
	            idx2 = (idx - 1) % slide_count;
	            if(idx2 < 0)
	                idx2 = slide_count - 1;
	            $("#slider li:hidden").css("left", "-"+slide_width+"px");
	            $("#slider li:eq("+idx+")").animate({ left: "+="+slide_width+"px" }, time, function() {
	                $(this).css("display", "none").css("left", "-"+slide_width+"px");
	            });
	            $("#slider li:eq("+idx2+")").css("display", "block").animate({ left: "+="+slide_width+"px" }, time);
	            idx = idx2;
	        }
	    });
	 
	    $("#next_btn").click(function() {
	        if(slide_count > 1) {
	            idx2 = (idx + 1) % slide_count;
	            $("#slider li:hidden").css("left", slide_width+"px");
	            $("#slider li:eq("+idx+")").animate({ left: "-="+slide_width+"px" }, time, function() {
	                $(this).css("display", "none").css("left", slide_width+"px");
	            });
	            $("#slider li:eq("+idx2+")").css("display", "block").animate({ left: "-="+slide_width+"px" }, time);
	            idx = idx2;
	        }
	    });
	});
	
	
	function goHome(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/wear/weathertest.do' />");
	   comSubmit.submit();
	}    
	
	function fn_showMyCloset(){
        var comSubmit = new ComSubmit();
        comSubmit.setUrl("<c:url value='/wear/mycloset.do' />");
        comSubmit.submit();
    }
	function fn_logout(){
        var comSubmit = new ComSubmit();
        comSubmit.setUrl("<c:url value='/logout.do' />");
        comSubmit.submit();
    }
 
	
	/* 5 days/3hours */    
	var wear = ${daywear};
	var cityname=wear.city.name;
	//��¥ �ڸ���
	var today = new Date();
	var todayArr = (today.toString()).split(' ');
	var now = todayArr[4];
	var hour = now.substring(0,2);
	
	var small = hour - 6;
	var big = hour + 15;
	if(small<=0) small = 0;
	if(big>=24) big = 24;

	var small_cnt = 0;
	for(var i=0; i<8; i++){
		if(small==wear.list[i].dt_txt.substring(11,13)){
			small_cnt=i;
			break;
		}
	}
	var big_cnt=0;
	for(var i=small_cnt; i<8; i++){
		if(big==wear.list[i].dt_txt.substring(11,13) || (big==24)&&0==wear.list[i].dt_txt.substring(11,13)){
			big_cnt=i;
			break;
		}else if(small_cnt==0){
			big_cnt=7;
		}
	}
	
//	document.write(now+" "+hour+" "+big+" "+small+" "+big_cnt+" "+small_cnt+" ");

	var dt=wear.list[small_cnt].dt_txt;
	var dt_last=wear.list[big_cnt].dt_txt;

	//�ְ�, �������, ��󿹺�
	var temp_min = wear.list[small_cnt].main.temp_min;
	var temp_max = wear.list[small_cnt].main.temp_max;
	var weather = "���� �Ǵ� ���� �ҽ��� �����ϴ�.";

	
	
	for(var i=small_cnt ; i<big_cnt ; i++){
		if(temp_min>wear.list[i].main.temp_min){
			temp_min=wear.list[i].main.temp_min;			
		} 
		if(temp_max<wear.list[i].main.temp_max) {
			temp_max=wear.list[i].main.temp_max;
		}
	}
	

	for(var i=small_cnt ; i<big_cnt ; i++){
		if(wear.list[i].weather[0].main=="Rain" ){
			weather = wear.list[i].dt_txt + "���� ���� �ҽ��� �ֽ��ϴ�. ����� ì���ּ���."
			break;
		}
		if(wear.list[i].weather[0].main=="Snow") {
			weather = wear.list[i].dt_txt + "���� ���� �ҽ��� �ֽ��ϴ�. ����� ì���ּ���."
			break;
		}
	}
	
	
	/*current weather*/
	var wear2 = ${currentwear};
	var currenttemp = wear2.main.temp;
	
	
	var max_wear, min_wear;
	
	var clothesstr = "";
	var tempdir = "";
	
	var many=0;
	
	
	if("${sessionScope.user.SEX }"=="F"){
		if(temp_max>=27) {
			max_wear = "<font size=2><b>���� : ����Ƽ, ����<br><b>����</b> : �ݹ���, ª�� ġ��</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/031-sleeveless.png' /><img src='./../resources/images/tshirt.png' /><br><img src='./../resources/images/005-shorts-1.png' /><img src='./../resources/images/004-short-skirt.png' />";		
			tempdir += "27";
			many = 10;
		}else if(23<= temp_max && temp_max <27){
			max_wear = "<font size=2><b>����</b> : ����, ���� ����, ���� ���� <br> <b>����</b> : �ݹ���, �����, �߸� ��Ű��</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/tshirt.png' /><img src='./../resources/images/029-shirt-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><br><img src='./../resources/images/005-shorts-1.png' /><img src='./../resources/images/004-short-skirt.png' /><img src='./../resources/images/009-slim-fit-pants.png' />";				
			tempdir += "23";
			many=12;
		}else if(20<= temp_max && temp_max <23){
			max_wear = "<font size=2><b>����</b> : ����Ƽ, ����Ƽ + �ĵ�Ƽ, ����Ƽ + ����� <br><b>����</b> : �����, ������, ��Ű��</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/028-long-sleeves-t-shirt.png' /><img src='./../resources/images/027-hoodie.png' /><img src='./../resources/images/020-cardigan-2.png' /><br><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/009-slim-fit-pants.png' />";		
			tempdir += "20";
			many=13;
		}else if(17<= temp_max && temp_max <20){
			max_wear = "<font size=2><b>����</b> : ��Ʈ, ���� �����, �ĵ�Ƽ, ������ <br> <b>����</b> : �����, ������, û����, ��Ű�� </font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/027-hoodie.png' /><img src='./../resources/images/020-cardigan-2.png' /><br><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/009-slim-fit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "17";
			many=3;
		}else if(12<= temp_max && temp_max <17){
			max_wear = "<font size=2><b>�ƿ���</b> : ��������, ���� , ������ �߻�, �β��� ����� <br><b>����</b> :  ����, ����, ������ / <b>����</b> : �ݹ���, ġ��,  �����, ������, û����, ��Ű�� <br> ��� ��Ÿŷ</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/011-leather-biker-jacket.png' /><img src='./../resources/images/016-denim-jacket.png' /><img src='./../resources/images/019-jacket.png' /><img src='./../resources/images/022-cardigan.png' /><br><img src='./../resources/images/029-shirt-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "12";
		}else if(10<= temp_max && temp_max <12){
			max_wear = "<font size=2><b>�ƿ���</b> : Ʈ��ġ ��Ʈ, ������ �߻�, ����+�����, ����+��Ʈ <br> <b>����</b> : ��Ʈ, ����, ������ <br> ������ ���Ա�(��Ʈ�� �̿�)<br>�����Ÿŷ</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/012-trench-coat.png' /><img src='./../resources/images/011-leather-biker-jacket.png' /><img src='./../resources/images/019-jacket.png' /><img src='./../resources/images/022-cardigan.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><img src='./../resources/images/029-shirt-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "10";
			
		}else if(6<= temp_max && temp_max <10){
			max_wear = "<font size=2><b>�ƿ���</b> : ��Ʈ, ������ <br> <b>���� : ��Ʈ, ��������  <br> ����</b> : ���뽺, û����, �����, ��Ű��, ������<br>�β��� ��Ÿŷ</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/coat.png' /><img src='./../resources/images/017-coat.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "6";

		}else{
			max_wear = "<font size=2><b>�ƿ���</b> : �е�, �β��� ��Ʈ, ������ <br>�����ǰ, ��Ʈ��, �񵵸�, �尩<br>�β��� ��Ÿŷ, ���뽺</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/013-jacket-2.png' /><img src='./../resources/images/coat.png' /><img src='./../resources/images/017-coat.png' /><br><img src='./../resources/images/001-winter-clothes.png' /><img src='./../resources/images/002-glove.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "cold";
		}		
	}else{
		if(temp_max>=27) {
			max_wear = "<font size=2><b>���� : ����Ƽ, ����<br><b>����</b> : �ݹ���</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/031-sleeveless.png' /><img src='./../resources/images/tshirt.png' /><br><img src='./../resources/images/005-shorts-1.png' />";		
			tempdir += "27";
			many=12;
		}else if(23<= temp_max && temp_max <27){
			max_wear = "<font size=2><b>����</b> : ����, ���� ����, ���� ���� <br> <b>����</b> : �ݹ���, �����, �߸� ��Ű��</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/tshirt.png' /><img src='./../resources/images/029-shirt-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><br><img src='./../resources/images/005-shorts-1.png' /><img src='./../resources/images/009-slim-fit-pants.png' />";				
			tempdir += "23";
			many=12;
		}else if(20<= temp_max && temp_max <23){
			max_wear = "<font size=2><b>����</b> : ����Ƽ, ����Ƽ + �ĵ�Ƽ, ����Ƽ + ����� <br><b>����</b> : �����, ������, ��Ű��</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/028-long-sleeves-t-shirt.png' /><img src='./../resources/images/027-hoodie.png' /><img src='./../resources/images/020-cardigan-2.png' /><br><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/009-slim-fit-pants.png' />";		
			tempdir += "20";
			many=8;
		}else if(17<= temp_max && temp_max <20){
			max_wear = "<font size=2><b>����</b> : ��Ʈ, ���� �����, �ĵ�Ƽ, ������ <br> <b>����</b> : �����, ������, û����, ��Ű�� </font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/027-hoodie.png' /><img src='./../resources/images/020-cardigan-2.png' /><br><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/009-slim-fit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "17";
			many=10;
		}else if(12<= temp_max && temp_max <17){
			max_wear = "<font size=2><b>�ƿ���</b> : ��������, ���� , ������ �߻�, �β��� ����� <br><b>����</b> :  ����, ����, ������ / <b>����</b> : �ݹ���, �����, ������, û����, ��Ű�� </font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/011-leather-biker-jacket.png' /><img src='./../resources/images/016-denim-jacket.png' /><img src='./../resources/images/019-jacket.png' /><img src='./../resources/images/022-cardigan.png' /><br><img src='./../resources/images/029-shirt-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "12";
			many=2;
		}else if(10<= temp_max && temp_max <12){
			max_wear = "<font size=2><b>�ƿ���</b> : Ʈ��ġ ��Ʈ, ������ �߻�, ����+�����, ����+��Ʈ <br> <b>����</b> : ��Ʈ, ����, ������ <br> ������ ���Ա�(��Ʈ�� �̿�)</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/012-trench-coat.png' /><img src='./../resources/images/011-leather-biker-jacket.png' /><img src='./../resources/images/019-jacket.png' /><img src='./../resources/images/022-cardigan.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><img src='./../resources/images/029-shirt-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "10";			
		}else if(6<= temp_max && temp_max <10){
			max_wear = "<font size=2><b>�ƿ���</b> : ��Ʈ, ������ <br> <b>���� : ��Ʈ, ��������  <br> ����</b>û����, �����, ��Ű��, ������</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/coat.png' /><img src='./../resources/images/017-coat.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "6";
		}else{
			max_wear = "<font size=2><b>�ƿ���</b> : �е�, �β��� ��Ʈ, ������ <br>�����ǰ, ��Ʈ��, �񵵸�, �尩</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/013-jacket-2.png' /><img src='./../resources/images/coat.png' /><img src='./../resources/images/017-coat.png' /><br><img src='./../resources/images/001-winter-clothes.png' /><img src='./../resources/images/002-glove.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "cold";
		}	
	}
	
	var htmlstr="";
	if("${sessionScope.user.SEX }"=="F"){
		for(var i=1; i<many+1; i++ ){
			htmlstr +=	"<li><img src='./../resources/images/recommend/"+tempdir+"/20f/"+i+".jpg' /></li>";
		}	
	}else{
		for(var i=1; i<many+1; i++ ){
			htmlstr +=	"<li><img src='./../resources/images/recommend/"+tempdir+"/20m/"+i+".jpg' /></li>";
		}
	}
	
	var str = "<br><br><font size=3> ������ ��� </font> "+temp_max+"��/ "+"19.03"+"��";
	//str += "<br><font size=3> ���� ��� </font>" + currenttemp;

	str += "<br><font size=2>" + weather;
	$("#weather").html(str);
	$("#clothes").html(clothesstr);
	$("#recommend").html(htmlstr);
	</script>
	
</body>
</html>