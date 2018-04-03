<%@ page import="JClouds.JCloudsNova" %>
<%@ page import="java.util.List" %>
<%@ page import="org.jclouds.openstack.nova.v2_0.domain.Server" %>
<%--
  Created by IntelliJ IDEA.
  User: thefalling
  Date: 2018/3/14
  Time: 下午 06:23
  To change this template use File | Settings | File Templates.
--%>
<%
    JCloudsNova jcloudsNova = new JCloudsNova();
    List<Server> servers=jcloudsNova.getServers();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN" >
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Maintainer Platform</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-theme.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/dashboard.css" rel="stylesheet" type="text/css">
    <script>
        $.fn.serializeObject = function() {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };
        function transcode() {
            $.ajax({
                params:{"contentType": "application/json;charset=utf-8"},
                url: "http://140.124.184.204:8888/myapi",
                type: "GET",
                data: {
                    videoinformation: JSON.stringify($('#myForm').serializeObject())
                },
//                contentType: 'application/text; charset=utf-8',
                dataType: "json",
                success: function(){
                        alert("successful!")
                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                    alert("error");
//                    alert(XMLHttpRequest.status);
//                    alert(XMLHttpRequest.readyState);
//                    alert(textStatus);
                }
            })
        }
    </script>
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
            <h2 class="sub-header">Transcoding</h2>
            <form id="myForm" role="form" action="" method="">
                <div class="form-group">
                    <label for="Filename">Filename</label>
                    <input type="text" class="form-control" id="Filename" name="Filename" placeholder="">
                </div>
                <div class="form-group">
                    <label for="Bitrate">Bitrate</label>
                    <input type="text" class="form-control" id="Bitrate" name="Bitrate" placeholder="">
                </div>
                <div class="form-group">
                    <label for="QP">QP</label>
                    <input type="number" min="20" max="40" class="form-control" id="QP" name="QP" placeholder="20~40">
                </div>
                <div class="form-group">
                    <label for="Resolution">Resolution</label>
                    <select class="form-control" id="Resolution" name="Resolution">
                        <option value="380">380p</option>
                        <option value="480">480p</option>
                        <option value="576">576p</option>
                        <option value="720">720p</option>
                        <option value="1024">1024p</option>
                        <option value="2048">2048p</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="VideoType">Video type</label>
                    <select class="form-control" id="VideoType" name="VideoType">
                        <option value="action">W&#40;合成&#41;</option>
                        <option value="action">X&#40;動畫&#41;</option>
                        <option value="action">Y&#40;記錄&#41;</option>
                        <option value="action">Z&#40;劇情&#41;</option>
                    </select>
                </div>
                <%--<div class="form-group">--%>
                    <%--<label for="ConnectionLog">Connection Log</label>--%>
                    <%--<textarea class="form-control" rows="3" id="ConnectionLog" name="ConnectionLog"></textarea>--%>
                <%--</div>--%>
                <%--<div class="form-group has-error">--%>
                    <%--<label for="assignment">分配工作任務到</label>--%>
                    <%--<select class="form-control" id="assignment" name="vmIP">--%>
                        <%--<%--%>
                            <%--for(int i=0;i<servers.size();i++){--%>
                        <%--%>--%>
                        <%--<option value="<%=servers.get(i).getAddresses().get("media_net").iterator().next().getAddr()%>"><%=servers.get(i).getName()%></option>--%>
                        <%--<%--%>
                            <%--}--%>
                        <%--%>--%>
                    <%--</select>--%>
                <%--</div>--%>
                <input type="button" value="Transcode" class="btn btn-primary " onclick="transcode()">
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>


