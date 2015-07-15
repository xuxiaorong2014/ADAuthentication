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
        <script src="/Scripts/jquery-1.8.2.min"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="alert alert-success" role="alert">您已安全退出</div>
            <div><a class="btn btn-primary" href="/">返回</a></div>
        </div>
    </body>
</html>
<script runat="server">
    protected void page_load()
    {
        Response.Cookies[FormsAuthentication.FormsCookieName].Expires = DateTime.Now.Add(TimeSpan.Zero);
    }
</script>
