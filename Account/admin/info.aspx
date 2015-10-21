<%@ Page Language="C#" %>
<%@Import Namespace="System.Text" %>
<%@Import Namespace="System.DirectoryServices" %>
<%@Import Namespace="System.DirectoryServices.AccountManagement" %>
<!DOCTYPE html>
<script runat="server">
    string msgStr = "";
    

    void Page_Load()
    {
        String _domain = System.Configuration.ConfigurationManager.AppSettings["domain"];
        StringBuilder sb = new StringBuilder();
        string samaccountname = Request["un"];
       
        
        PrincipalContext context  = new PrincipalContext(ContextType.Domain,_domain);
        UserPrincipal oUserPrincipal = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, samaccountname);

        DirectoryEntry entry = new DirectoryEntry("LDAP://" + _domain);
        DirectorySearcher deSearcher = new DirectorySearcher(entry);
        deSearcher.Filter = "(&(objectClass=user)(samAccountName=" + samaccountname + "))";
        DirectoryEntry de = deSearcher.FindOne().GetDirectoryEntry();

        sb.Append("<table class=\"table\">");
        sb.Append("<tr><th>PropertyName</th><th>PropertyCount</th><th>PropertyType</th><th>PropertyValue</th></tr>");
        foreach(string pn in de.Properties.PropertyNames)
        {
            PropertyValueCollection objectClass = de.Properties[pn];
            if (pn == "objectSid")
            {
                sb.AppendFormat("<tr><td>{0}</td><td>{1} Principal</td><td></td><td>{2}</td></tr>", pn, objectClass.Count, oUserPrincipal.Sid);
            }
            else if (pn == "badPasswordTime")
            {
                sb.AppendFormat("<tr><td>{0}</td><td>{1} Principal</td><td></td><td>{2}</td></tr>", pn, objectClass.Count, oUserPrincipal.LastBadPasswordAttempt);
            }
            else if (pn == "lastLogon")
            {
                sb.AppendFormat("<tr><td>{0}</td><td>{1} Principal</td><td></td><td>{2}</td></tr>", pn, objectClass.Count, oUserPrincipal.LastLogon);
            }
            else if(pn=="objectGUID")
            {
                sb.AppendFormat("<tr><td>{0}</td><td>{1} Principal</td><td></td><td>{2}</td></tr>", pn, objectClass.Count, oUserPrincipal.Guid);
            }
            else
            {
                sb.AppendFormat("<tr><td>{0}</td><td>{1}</td><td></td><td>{2}</td></tr>", pn, objectClass.Count, getPropertyValue(objectClass));
            }
            
        }
        sb.Append("</table>"); 
 
        msgStr = sb.ToString();
    }

    string getPropertyValue(PropertyValueCollection Property)
    {
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < Property.Count; i++)
        {


            sb.AppendFormat("({0})", Property[i]);
        }
        

        return sb.ToString();
    }


     
</script>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>用户信息</title>
        <link rel="stylesheet" href="/Content/StyleSheet.css" />
        <link rel="stylesheet" href="/Content/bootstrap.min.css" />
        <style type="text/css">
            h1{font-size:14pt; margin:0; padding:0}
            .formDiv{max-width:300px; margin-left:auto;margin-right:auto; margin-top:20px}
        </style>
    </head>
    <body>
        <div class="container ">
            <div class="panel panel-primary  ">
                <div class="panel-heading"><h1>用户信息</h1></div>
                <div class="panel-body">
                     <%=msgStr %>
                    <p><a class="btn btn-default" href="default.aspx">返回</a></p>
                </div>
            </div>
        </div>

         

        <script src="/Scripts/jquery-1.11.3.min.js"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
        <script type="text/javascript">
            $(function () {
      
            });
        </script>
    </body>
</html>
