<%@ Page language="c#"%>
<%@ Import Namespace="System.Security.Principal" %>
<!DOCTYPE html>
<%
    string username = User.Identity.Name;
%>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>域用户管理首页</title>
        <link rel="stylesheet" href="/Content/StyleSheet.css" />
        <link rel="stylesheet" href="/Content/bootstrap.min.css" />
    </head>
    <body>
        <div class="container">
            <h1>首页</h1>
            <p>你好 <%=username %> <a class="btn btn-default" href="/Account/Manage.aspx">修改密码</a> <a class="btn btn-default" href="/Account/Logout.aspx">退出登录</a></p>
            <p>
            <a class="btn btn-default" href="account/admin/default.aspx">用户列表</a>
            <a class="btn btn-default" href="account/admin/adduser.aspx">添加用户</a>
            </p>
        </div>
        <script src="/Scripts/jquery-1.11.3.min.js"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
    </body>
</html>