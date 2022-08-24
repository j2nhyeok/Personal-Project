<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <title>회원가입</title>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

	<style>
	    body { background-color: lightblue; }
	    #year { width:50px; height:15px; font-size:12px;}
	    #date { width:50px; height:15px; font-size:12px;}
	    #pw{width:280px; height:15px; font-size:12px;}
	    #repw{width:280px; height:15px; font-size:12px;}
	    h1 {text-align: center; font-size: 20px; font-weight: bold; color:black;}
	    #wrapper{text-align: center;}
	</style>
</head>

<body >
 	
  <section>
    <h1>회원가입 페이지</h1>
  </section>
  
  <div id="wrapper">
  <section>
    <form name="login" action="join.do" method="post"  id="signform">
      아이디 <br>
      <input type="text" name="id" id="id" placeholder="영소문자로 시작하는 영소문자 또는 숫자 6~20자 " onkeydown="inputIdChk()" >
      <input type="button" id="duplcheck" value="중복 확인">
      <input type="hidden" id="idDuplication" name="idDuplication" value="idUncheck">
       <div class="id regex"></div>
      <br>
      비밀번호<br>
      <input type="password" name="pw" id="pw" placeholder="8 ~ 15자 영문, 숫자, 특수문자를 최소 한가지씩 조합"><br>
      비밀번호 재확인<br>
     <input type="password" id="repw"><br>
      <div class="repw regex"></div>
   
      <br><br>
      이름<br>  <input type="text" name="name" id="name"> <br>
      <div class="name regex"></div>
      생년월일<br> 
      <input type="text" id="year" name="year" maxlength="4" placeholder="년(4자)"  >
      <select id = "month" name="month" style="width:50px; height:22px; font-size:12px;">
        <option value="" hidden>월</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
      </select>
       <input type="text" id="date" name="date"  maxlength="2" placeholder="일(01-31)"  >
      <br><br>
      성별<br>
      <label for="man">남성</label>
      <input type="radio" class="gender" name="gender" value="남성" id="man" checked="checked">
      <label for="woman">여성</label>
      <input type="radio" class="gender" name="gender" value="여성" id="woman"> <br><br>
      이메일<br><input type="text" name="email" id="email" placeholder="email@gmail.com"><br>
      <div class="email regex"></div><br>
      
       전화번호 <br> <input type="text" name="phone" id="phone" placeholder=" '-' 없이 입력"><br>
        <div class="phone regex"></div>
        
        <!-- 나중에 구현할 예정 -->    
<!--       휴대전화<br>
      <input type="text" name="user_phone" placeholder="010-****-****">
      <input type="button" name="certification" value="인증번호 받기"><br>
      <input type="text" name="certification" placeholder="인증번호를 입력하세요">
      <input type="button" name="certification" value="확인"><br><br> -->
     
     <br>
     프로필  사진 <br>
      <input type="file" name="" value="">
      <br><br><br>
    
       <div id="signup">
            <input type="button" name="signup" value="회원가입" id="signupbtn">
		</div>
    </form>
   
    <script>
        	// 아이디 입력창에 다시 다른 아이디를 입력시 hidden에 idUncheck를 세팅하여 중복확인을 하게 만든다.
           //이렇게 하는 이유는 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때 다시 중복 체크를 하도록 하기  위해서이다.
           function inputIdChk(){
        		document.login.idDuplication.value = "idUncheck";
        	}
        	

           
    $(function(){
        // 중복확인 & id 유효성검사             
        $("#duplcheck").on("click",function(){
            var id = $("#id").val();
            if(id == ""){
            	alert("아이디를 입력해주세요");
            	return;
            }
            var regex = /^[a-z]+[a-z0-9]{5,19}$/g;
        	var result = regex.exec(id);
        	var popupX = (window.screen.width/2) - (200 / 2);
        	var popupY= (window.screen.height/2) - (300 / 2);			
        	
        	 if(result != null){
                 $(".id.regex").html("");
                 
            	 window.open("member/idCheckForm.jsp?id="+id, "", 'status=no, height=70px, width=400px, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
             }else{
                 $(".id.regex").html("영소문자로 시작하는 영소문자 또는 숫자 6~20자");
                 $(".id.regex").css("color","red")
             }
        })

 
 
 
 			//비밀번호 유효성검사
        $("#pw").on("input",function(){
            var regex =  /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
            var result = regex.exec($("#pw").val())
            
            if(result != null){
                $(".pw.regex").html("");
            }else{
                $(".pw.regex").html("8 ~ 15자 영문, 숫자, 특수문자를 최소 한가지씩 조합");
                $(".pw.regex").css("color","red")
            }
        });
        
       //비밀번호 확인    
           $("#repw").on("keyup",function(){
                if($("#pw").val()==$("#repw").val()){
                   $(".repw.regex").html("비밀번호가 일치합니다"); 
                }else{
                 $(".repw.regex").html("비밀번호가 일치하지않습니다"); 
                }
           })
           
         
           
        
        //이름 유효성검사
            $("#name").on("input",function(){
                var regex = /[가-힣]{2,}/;
                var result = regex.exec($("#name").val());
                
                if(result != null){
                   $(".name.regex").html("");  
                }else{
                    $(".name.regex").html("한글만 입력 가능합니다.");
                }
                
            })
        

          
        //전화번호 유효성검사
             $("#phone").on("input",function(){
                 var regex = /^01\d\d{3,4}\d{4}$/;
                 var result = regex.exec($("#phone").val());
                
                if(result != null){
                   $(".phone.regex").html("");  
                }else{
                    $(".phone.regex").html("올바른 번호가 아닙니다");
                }
                
            }) 
        
        //email유효성 검사
            $("#email").on("input",function(){
                 var regex = /.+@[a-z]+(\.[a-z]+){1,2}$/;
                 var result = regex.exec($("#email").val());
                
                if(result != null){
                   $(".email.regex").html("");  
                }else{
                    $(".email.regex").html("올바른 이메일이 아닙니다");
                }
            })
      //회원가입 버튼 눌렀을 때, 빈칸 있으면 다시 유효성 검사진행    
       $("#signupbtn").on("click",function(){
    	
    	   var id = $("#id").val();
    	   var pw = $("#pw").val();
    	   var name = $("#name").val();
    	   var phone = $("#phone").val();
    	   var email = $("#email").val();
    	   var yy =  $("#year").val();
    	   var mm = $("#month").val();
    	   var dd = $("#date").val();
    	   
    	   var idregex = /^[a-z]+[a-z0-9]{5,19}$/g;
    	   var pwregex =  /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
    	   var nameregex = /[가-힣]{2,}/;
    	   var phoneregex = /^01\d\d{3,4}\d{4}$/;
    	   var emailregex = /.+@[a-z]+(\.[a-z]+){1,2}$/;
    	   var yyregex = /^\d{4}$/;
    	   var mmregex = /^\d{1,3}$/;
    	   var ddregex = /^(0[1-9]|[12][0-9]|3[0-1])$/;
    	  	
    	   var dupleCheck = $("#idDuplication").val();
    	   if(dupleCheck != "idCheck"){
    		   alert("아이디 중복 확인을 해주세요.");
    		   return;
    	   }
    	  
    	 
    	   
    	   var idregex = idregex.exec(id);
    	   if(idregex == null){
    		   alert("아이디양식을 다시 확인해주세요");
    		   return;
    	   }
    	   var pwregex = pwregex.exec(pw);
    	   if(pwregex == null){
    		   alert("비밀번호양식을 다시 확인해주세요");
    		   retrun;
    	   }
    	   var nameregex = nameregex.exec(name);
    	   if(nameregex == null){
    		   alert("이름양식을 다시 확인해주세요");
    		   retrun;
    	   }
    	   var phoneregex = phoneregex.exec(phone);
    	   if(phoneregex == null){
    		   alert("핸드폰번호양식을 다시 확인해주세요");
    		   retrun;
    	   }
    	
    	   var emailregex = emailregex.exec(email);
    	   if(emailregex == null){
    		   alert("이메일양식을 다시 확인해주세요");
    		   retrun;
    	   }
    	   
           var yyregex = yyregex.exec(yy); 
           if(yyregex == null){
    		   alert("생'년'월일 양식을 다시 확인해주세요");
    		   retrun;
    	   }   
   
           var mmregex = mmregex.exec(mm); 
           if(mmregex == null){
    		   alert("생년'월'일 양식을 다시 확인해주세요");
    		   retrun;
    	   }
    	 
    	   var ddregex = ddregex.exec(dd); 
           if(ddregex == null){
    		   alert(" 생년월'일' 양식을 다시 확인해주세요");
    		   retrun;
    	   }                    
			
             //빈칸 없을 때 제출.
    	   $("#signform").submit();
       
       })
    })
    </script>
  </section>
 </div>

</body>
</html>