<%@ Page language="c#"%>
<%@ Import Namespace="System.DirectoryServices" %>
<%@ Import Namespace="System.DirectoryServices.AccountManagement" %>
<!DOCTYPE html>
<%
    string username = User.Identity.Name; 
    string alertStr = "<div class=\"alert alert-{0}\" role=\"alert\">{1}</div>";
    string msgStr = "";
    string _domain = System.Configuration.ConfigurationManager.AppSettings["domain"];
    
    string password = Request["password"];

    string uid = Request.QueryString["uid"];
    
    string strContainer = "CN=Users";

    string DisplayName = "";


    foreach (string dc in _domain.Split('.'))
    {
        strContainer = strContainer + ",DC=" + dc;
    }

    using (var context = new PrincipalContext(ContextType.Domain, _domain, strContainer, ContextOptions.Negotiate, username, password))
    {
        
        if (Request["act"] == "edit")
        {
            UserPrincipal oUserPrincipal = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, uid);
            DisplayName = oUserPrincipal.DisplayName;
            string department = Request["department"];
            string title = Request["title"];
            oUserPrincipal.EmailAddress = Request["emailaddress"];
            oUserPrincipal.VoiceTelephoneNumber = Request["telephonenumber"];
            oUserPrincipal.DisplayName = Request["displayName"];
            try
            {
                oUserPrincipal.Save();
            }
            catch (Exception ex)
            {
                msgStr = string.Format(alertStr, "danger", ex.Message);
            }
            if (oUserPrincipal.GetUnderlyingObjectType() == typeof(DirectoryEntry))
            {
                DirectoryEntry entry = (DirectoryEntry)oUserPrincipal.GetUnderlyingObject();
                if (entry.Properties.Contains("department"))
                {
                    entry.Properties["department"][0] = department;
                }
                else
                {
                    entry.Properties["department"].Add(department);
                }
                if (entry.Properties.Contains("title"))
                {
                    entry.Properties["title"][0] = title;
                }
                else
                {
                    entry.Properties["title"].Add(title);
                }
                
                try
                {
                    entry.CommitChanges();
                    msgStr = string.Format(alertStr, "success", "用户 " + DisplayName + " 用户信息已保存！");
                }
                catch (Exception ex)
                {
                    msgStr = string.Format(alertStr, "danger", ex.Message);
                }
            }
        }
        else if (Request["act"] == "add")
        {
            string department = Request["department"];
            string title = Request["title"];
            string newusername = Request["newusername"];
            UserPrincipal oUserPrincipal = new UserPrincipal(context);
            oUserPrincipal.EmailAddress = Request["emailaddress"];
            oUserPrincipal.VoiceTelephoneNumber = Request["telephonenumber"];
            oUserPrincipal.DisplayName = Request["displayName"];
            oUserPrincipal.SamAccountName = newusername;
            oUserPrincipal.SetPassword(Request["newuserpass"]);
            oUserPrincipal.Enabled = true;
            oUserPrincipal.PasswordNeverExpires = true;
            msgStr = string.Format(alertStr, "success", "用户 " + newusername + " 已成功添加！");
            try
            {
                oUserPrincipal.Save();
            }
            catch (Exception ex)
            {
                msgStr = string.Format(alertStr, "danger", ex.Message);
            }
            if (oUserPrincipal.GetUnderlyingObjectType() == typeof(DirectoryEntry))
            {
                DirectoryEntry entry = (DirectoryEntry)oUserPrincipal.GetUnderlyingObject();
                if (entry.Properties.Contains("department"))
                {
                    entry.Properties["department"][0] = department;
                }
                else
                {
                    entry.Properties["department"].Add(department);
                }
                if (entry.Properties.Contains("title"))
                {
                    entry.Properties["title"][0] = title;
                }
                else
                {
                    entry.Properties["title"].Add(title);
                }
                
                try
                {
                    entry.CommitChanges();
                }
                catch (Exception ex)
                {
                    msgStr = string.Format(alertStr, "danger", ex.Message);
                }
            }
        }
        else if (Request["act"] == "disable")
        {
            UserPrincipal oUserPrincipal = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, uid);
            oUserPrincipal.Enabled = false;
            msgStr = string.Format(alertStr, "success", "用户 " + oUserPrincipal.Name + " 已禁用！");
            try
            {
                oUserPrincipal.Save();
            }
            catch(Exception ex)
            {
                msgStr = string.Format(alertStr, "danger", ex.Message);
            }
        }
        else if (Request["act"] == "enable")
        {
            UserPrincipal oUserPrincipal = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, uid);
            oUserPrincipal.Enabled = true;
            msgStr = string.Format(alertStr, "success", "用户 " + oUserPrincipal.Name + " 已启用！");
            try
            {
                oUserPrincipal.Save();
            }
            catch (Exception ex)
            {
                msgStr = string.Format(alertStr, "danger", ex.Message);
            }
        }
        else if (Request["act"] == "del")
        {
            UserPrincipal oUserPrincipal = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, uid);
            msgStr = string.Format(alertStr, "success", "用户 " + oUserPrincipal.Name + " 已删除！");
            try
            {
                oUserPrincipal.Delete();
            }
            catch (Exception ex)
            {
                msgStr = string.Format(alertStr, "danger", ex.Message);
            }
        }
        else if (Request["act"] == "newpass")
        {
            UserPrincipal oUserPrincipal = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, uid);
            msgStr = string.Format(alertStr, "success", "用户 " + oUserPrincipal.Name + " 密码已改为 welCome1 , 用新密码登陆后，必须重设密码！");
            try
            {
                oUserPrincipal.SetPassword("welCome1");
                oUserPrincipal.ExpirePasswordNow();
                oUserPrincipal.Save();
            }
            catch (Exception ex)
            {
                msgStr = string.Format(alertStr, "danger", ex.Message);
            }
        }
    }
%>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>操作结果</title>
        <link rel="stylesheet" href="/Content/StyleSheet.css" />
        <link rel="stylesheet" href="/Content/bootstrap.min.css" />
        <style type="text/css">
            h1{font-size:14pt; margin:0; padding:0}
            .formDiv{max-width:300px; margin-left:auto;margin-right:auto; margin-top:20px}
        </style>
    <body>
        <div class="container">
            <div class="panel panel-primary formDiv">
                <div class="panel-heading"><h1>操作结果</h1></div>
                <div class="panel-body">
                     <%=msgStr %>
                    <div>
                        <a class="btn btn-default" href="default.aspx">返回列表</a>
                        <a class="btn btn-default" href="/default.aspx">返回首页</a>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="/Scripts/jquery-1.11.3.min.js"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
    </head>
    </body>
</html>
