<%@ Page Language="C#" %>
<!DOCTYPE html>

<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>安全退出</title>
        <link rel="stylesheet" href="/Content/StyleSheet.css" />
        <link rel="stylesheet" href="/Content/bootstrap.min.css" />
        <style type="text/css">
            h1{font-size:14pt; margin:0; padding:0}
            .loginDiv{max-width:300px; margin-left:auto;margin-right:auto; margin-top:20px}
        </style>
    </head>
    <body>
        <div class="container">
            <div class="panel panel-primary loginDiv">
                <div class="panel-heading"><h1>退出登录</h1></div>
                <div class="panel-body">
                     
                    <div class="alert alert-success" role="alert">您已安全退出</div>
                    <div><a class="btn btn-primary" href="/">返回</a></div>
                </div>
            </div>
            
            
        </div>
    </body>
    <script src="/Scripts/jquery-1.11.3.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
</html>
<script runat="server">
    protected void page_load()
    {
        Response.Cookies[FormsAuthentication.FormsCookieName].Expires = DateTime.Now.Add(TimeSpan.Zero);
    }
</script>
