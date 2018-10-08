<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/head.jsp"%>
<html>
  <head>
  </head>
   <body >
        <form  method="post" id="ff">
          <table>
             <tr><td><input type="hidden" value="${userinfo.userId}" name="userId"  id="userId"/></td></tr>
             <tr><td>用户名</td><td><input type="text" readonly="readonly"  value="${userinfo.userName}" name="userName"/></td></tr>
             <tr><td>原密码</td><td><input type="password" name="userPassword"/> </td></tr>
             <tr><td>新密码</td><td><input type="password" name="pwd1"/></td></tr>
             <tr><td>确认密码</td><td><input type="password" name="pwd2"/></td></tr>
         </table>
      </form>
  </body>
</html>
