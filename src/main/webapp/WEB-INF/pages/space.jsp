<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        #MyBody {
            background-color: rgb(0, 0, 0);
        }

        nav {
            margin: 0;
            padding: 0;
        }

        div {
            margin: 0;
            padding: 0
        }

        #container {
            float: left;
            width: 70%;
            height: 100%;
            border: 0 solid #ccc;
            background: rgb(0, 0, 0);
        }

        #rightbar {
            float: right;
            width: 30%;
            height: 100%;
            border: 0 solid #ccc;
            background: rgb(0, 0, 0);
        }
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${username}的空间</title>
    <script>
        function gender() {
            if ("${gender}" === "0") {
                document.getElementById("sex").innerHTML = "男";
            }
            else {
                document.getElementById("sex").innerHTML = "女";
            }
            if ("${user}" === "") {
                document.getElementById("fbtn").style.visibility = "hidden";
                document.getElementById("login").style.visibility = "visible";
                document.getElementById("sign").style.visibility = "visible";
                document.getElementById("logout").style.visibility = "hidden";
                document.getElementById("username").style.visibility = "hidden";
            }
            else {
                document.getElementById("login").style.visibility = "hidden";
                document.getElementById("sign").style.visibility = "hidden";
                document.getElementById("logout").style.visibility = "visible";
                document.getElementById("username").style.visibility = "visible";
                document.getElementById("fbtn").style.visibility = "visible";
                if ("${iffollow}" === "1") {
                    btnunfollow()
                }
                else("${iffollow}" === "0")
                {
                    btnfollow()
                }
            }
        }
        function btnunfollow() {
            document.getElementById("fbtn").setAttribute("class", "btn btn-danger btn-lg");
            document.getElementById("fbtn").innerHTML = "取消关注";
        }
        function btnfollow() {
            document.getElementById("fbtn").setAttribute("class", "btn btn-primary btn-lg");
            document.getElementById("fbtn").innerHTML = "关注";
        }
        function sendfollow() {
            var f = "${ownername}";
            $.ajax({
                type: "post",
                url: "follow",
                dataType: "json",    //data传递的是一个json类型的值，而不是字符串，且必须标明dataType的类型，否则会出现400错误或者其他错误。
                data: {"fname": f},
                success: function (data) {
                    if (data.result == 1) {
                        btnunfollow();
                    }
                    else if(data.result == 0)
                    {
                        btnfollow();
                    }
                },
                error: function () {
                    alert("网络错误");
                }
            });
        }
    </script>
    <script src="resources/jquery.js"></script>
    <link href="resources/bootstrap.min.js"/>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body id="MyBody" onload=gender()>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="navbar-header">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="index">HIT_PY</a>
                <ul class="nav navbar-nav navbar-right" id="login">
                    <li class="navbar-right"><a href="login">登录</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right" id="sign">
                    <li class="navbar-right"><a href="signup">注册</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right" id="username">
                    <li class="navbar-right"><a style="text-align: center"
                                                href="myspace"> ${username} </a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right" id="logout">
                    <li class="navbar-right"><a href="logout">退出</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>
<div id="container">
    <div><h1 style="color: mintcream; padding: 10px 100px 10px">${ownername}的空间</h1></div>
    <div style="margin-right: 5%;float: right">
        <button class="bt btn-primary btn-lg" id="fbtn" onclick="sendfollow()">
            关注
        </button>
    </div>
    <div style="margin-top: 70px">
    <blockquote class="blockquote-reverse">
        <p style="color: mintcream">${ps}</p>
        <footer style="color: mintcream">${ownername}</footer>
    </blockquote>
    </div>
    <div id="c2" style="width: 85%;margin-left: 7.5%; ">
        <ul class="list-group">
            <li class="list-group-item"><b><span class="label label-default">入学年份</span> <span
                    style="float:right"> ${entryYear}</span> </b></li>
            <li class="list-group-item"><b><span class="label label-default">性别</span> <span
                    style="float:right" id="sex">${gender}</span> </b></li>
            <li class="list-group-item"><b><span class="label label-default">发起活动数量</span> <span
                    style="float:right">${uid}</span></b></li>
        </ul>
    </div>
    <h4 style="color: mintcream; padding: 10px 100px 10px">ta参加的活动</h4>
    <div class="bs-docs-example">
        <table class="table">
            <tbody>
            <c:forEach items="${activitylist}" var="p">
                <tr>
                    <td>
                        <a href="showActivity?aid=${p.aid}" style="color: mintcream">${p.name}</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <h4 style="color: mintcream; padding: 10px 100px 10px">ta发布的活动</h4>
    <div class="bs-docs-example">
        <table class="table">
            <tbody>
            <c:forEach items="${myActivitylist}" var="p">
                <tr>
                    <td>
                        <a href="showActivity?aid=${p.aid}" style="color: mintcream">${p.name}</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div id="rightbar">
    <div style="float: left; margin-left: 70px;margin-top: 150px">
        <p style="color: #66ccff">关注：${followingnum}</p>
        <p style="color: #66ccff">粉丝：${followernum}</p>
    </div>
</div>
</body>
</html>