package JClouds;

/**
 * Created by thefalling on 2017/12/14.
 */
import java.text.SimpleDateFormat;
import java.util.*;

import com.google.common.collect.ImmutableSet;
import com.google.common.io.Closeables;
import com.google.common.base.Optional;
import com.google.inject.Module;
import org.jclouds.ContextBuilder;
import org.jclouds.logging.slf4j.config.SLF4JLoggingModule;
import org.jclouds.openstack.nova.v2_0.NovaApi;
import org.jclouds.openstack.nova.v2_0.domain.Server;
import org.jclouds.openstack.nova.v2_0.domain.Flavor;
import org.jclouds.openstack.nova.v2_0.domain.Image;
import org.jclouds.openstack.nova.v2_0.features.ServerApi;
import org.jclouds.openstack.nova.v2_0.features.FlavorApi;
import org.jclouds.openstack.nova.v2_0.features.ImageApi;

import org.jclouds.openstack.nova.v2_0.domain.RebootType;

import org.jclouds.openstack.neutron.v2.NeutronApi;
import org.jclouds.openstack.neutron.v2.features.NetworkApi;
import org.jclouds.openstack.neutron.v2.domain.*;
import org.jclouds.openstack.neutron.v2.extensions.*;

import java.io.Closeable;
import java.io.IOException;


import java.io.Closeable;
import java.io.IOException;
import java.util.List;
import java.util.Set;

public class JCloudsNova implements Closeable {
    private final NovaApi novaApi;
    private final NeutronApi neutronApi;
    private final Set<String> regions;
    private final Set<String> regionNeutron;

    public JCloudsNova() {
        Iterable<Module> modules = ImmutableSet.<Module>of(new SLF4JLoggingModule());

        String provider = "openstack-nova";
        String providerNeutron = "openstack-neutron";
        String identity = "media:media"; // tenantName:userName
        String credential = "media";

        novaApi = ContextBuilder.newBuilder(provider)
                .endpoint("http://140.124.184.204/identity/v2.0/")
                .credentials(identity, credential)
                .modules(modules)
                .buildApi(NovaApi.class);

        neutronApi=ContextBuilder.newBuilder(providerNeutron)
                .endpoint("http://140.124.184.204/identity/v2.0/")
                .credentials(identity, credential)
                .modules(modules)
                .buildApi(NeutronApi.class);

        regionNeutron = neutronApi.getConfiguredRegions();
        regions = novaApi.getConfiguredRegions();
    }


    //Image


    public String getImageNameById(String imageId){
        String name=null;
        for (String region : regions) {
            ImageApi imageApi=novaApi.getImageApi(region);
            name=imageApi.get(imageId).getName();
        }
        return name;
    }
    public String getImageStatusById(String imageId){
        String status=null;
        for (String region : regions) {
            ImageApi imageApi=novaApi.getImageApi(region);
            status=imageApi.get(imageId).getStatus().value();
        }
        //System.out.println(status);
        return status;
    }

    public String getImageCreatedTimeById(String imageId){
        String createdTime=null;
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm");
        for (String region : regions) {
            ImageApi imageApi=novaApi.getImageApi(region);
            createdTime=dateFormat.format(imageApi.get(imageId).getCreated());
        }
        System.out.println(createdTime);
        return createdTime;
    }

    public String getImageUpdatedTimeById(String imageId){
        String updatedTime=null;
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm");
        for (String region : regions) {
            ImageApi imageApi=novaApi.getImageApi(region);
            updatedTime=dateFormat.format(imageApi.get(imageId).getUpdated());
        }
        System.out.println(updatedTime);
        return updatedTime;
    }

    public int getImageMinRamById(String imageId){
        int minRam=0;
        for (String region : regions) {
            ImageApi imageApi=novaApi.getImageApi(region);
            minRam=imageApi.get(imageId).getMinRam();
        }
        System.out.println(minRam);
        return minRam;
    }

    public int getImageMinDiskById(String imageId){
        int minDisk=0;
        for (String region : regions) {
            ImageApi imageApi=novaApi.getImageApi(region);
            minDisk=imageApi.get(imageId).getMinDisk();
        }
        System.out.println(minDisk);
        return minDisk;
    }
    //Server
    public ArrayList getImagesNameOfServers(){
        ArrayList imagesNameOfServers=new ArrayList();
        String id;
        String name;
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);
            List<? extends Server> servers=serverApi.listInDetail().concat().toList();
            for (Server server : servers) {
                id=server.getImage().getId();
                name=getImageNameById(id);
                imagesNameOfServers.add(name);
            }
        }
        return imagesNameOfServers;
    }

    public ArrayList getFlavorsNameOfServers(){
        ArrayList flavorsNameOfServers=new ArrayList();
        String id;
        String name;
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);
            List<? extends Server> servers=serverApi.listInDetail().concat().toList();
            for (Server server : servers) {
                id=server.getFlavor().getId();
                name=getFlavorNameById(id);
                flavorsNameOfServers.add(name);
            }
        }
        return flavorsNameOfServers;
    }
    public String getServerNameById(String serverId){
        String name=null;
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);
            name=serverApi.get(serverId).getName();
        }
        //System.out.println(name);
        return name;
    }

    public String getServerStatusById(String serverId){
        String status=null;
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);
            status=serverApi.get(serverId).getStatus().value();
        }
        //System.out.println(status);
        return status;
    }

    public String getServerAddressById(String serverId){
        String ip=null;
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);
            ip=serverApi.get(serverId).getAddresses().get("media_net").iterator().next().getAddr();
        }
        //System.out.println(ip);
        return ip;
    }

    public String getServerCreatedDateById(String serverId){
        String time=null;
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm");
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);
            time=dateFormat.format(serverApi.get(serverId).getCreated());
        }
        //System.out.println(time);
        return time;
    }

    public String getServerUpdateDateById(String serverId){
        String time=null;
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm");
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);
            time=dateFormat.format(serverApi.get(serverId).getUpdated());
        }
        //System.out.println(time);
        return time;
    }
//Flavor
    public String getFlavorNameById(String flavorId)
    {
        String name=null;
        for (String region : regions) {
            FlavorApi flavorApi=novaApi.getFlavorApi(region);
            name=flavorApi.get(flavorId).getName();
        }
        System.out.println(name);
        return name;
    }

    public void stopServer(String id){
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);

            System.out.println("Servers in " + region);
            System.out.println("stopServer:" +id);
            serverApi.stop(id);
        }
    }

    public void startServer(String id){
        for (String region : regions) {
            ServerApi serverApi = novaApi.getServerApi(region);

            System.out.println("Servers in " + region);
            System.out.println("startServer:" +id);
            serverApi.start(id);
        }
    }

    public void softRebootServer(String id){
        for (String region:regions){
            ServerApi serverApi = novaApi.getServerApi(region);

            serverApi.reboot(id,RebootType.SOFT);
        }
    }

    public int getFlavorRamById(String flavorId)
    {
        int ram = 0;
        for (String region : regions) {
            FlavorApi flavorApi=novaApi.getFlavorApi(region);
            ram=flavorApi.get(flavorId).getRam();
        }
        //System.out.println(ram);
        return ram;
    }

    public int getFlavorVCpuById(String flavorId)
    {
        int vcpu = 0;
        for (String region : regions) {
            FlavorApi flavorApi=novaApi.getFlavorApi(region);
            vcpu=flavorApi.get(flavorId).getVcpus();
        }
        //System.out.println(vcpu);
        return vcpu;
    }

    public int getFlavorDiskById(String flavorId)
    {
        int disk = 0;
        for (String region : regions) {
            FlavorApi flavorApi=novaApi.getFlavorApi(region);
            disk=flavorApi.get(flavorId).getDisk();
        }
        //System.out.println(disk);
        return disk;
    }



//neutron
    public List<Network> getNetworks(){
        List<Network> networks=null;
        for (String region : regionNeutron) {
            NetworkApi networkApi=neutronApi.getNetworkApi(region);
            networks=networkApi.list().concat().toList();
        }
        return networks;
    }

    public List<Router> getRouters(){
        List<Router> routers=null;
        for (String region : regionNeutron) {
            Optional<? extends RouterApi> routerApiExtension =neutronApi.getRouterApi(region);
            if(routerApiExtension.isPresent()){
                RouterApi routerApi = routerApiExtension.get();
                routers=routerApi.list().concat().toList();
            }
        }
        return routers;
    }

    public List<Image> getImages(){
        List<Image> images=null;
        for (String region : regions) {
            ImageApi imageApi=novaApi.getImageApi(region);
            images=imageApi.listInDetail().concat().toList();
        }
        return images;
    }

    public List<Server> getServers(){
        List<Server> servers=null;
        for (String region : regionNeutron) {
            ServerApi serverApi = novaApi.getServerApi(region);
            servers=serverApi.listInDetail().concat().toList();
        }
//        for(int i=0;i<servers.size();i++){
//            System.out.println(servers.get(i).getName());
//        }
        return servers;
    }

    public List<Flavor> getFlavors(){
        List<Flavor> flavors=null;
        for (String region : regions) {
            FlavorApi flavorApi=novaApi.getFlavorApi(region);
            flavors=flavorApi.listInDetail().concat().toList();
        }
        return flavors;
    }
    public void close() throws IOException {
        Closeables.close(novaApi, true);
    }
}
