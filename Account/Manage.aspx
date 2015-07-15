<%@ Page Language="C#"%>
<%@Import Namespace="System.DirectoryServices" %>
<!DOCTYPE html>
<%
    string username = User.Identity.Name;

    string alertStr = "<div class=\"alert alert-{0}\" role=\"alert\">{1}</div>";

    string msgStr = string.Format(alertStr, "info", "你已使用以下身份登录:" + username);
    if (Request["act"] == "newpassword")
    {
        string password = Request["password"];
        string newPassword = Request["newPassword"];
        string newPassword1 = Request["newPassword1"];
        using (DirectoryEntry entry = new DirectoryEntry("LDAP://redpod.com.cn", username, password))
        {
            try
            {
                DirectorySearcher deSearcher = new DirectorySearcher(entry);
                deSearcher.Filter = "(&(objectClass=user)(samAccountName=" + username + "))";
                DirectoryEntry usr = deSearcher.FindOne().GetDirectoryEntry();
                usr.Invoke("ChangePassword", new Object[2] { password, newPassword });
                usr.CommitChanges();
                msgStr = string.Format(alertStr,"success", "密码已成功修改");
            }
            catch(Exception ex)
            {
                msgStr = string.Format(alertStr,"danger",ex.Message);
            }
        }
    }    
%>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>修改密码</title>
        <link rel="stylesheet" href="/Content/StyleSheet.css" />
        <link rel="stylesheet" href="/Content/bootstrap.min.css" />
        <style type="text/css">
            h1{font-size:14pt; margin:0; padding:0}
            .loginDiv{max-width:300px; margin-left:auto;margin-right:auto; margin-top:20px}
        </style>
        <script src="/Scripts/jquery-1.8.2.min"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="panel panel-primary loginDiv">
                <div class="panel-heading"><h1>更改密码</h1></div>
                <div class="panel-body">
                    <form id="form1" method="post">
                        <div class="form-group">
                            <label for="password">当前密码：</label>
                            <input type="password" class="form-control" id="password" name="password" />
                        </div>
                        <div class="form-group">
                            <label for="newPassword">新密码：</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" />
                        </div>
                        <div class="form-group">
                            <label for="newPassword1">确认新密码：</label>
                            <input type="password" class="form-control" id="newPassword1" name="newPassword1" />
                        </div>
                        <button type="submit" class="btn btn-primary" name="act" value="newpassword">修改密码</button>
                        <a class="btn btn-default" href="/">返回</a>
                    </form>
                </div>
                <p><%=msgStr %></p>
            </div>
        </div>
    </body>
</html>