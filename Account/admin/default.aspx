<%@ Page Language="C#" %>
<%@Import Namespace="System.Text" %>
<%@Import Namespace="System.DirectoryServices" %>
<!DOCTYPE html>
<%
    string msgStr = "";
    String _domain = System.Configuration.ConfigurationManager.AppSettings["domain"];
    StringBuilder sb = new StringBuilder();
    DirectoryEntry entry = new DirectoryEntry("LDAP://" + _domain);
    DirectorySearcher deSearcher = new DirectorySearcher(entry);
    deSearcher.Filter = "(&(objectClass=user)(objectCategory=person))";
    sb.Append("<table class=\"table\">");
    sb.Append("<tr><th>账户名或显示名</th><th>部门</th><th>职务</th><th>Email</th><th>电话</th><th>状态</th><th>编辑</th></tr>");
    foreach (SearchResult sr in deSearcher.FindAll())
    {
        DirectoryEntry de = sr.GetDirectoryEntry();
        string samaccountname = de.Properties["samaccountname"][0].ToString();
        string cn = de.Properties["cn"][0].ToString();
        Int32 uac =  (Int32)de.Properties["userAccountControl"][0];
        sb.Append("<tr>");
        sb.AppendFormat("<td>{0}</td>", de.Properties.Contains("displayName") ? de.Properties["displayName"][0].ToString() : cn);
        sb.AppendFormat("<td>{0}</td>", de.Properties.Contains("department") ? de.Properties["department"][0].ToString() : " ");
        sb.AppendFormat("<td>{0}</td>", de.Properties.Contains("title") ? de.Properties["title"][0].ToString() : " ");
        sb.AppendFormat("<td>{0}</td>", de.Properties.Contains("mail") ? de.Properties["mail"][0].ToString() : " ");
        sb.AppendFormat("<td>{0}</td>", de.Properties.Contains("telephonenumber") ? de.Properties["telephonenumber"][0].ToString() : "");
        sb.AppendFormat("<td>{0}</td>", uac % 8 == 2 ? "已停用" : "");
        sb.AppendFormat("<td><a href=\"info.aspx?un={0}\">查看</a> <a href=\"user.aspx?un={0}\">编辑</a> <a  href=\"javascript:;\" onclick=\"enable('{0}','{1}')\">{1}</a> <a href=\"javascript:;\" onclick=\"newpass('{0}')\">重设密码</a> <a href=\"javascript:;\" onclick=\"del('{0}')\">删除</a> </td>  ", samaccountname, uac % 8 == 2 ? "启用" : "停用");
        sb.Append("</tr>");
    }
    sb.Append("</table>");
    msgStr = sb.ToString();
%>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>用户列表</title>
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
                <div class="panel-heading"><h1>用户列表</h1></div>
                <div class="panel-body">
                     <%=msgStr %>
                    <p><a class="btn btn-default" href="/default.aspx">返回</a></p>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modialog">
          <div class="modal-dialog modal-sm">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">请输入当前用户密码</h4>
              </div>
                <form id="dialogform" method="get" action="edituser.aspx">
                  <div class="modal-body">
                      <p id="actTip"></p>
                      <input class="form-control" type="password" id="password" name="password" required />
                      <input type="hidden" id="act" name="act" value="" />
                      <input type="hidden" id="uid" name="uid" value="" />
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">确定</button>
                  </div>
                </form>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal --> 

        <script src="/Scripts/jquery-1.11.3.min.js"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
        <script type="text/javascript">
            $(function () {
 
            });

            function del(uid) {
                $("#uid").val(uid);
                $("#act").val('del');
                $("#actTip").html('确认要删除用户吗？ 请输入管理员密码以确认！');
                $('#modialog').modal();
            }

            function newpass(uid) {
                $("#uid").val(uid);
                $("#act").val('newpass');
                $("#actTip").html('重置用户密码？ <br />请输入当前管理员密码以确认！ <br /> 用户密码将会重置为 welCome1 , 用户下次登陆必须修改');
                $('#modialog').modal();
            }
            function enable(uid, c) {
                $("#uid").val(uid);
                if (c == '停用') {
                    $("#act").val('disable');
                    $("#actTip").html('确认要停用用户吗？ 请输入管理员密码以确认！');
                }
                else {
                    $("#act").val('enable');
                    $("#actTip").html('确认要启用用户吗？ 请输入管理员密码以确认！');
                }
                $('#modialog').modal();
            }
        </script>
    </body>
</html>
