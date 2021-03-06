<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <%@include file="/resources/web-fragments/head.jsp" %>
    <title>Login</title>
</head>
<body>
<div class="wrapper">

    <%@include file="/resources/web-fragments/navbar.jsp" %>

    <div class="center">
        <div class="container">
            <h1 id="title">Welcome</h1>
            <p id="description">Log into our service.</p>

            <form class="form" id="form" method="post" action="/login">
                <input type="email" class="email" name="email" placeholder="Email" required>
                <input type="password" id="password" class="password" name="password" placeholder="Password" required>
                <input type="submit" class="submit" value="Log In">
            </form>
            <form class="form" action="/register">
                <input type="submit" class="submit" value="Register" >
            </form>
        </div>
    </div>
</div>
</body>
</html>
