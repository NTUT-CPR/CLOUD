<%@ page import="java.util.ArrayList" %>
<%@ page import="JClouds.JCloudsNova" %>
<%@ page import="org.jclouds.openstack.neutron.v2.domain.Network" %>
<%@ page import="java.util.List" %>
<%@ page import="org.jclouds.openstack.nova.v2_0.domain.Server" %>
<%@ page import="org.jclouds.openstack.neutron.v2.domain.Router" %><%--
  Created by IntelliJ IDEA.
  User: thefalling
  Date: 2018/1/16
  Time: 下午 10:15
  To change this template use File | Settings | File Templates.
--%>
<%
    JCloudsNova jcloudsNova = new JCloudsNova();
    List<Server> servers=jcloudsNova.getServers();
    List<Network> networks=jcloudsNova.getNetworks();
    List<Router> routers=jcloudsNova.getRouters();
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

    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js" type="text/javascript"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="js/jtopo-0.4.8-min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            var stage = new JTopo.Stage(canvas);
            var scene = new JTopo.Scene(stage);
            //節點
            var node=new Array();
            var x=0;
            var effect = JTopo.Effect.spring({
                minLength: 200 // 节点之间最短距离
            });
            <% for(int i=0;i<servers.size();i++){ %>
                var instanceName="<%=servers.get(i).getName()+"("+servers.get(i).getAddresses().get("media_net").iterator().next().getAddr()+")"%>";
                node[<%=i%>] = new JTopo.Node(instanceName);
                node[<%=i%>].setImage('../pic/pc1.png', true);
                node[<%=i%>].setLocation(780,90+x);
                x+=80;
                scene.add(node[<%=i%>]);
            <% } %>

            var network=new Array();
            <% for(int i=0;i<networks.size();i++){ %>
                var name="<%=networks.get(i).getName()%>";
                var isExternal="<%=networks.get(i).getExternal()%>";
                network[<%=i%>]= new JTopo.Node(name);
                //External network
                if(isExternal=="true"){
                    //外網
                    network[<%=i%>].setImage('../pic/earth1.png', true);
                    network[<%=i%>].setLocation(180,180);
                    scene.add(network[<%=i%>]);
                }else{
                    network[<%=i%>].setImage('../pic/cloud11.png', true);
                    network[<%=i%>].setLocation(580,180);
                    scene.add(network[<%=i%>]);

                    <% for(int j=0;j<servers.size();j++) {%>
                        //如果vm的network名稱與此network名稱相同，此vm連接到此network
                        if(name=="<%=servers.get(j).getAddresses().toString().substring(servers.get(j).getAddresses().toString().indexOf("{")+1,servers.get(j).getAddresses().toString().indexOf("="))%>"){
                            var link = new JTopo.Link(network[<%=i%>],node[<%=j%>]);
                            scene.add(link);
                            //effect.addNode(network[<%=i%>],node[<%=j%>]);
                        }
                    <% } %>
                }
            <% } %>

            var router=new Array();
                <% for(int i=0;i<routers.size();i++) {%>
                var routerName="<%=routers.get(i).getName()%>";
                router[<%=i%>] = new JTopo.Node(routerName);
                router[<%=i%>].setImage('../pic/router1.png', true);
                router[<%=i%>].setLocation(380,180);
                scene.add(router[<%=i%>]);

                <% for(int j=0;j<networks.size();j++) {%>
                    var match="<%=routers.get(i).getExternalGatewayInfo().getNetworkId().equals(networks.get(j).getId())%>";
                    if(match=="true"){
                        var link2 = new JTopo.Link(router[<%=i%>],network[<%=j%>]);
                        scene.add(link2);
                    }else{
                        var link3 = new JTopo.Link(router[<%=i%>],network[<%=j%>]);
                        scene.add(link3);
                    }
                    //effect.addNode(network[<%=i%>],node[<%=j%>]);
                <% } %>

                <%}%>
            //effect.play();

        });
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
//左邊條件
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
            <canvas width="1520" height="1000" id="canvas" style=" background-color:#4D4D4D; border:1px solid #444;"></canvas>

        </div>
    </div>
</div>
</body>
</html>


