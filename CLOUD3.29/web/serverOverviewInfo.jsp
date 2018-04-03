<%--
  Created by IntelliJ IDEA.
  User: thefalling
  Date: 2018/1/6
  Time: 下午 10:23
  To change this template use File | Settings | File Templates.
--%>
<%
    String serverName= (String) request.getAttribute("serverName");
    String serverId= (String) request.getAttribute("serverId");
    String serverStatus= (String) request.getAttribute("serverStatus");
    String serverAddress= (String) request.getAttribute("serverAddress");
    String serverCreatedTime= (String) request.getAttribute("serverCreatedTime");
    String serverUpdateTime= (String) request.getAttribute("serverUpdateTime");

    String flavorName= (String) request.getAttribute("flavorName");
    String flavorId= (String) request.getAttribute("flavorId");
    int flavorRam= (int) request.getAttribute("flavorRam");
    int flavorVcpu= (int) request.getAttribute("flavorVcpu");
    int flavorDisk= (int) request.getAttribute("flavorDisk");

    String imageName= (String) request.getAttribute("imageName");
    String imageId= (String) request.getAttribute("imageId");
    String imageStatus= (String) request.getAttribute("imageStatus");
    String imageCreatedTime= (String) request.getAttribute("imageCreatedTime");
    String imageUpdatedTime= (String) request.getAttribute("imageUpdatedTime");
    int imageMinRam= (int) request.getAttribute("imageMinRam");
    int imageMinDisk= (int) request.getAttribute("imageMinDisk");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="aaaaa">
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
            <h2>
                <%=serverName%>
            </h2>
            <hr style="background-color:#1874CD;height:3px" />
            <div class="row">
                <div class="col-sm-2 text-right">
                    名稱<br/>
                    識別號<br/>
                    狀態<br/>
                    可用區域<br/>
                    創建時間<br/>
                    更新時間<br/>
                </div>
                <div class="col-sm-10 text-left">
                    <%=serverName%><br/>
                    <%=serverId%><br/>
                    <%=serverStatus%><br/>
                    nova<br/>
                    <%=serverCreatedTime%><br/>
                    <%=serverUpdateTime%><br/>
                </div>
            </div>
            <hr/>

            <h3>Flavor</h3>
            <div class="row">
                <div class="col-sm-2 text-right">
                    虛擬硬體樣板名稱<br/>
                    虛擬硬體樣板識別號<br/>
                    隨機存取記憶體(MB)<br/>
                    虛擬處理器數<br/>
                    硬碟(GB)<br/>
                </div>
                <div class="col-sm-10 text-left">
                    <%=flavorName%><br/>
                    <%=flavorId%><br/>
                    <%=flavorRam%><br/>
                    <%=flavorVcpu%><br/>
                    <%=flavorDisk%><br/>
                </div>
            </div>
            <hr/>

            <h3>IP Addresses</h3>
            <div class="row">
                <div class="col-sm-2 text-right">
                    IP 位址<br/>
                </div>
                <div class="col-sm-10 text-left">
                    <%=serverAddress%><br/>
                </div>
            </div>
            <hr/>

            <h3>Image</h3>
            <div class="row">
                <div class="col-sm-2 text-right">
                    映像檔名稱<br/>
                    映像檔識別號<br/>
                    映像檔狀態<br/>
                    映像檔創建時間<br/>
                    映像檔更新時間<br/>
                    映像檔最小硬碟(MB)<br/>
                    映像檔最小內存(GB)<br/>
                </div>
                <div class="col-sm-10 text-left">
                    <%=imageName%><br/>
                    <%=imageId%><br/>
                    <%=imageStatus%><br/>
                    <%=imageCreatedTime%><br/>
                    <%=imageUpdatedTime%><br/>
                    <%=imageMinRam%><br/>
                    <%=imageMinDisk%><br/>
                </div>
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

