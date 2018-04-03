
<%@ page import="ISMonitor.ISMonitor" %>
<%@ page import="ISMonitor.ISModel" %>

<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: thefalling
  Date: 2018/3/15
  Time: 下午 10:12
  To change this template use File | Settings | File Templates.
--%>
<%
    ArrayList<ISModel> ISList=ISMonitor.getISList();
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
            <h2 class="sub-header">IS</h2>
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>VM Name</th>
                        <th>IP</th>
                        <th>VM State</th>
                        <th>Job</th>
                        <th>IS State</th>
                        <th>IS State Time</th>
                        <th>IS Offline Time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for(ISModel isModel:ISList){
                    %>
                    <tr>
                        <td><%=isModel.getVmName()%></td>
                        <td><%=isModel.getVmIP()%></td>
                        <td><%=isModel.getVmState()%></td>
                        <td><%=isModel.getVmJob()%></td>
                        <td>
                            <%
                                String state=isModel.getISState();
                                if(state.equals("no_work")){
                            %>
                            <img src="../pic/gray%20check.png" class="img-responsive">
                            <%
                                }else if(state.equals("working")){
                            %>
                            <img src="../pic/green%20check.jpg" class="img-responsive">
                            <%
                                }else if(state.equals("offline")){
                            %>
                            <img src="../pic/red%20cross.jpg" class="img-responsive">
                            <%
                                }else{
                            %>
                            offline
                            <%
                                }
                            %>
                        </td>
                        <td><%=isModel.getISStateTime()%></td>
                        <td><%=isModel.getISOfflineTime()%></td>
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
