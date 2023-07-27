<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="spring.*" %>

<%
String authority = (String) session.getAttribute("AUTHORITY");
if (authority == null) {
    // 로그인 되지 않은 경우, 로그인 페이지로 이동
    response.sendRedirect("login");
} else if ("staff".equals(authority)) {
    response.sendRedirect("step1");
} else {
    // 기타 권한인 경우, 특정 페이지로 이동하거나 메시지를 출력할 수 있음
    // 여기서는 예시로 로그인 정보와 권한 정보를 출력해봅니다.
    String id = (String) session.getAttribute("ID");
}
%>


<!DOCTYPE html>
<html lang="ko"> 
<head>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.0.0/dist/echarts.min.js"></script>
    <meta charset="utf-8"> 
</head>
<style>
* {
    margin: 0;
    box-sizing: border-box;
    }
    
    body {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	color: #58666e;
	background-color: #FFFFFF;
	-webkit-font-smoothing: antialiased;
	-webkit-text-size-adjust: 100%;
	}
	
	li {
		list-style: none;
	}
	
	a {
		text-decoration: none;
	}
	
	h1, h2, h3, h4, h5, h6, p {
		margin: 10px 5px;
	}
	
	h1 {
		font-size: 1.8em;
	}

    .wrap {
        display: grid; 
        grid-template-columns: 250px 1fr 1fr;
        grid-template-rows: 60px 90vh 60px;
    }
    
    .wrap > div {
    	padding: 0px;
    	width: 100%;
  	}
    /*
    .wrap > div {margin: 0px; padding: 10px; font-size: 20px;}
	*/
    .header { 
        grid-column-start: 2; grid-column-end: 4; 
		top: 0;
		left: 0;
		width: 100%;
		background-color: #fff;
		box-shadow: 0 2px 2px rgba(0, 0, 0, 0.05), 0 1px 0 rgba(0, 0, 0, 0.05);
		align-items: center;
		padding: 0 25px;
		font-size: 30px;
    }
    
   .header nav {
	float: right;
	}
	
	.nav-items {
		display: flex;
		align-items: center;
		white-space: nowrap;
	}
	
	.nav-items > li > a {
		line-height: 60px;
		padding: 0 30px;
		color: rgba(0, 0, 0, 0.4);
		font-size: 30px;
		white-space: nowrap;
	}
	
	.nav-items > li > a:hover {
		color: rgba(0, 0, 0, 0.4);
	}

	.logo {
		height: 36px;
	}
	
	.logo > img {
		height: 36px;
	}
    
    .sidemenu {
        grid-column-start: 1; grid-column-end: 2;
        grid-row-start: 1; grid-row-end: 3;
        min-width: 100px;
		bottom: 0;
		padding-top: 25px;
		background-color: #333;
	  }
	  .sidemenu > li > a {
	  	display: block;
		color: #fff;
		padding: 10px 0 10px 20px;
	  }
	  .sidemenu > li > a.active {
	  background-color: #4CAF50;
	  }
	  .sidemenu > li > a:hover:not(.active) {
	  background-color: #555;
	  }
	  .sidemenu > h1 {
	  color: #fff;
	  padding: 20px 0 20px 20px;
	  }
    
    .contents {
        grid-column-start: 2; grid-column-end: 4;
        grid-row-start: 2; grid-row-end: 3;
        background: #fff;
    }

    .content {
        display: grid; 
        grid-template-columns: 24% 24% 24% 24%;
        grid-template-rows: 50% 50%;
        background-color: #fff;
        padding: 0px;
        width: 100%;
        height: 100%;
        margin-left: 30px;
    }
    .content1 {
        grid-column-start: 1; grid-column-end: 5;
    	margin: 5px;
  		border-radius: 5px;

    }
    .content2 {
        background:#e7ebee;
        grid-column-start: 1; grid-column-end: 3;
    	margin: 5px;
  		border-radius: 5px;
    }
    .content3 {
        background:#e7ebee;
        grid-column-start: 3; grid-column-end: 5;
    	margin: 5px;
  		border-radius: 5px;
    }
 footer {
		bottom: 0;
		height: 60px;
		width: 100%;
		padding: 0 25px;
		line-height: 60px;
		color: #8a8c8f;
		border-top: 1px solid #dee5e7;
		background-color: #f2f2f2;
}
</style>
<body>
<div class="wrap">         
        <div class="header">
		    <header>
	    	<a class="logo" href=""><img src="p2/logo.png"></a>
			<nav>
				<ul class="nav-items">
					<li><a>Real-time monitoring system for production process</a><a href="logout.jsp" style="font-size: 15px;">로그아웃</a></li>
				</ul>
			</nav>
			</header>
	    </div> 

        <div class="sidemenu">
            <h1>수원 1공장<br>Manufacturing Process</h1>
				 <% if ("admin".equals(authority)) { %>
					<li><a href="main.html">관리자 페이지</a></li>
					<li><a href="home">수량 입력</a></li>
					<% } %>
					<li><a href="step1">1. Cutting process</a></li>
					<li><a href="step2">2. Packaging process</a></li>
					<li><a href="step3">3. Lid attachment process</a></li>
					<li><a href="error">ERROR</a></li></div>

		<div class="contents">
		            <div class="content">
		                <div class="content1" style="overflow: hidden;">
		            <div style="position: absolute; top: 60px; left: 250px;">
				    <a class="home" href=""><img src="home/home.png"></a>
				</div></div>
		                
			<div class="content2" style="position: absolute; top: 500px; left: 300px;">
				<form style="height: 200px; width: 200px;" action="/smf_process/process.do" method="post">
				    <label for="maxTaskNum">수량 입력</label>
				    <input type="number" id="maxTaskNum" name="maxTaskNum" required>
				    <button type="submit" name="action" value="start">시작하기</button>
				</form>
			</div></div>
			
			<div class="content3" style="position: absolute; top: 500px; left: 550px;">
				<form style="height: 200px; width: 200px;" action="/smf_process/process.do" method="post">
				    <button type="submit" name="action" value="stop">정지하기</button>
				    <button type="submit" name="action" value="pause">일시 중지</button>
				    <button type="submit" name="action" value="resume">재개하기</button>
				    <button type="submit" name="action" value="deleteData">데이터 삭제하기</button>
				</form>
			</div></div>
			

    <footer>© Copyright 2023 이조</footer>
    </div>
</body>
</html>
