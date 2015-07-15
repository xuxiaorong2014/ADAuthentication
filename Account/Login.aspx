<%@ Page language="c#"%>
<%@ Import Namespace="FormsAuth" %>
<!DOCTYPE html>
<%
    string strMSG = "";
    string username = "";

    string dangerStr = "<div class=\"alert alert-danger\" role=\"alert\">{0}</div>";
    if(Request["act"] == "login")
    {
        username = Request["username"];
        string password = Request["password"];
        bool chkPersist = Request["chkPersist"] == "true";
        
        if(username == null || username == "")
        {
            strMSG = strMSG = string.Format(dangerStr,"用户名不能为空");
        }
        else if(password == null || password == "")
        {
            strMSG = strMSG = string.Format(dangerStr,"密码不能为空");
        }
        else
        {
            LdapAuthentication adAuth = new LdapAuthentication();
            try
            {
                if (true == adAuth.IsAuthenticated(username, password))
                {
                    string groups = adAuth.GetGroups();
                    bool isCookiePersistent = chkPersist;
                    FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, username, DateTime.Now, DateTime.Now.AddMinutes(60), isCookiePersistent, groups);
                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                    HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                    if (true == isCookiePersistent)
                        authCookie.Expires = authTicket.Expiration;
                    Response.Cookies.Add(authCookie);
                    Response.Redirect(FormsAuthentication.GetRedirectUrl(username, false));
                }
                else
                {
                    strMSG = strMSG = string.Format(dangerStr,"用户名或密码不正确.");
                }
            }
            catch (Exception ex)
            {
                strMSG = string.Format(dangerStr, "登陆失败. " + ex.Message);
            }
        }
    }
%>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>用户登录</title>
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
                <div class="panel-heading"><h1>用户登录</h1></div>
                <div class="panel-body">
                    <form id="Login" method="post">  
                        <div class="form-group">
                            <label for="username">用户名:</label> 
                            <input type="text"  class="form-control"  id="username" name="username"  value="<%=username %>"/>
                        </div>
                        <div class="form-group">
                            <label>密码:</label>
                            <input type="password"  class="form-control"  id="password" name="password" />
                        </div>
                        <button id="btnLogin" class="btn btn-primary"  name="act" type="submit" value="login">登录</button>
                        <div class="checkbox">
                            <label><input type="checkbox" id="chkPersist" value="true" />记住我</label>
                        </div>
                    </form>
                    <p><%=strMSG %></p>
                </div>
            </div>
        </div>
    </body>
</html>
