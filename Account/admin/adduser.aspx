<%@ Page Language="C#"%>
<!DOCTYPE html>
 
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>添加用户</title>
        <link rel="stylesheet" href="/Content/StyleSheet.css" />
        <link rel="stylesheet" href="/Content/bootstrap.min.css" />
        <style type="text/css">
            h1{font-size:14pt; margin:0; padding:0}
            .formDiv{max-width:700px; margin-left:auto;margin-right:auto; margin-top:20px}
        </style>
        
    </head>
    <body>
        <div class="container">
            <div class="panel panel-primary formDiv">
                <div class="panel-heading"><h1>添加用户</h1></div>
                <div class="panel-body">
                    <form class="form-horizontal" id="form1" method="post" action="edituser.aspx?act=add">
                        <div class="form-group">
                            <label for="newusername" class="col-sm-2 control-label">用户名：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="newusername" name="newusername" placeholder="用于登陆"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newuserpass" class="col-sm-2 control-label">密码：</label>
                            <div class="col-sm-5">
                                <input type="password" class="form-control" id="newuserpass" name="newuserpass" placeholder="密码"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="displayName" class="col-sm-2 control-label">用户姓名：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="displayName" name="displayName"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="department" class="col-sm-2 control-label">部门：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="department" name="department"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="title" class="col-sm-2 control-label">职位：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="title" name="title"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="emailaddress" class="col-sm-2 control-label">Email：</label>
                            <div class="col-sm-5">
                                <input type="email" class="form-control" id="emailaddress" name="emailaddress"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="telephonenumber" class="col-sm-2 control-label">电话号码：</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="telephonenumber" name="telephonenumber"  />
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
                                <button type="submit" class="btn btn-primary"  >添加</button>
                                <a class="btn btn-default" href="default.aspx">返回列表</a>
                                <a class="btn btn-default" href="/default.aspx">返回首页</a>
                            </div>
                        </div>
                    </form>
                </div>
 
            </div>
        </div>
        <script src="/Scripts/jquery-1.11.3.min.js"></script>
        <script src="/Scripts/bootstrap.min.js"></script>
    </body>
</html>