<%@ page import="java.util.ArrayList" %>
<%@ page import="JClouds.JCloudsNova" %>
<%@ page import="java.util.List" %>
<%@ page import="org.jclouds.openstack.nova.v2_0.domain.Server" %><%--
  Created by IntelliJ IDEA.
  User: thefalling
  Date: 2017/12/17
  Time: 上午 01:09
  To change this template use File | Settings | File Templates.
--%>
<%
    JCloudsNova jcloudsNova = new JCloudsNova();
    List<Server> servers=jcloudsNova.getServers();
    ArrayList<String> imageName=(ArrayList<String>) request.getAttribute("imageName");
    ArrayList<String> flavorName=(ArrayList<String>) request.getAttribute("flavorName");
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
            <h2 class="sub-header">Instances</h2>
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>Instance Name</th>
                        <th>Image Name</th>
                        <th>IP Adress</th>
                        <th>Flavor Name</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%
                        for(int i=0;i<servers.size();i++){
                    %>
                    <tr>
                        <td><%=servers.get(i).getName()%></td>
                        <td><%=imageName.get(i)%></td>
                        <td><%=servers.get(i).getAddresses().get("media_net").iterator().next().getAddr()%></td>
                        <td><%=flavorName.get(i)%></td>
                        <td><%=servers.get(i).getStatus()%></td>
                        <td>
                            <div class="dropdown">
                                <button type="button" class="btn dropdown-toggle" id="dropdownMenu1"
                                        data-toggle="dropdown">
                                    開/關機
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                    <% if(servers.get(i).getStatus().value().equals("SHUTOFF")){ %>
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="api?action=active&serversId=<%=servers.get(i).getId()%>">開機</a>
                                    </li>
                                    <% }%>
                                    <!--<li role="presentation" class="divider"></li>-->
                                    <% if(servers.get(i).getStatus().value().equals("ACTIVE")){ %>
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="api?action=shutoff&serversId=<%=servers.get(i).getId()%>">關機</a>
                                    </li>
                                    <% }%>
                                </ul>
                            </div>
                        </td>
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
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
