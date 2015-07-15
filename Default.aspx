<%@ Page language="c#"%>
<%@ Import Namespace="System.Security.Principal" %>
<!DOCTYPE html>
<%
    string username = User.Identity.Name;
    string AuthType = User.Identity.AuthenticationType;
    string roles = "";
    if(User.IsInRole("Domain Users"))
    {
        roles = "Domain Users";
    }
%>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>首页</title>
        <link rel="stylesheet" href="/Content/StyleSheet.css" />
        <link rel="stylesheet" href="/Content/bootstrap.min.css" />
        <script src="/Scripts/jquery-1.8.2.min"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container">
            <h1>首页</h1>
            <p>你好 <%=username %></p>
            <p>用户认证类型 <%=AuthType %> , 权限： <%=roles %></p>
            <a class="btn btn-default" href="/Account/Manage.aspx">修改密码</a>
            <a class="btn btn-default" href="/Account/Logout.aspx">退出登录</a>
        </div>
    </body>
</html>