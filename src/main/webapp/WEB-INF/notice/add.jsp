<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/head.jsp"%>

<html>
  <head>
       <script type="text/javascript" charset="utf-8" src="${path}/ueditor/ueditor.config.js"></script>
       <script type="text/javascript" charset="utf-8" src="${path}/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
        <script type="text/javascript" charset="utf-8" src="${path}/ueditor/lang/zh-cn/zh-cn.js"></script>
        
     
  </head>
   <body >
        <form  method="post" id="ff">
          <table>
             <tr><td width="100px;">公告主题</td><td width="300px"><input type="text" name="noticeTitle" /></td></tr>
             <tr><td width="100px;">公告内容</td><td><textarea id="editor" style="width: 880px;" name="noticeContent"></textarea> </td></tr>
             <tr><td width="100px;">发布人</td><td><input type="text" name="noticeAuthor" value="${userinfo.userName}"/></td></tr>
             <tr><td width="100px;">发布日期</td><td> <input class="easyui-datetimebox" name="createTime"     
        data-options="required:true,showSeconds:false" value=" " style="width:150px"> 
        </td></tr>
         </table>
      </form>
     
      <script type="text/javascript">
         window.UEDITOR_HOME_URL = "${path}/ueditor/";
         var ue = UE.getEditor('editor');
      </script>
  </body>
</html>
