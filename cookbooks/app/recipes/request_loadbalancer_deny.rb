#
# Cookbook Name:: app
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rs_utils_marker :begin

VHOST_NAMES = node[:lb][:vhost_names]

VHOST_NAMES.gsub(/\s+/, "").split(",").each do | each_vhost |
  sys_firewall "Request all appservers close ports to this loadbalancer" do
    machine_tag "loadbalancer:#{each_vhost}=app"
    port node[:app][:port]
    enable false
    ip_addr node[:cloud][:private_ips][0]
    action :update_request
  end
end

rs_utils_marker :end
