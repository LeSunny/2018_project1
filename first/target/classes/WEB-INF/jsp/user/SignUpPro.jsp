<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
	<%@ include file="/WEB-INF/include/include-header-first.jspf" %>

</head>
<body>
<center>
	<table>
			
			<colgroup>
       		<col width="10%"/>
        	<col width="*"/>
        	<col width="15%"/>
        	<col width="20%"/>
    	</colgroup>
    		<tbody>
                  <tr>
	                    <td>
	                    <center>
	                        	${userID}��, ȸ�������� �Ϸ�Ǿ����ϴ�.
	                            <br />
		                        <a href="#this" id="initial">Ȩ����</a>
		                        </center>
	                    	</td>
                        </tr>

		</tbody>
	</table>
	<br/>
	
	</center>
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#initial").on("click", function(e){ //������� ��ư
				e.preventDefault();
				fn_goFirst();
			});
		});
		
		function fn_goFirst(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/index.do' />");
			comSubmit.submit();
		}
	</script>
</body>
</html>