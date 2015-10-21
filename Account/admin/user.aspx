<%@ Page language="c#"%>
<%@Import Namespace="System.Text" %>
<%@ Import Namespace="System.DirectoryServices" %>
<%@ Import Namespace="System.DirectoryServices.AccountManagement" %>
<!DOCTYPE html>
<%
    string alertStr = "<div class=\"alert alert-{0}\" role=\"alert\">{1}</div>";
    string msgStr = "";
    String _domain = System.Configuration.ConfigurationManager.AppSettings["domain"];

    string samaccountname = Request.QueryString["un"];
    
    string department = "";
    string title = "";
    string VoiceTelephoneNumber = "";
    string EmailAddress = "";
    string DisplayName = "";
    
    using (DirectoryEntry entry = new DirectoryEntry("LDAP://" + _domain))
    {
        DirectorySearcher deSearcher = new DirectorySearcher(entry);
        deSearcher.Filter = "(&(objectClass=user)(samAccountName=" + samaccountname + "))";
        DirectoryEntry de = deSearcher.FindOne().GetDirectoryEntry();
        try
        {
            department = de.Properties.Contains("department") ? de.Properties["department"][0].ToString() : "";
            title = de.Properties.Contains("title") ? de.Properties["title"][0].ToString() : "";
            VoiceTelephoneNumber = de.Properties.Contains("telephoneNumber") ? de.Properties["telephoneNumber"][0].ToString() : "";
            EmailAddress = de.Properties.Contains("mail") ? de.Properties["mail"][0].ToString() : "";
            DisplayName = de.Properties.Contains("displayName") ? de.Properties["displayName"][0].ToString() : "";
        }
        catch(Exception ex)
        {
            msgStr = string.Format(alertStr, "danger", ex.Message);
        }
        de.Dispose();
    }
 
%>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>修改用户资料</title>
        <link rel="stylesheet" href="/Content/StyleSheet.css" />
        <link rel="stylesheet" href="/Content/bootstrap.min.css" />
        <style type="text/css">
            h1{font-size:14pt; margin:0; padding:0}
            .formDiv{max-width:700px; margin-left:auto;margin-right:auto; margin-top:20px}
        </style>
    <body>
        <div class="container">
            <div class="panel panel-primary formDiv">
                <div class="panel-heading"><h1>修改用户资料</h1></div>
                <div class="panel-body">
                    <p>用户名: <%=samaccountname %></p>
                    <form class="form-horizontal" id="form1" method="post" action="edituser.aspx?act=edit&uid=<%=samaccountname %>">
                        <div class="form-group">
                            <label for="displayName" class="col-sm-2 control-label">用户姓名：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="displayName" name="displayName" value="<%=DisplayName %>"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="department" class="col-sm-2 control-label">部门：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="department" name="department" value="<%=department %>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="title" class="col-sm-2 control-label">职位：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="title" name="title" value="<%=title %>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="emailaddress" class="col-sm-2 control-label">Email：</label>
                            <div class="col-sm-5">
                                <input type="email" class="form-control" id="emailaddress" name="emailaddress" value="<%=EmailAddress %>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="telephonenumber" class="col-sm-2 control-label">电话号码：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="telephonenumber" name="telephonenumber" value="<%=VoiceTelephoneNumber %>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">操作员密码：</label>
                            <div class="col-sm-5">
                                <input type="password" class="form-control" id="password" name="password" placeholder="当前登录操作员的密码" required /> (需要权限才能保存修改)
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-5">
                                <button type="submit" class="btn btn-primary" name="act" value="edituser">修改</button>
                                <a class="btn btn-default" href="default.aspx">返回列表</a>
                                <a class="btn btn-default" href="/default.aspx">返回首页</a>
                            </div>
                        </div>
                    </form>
                </div>
                <%=msgStr %>
            </div>
        </div>
        <script src="/Scripts/jquery-1.11.3.min.js"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
    </head>
    </body>
</html>
