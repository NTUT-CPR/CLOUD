<%@ page import="java.util.ArrayList" %>
<%@ page import="JClouds.JCloudsNova" %>
<%@ page import="org.jclouds.openstack.nova.v2_0.domain.Image" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: thefalling
  Date: 2017/12/14
  Time: 下午 06:28
  To change this template use File | Settings | File Templates.
--%>
<%
    JCloudsNova jcloudsNova = new JCloudsNova();
    List<Image> images=jcloudsNova.getImages();
    SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm");
    String imagesCreatedDate=null;
    String imagesUpdatedDate=null;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Maintainer Platform</title>

    <link rel="stylesheet" href="css/bootstrap-theme.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/dashboard.css" rel="stylesheet" type="text/css">

</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="index">Maintainer Platform</a>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="active"><a href="#">Instance<span class="sr-only">(current)</span></a></li>
                <li><a href="serverInfoServlet">Instance List</a></li>
                <li><a href="serverOverviewServlet">Instance Overview</a></li>
                <li class="active"><a href="#">Image<span class="sr-only">(current)</span></a></li>
                <li><a href="imageInfo">Image List</a></li>
                <li class="active"><a href="#">Internet<span class="sr-only">(current)</span></a></li>
                <li><a href="internetServlet">Internet protocol</a></li>
                <li class="active"><a href="#">IS<span class="sr-only">(current)</span></a></li>
                <li><a href="iSListServlet">IS List</a></li>
                <li class="active"><a href="#">Assignment<span class="sr-only">(current)</span></a></li>
                <li><a href="videoTranscodeIndexServlet">Video</a></li>
                <li><a href="#">Data</a></li>
                <li class="active"><a href="#">Set Threshold<span class="sr-only">(current)</span></a></li>
                <li><a href="videoSetThresholdServlet">Video</a></li>
                <li><a href="dataSetThresholdServlet">Data</a></li>
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h2 class="sub-header">Images</h2>
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Created Time</th>
                        <th>UpdateTime</th>
                        <th>MinDisk(G)</th>
                        <th>MinRAM(M)</th>
                    </tr>
                    </thead>


                    <tbody>
                    <%
                        for(int i=0;i<images.size();i++){
                    %>
                    <tr>
                        <td><%=images.get(i).getName()%></td>
                        <td><%=images.get(i).getStatus()%></td>
                        <%
                            imagesCreatedDate=dateFormat.format(images.get(i).getCreated());
                            imagesUpdatedDate=dateFormat.format(images.get(i).getUpdated());
                        %>
                        <td><%=imagesCreatedDate%></td>
                        <td><%=imagesUpdatedDate%></td>
                        <td><%=images.get(i).getMinDisk()%></td>
                        <td><%=images.get(i).getMinRam()%></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>

                </table>
            </div>
        </div>
    </div>
</div>
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>

