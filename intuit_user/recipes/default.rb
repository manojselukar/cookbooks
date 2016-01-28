#
# Cookbook Name:: intuit_user
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user = node['intuit_user']['user_name']
home_dir = node['intuit_user']['user_default_home']

if home_dir.nil?
  home_dir = "/home/#{user}"
end


user "#{user}" do
  home "#{home_dir}"
  shell "/bin/bash"
end

directory "#{home_dir}" do
  group "#{user}"
  owner "#{user}"
  mode 0755
  recursive true
end

directory "#{home_dir}/.ssh" do
  group "#{user}"
  owner "#{user}"
  mode '0700'
  recursive true
end

template "#{home_dir}/.ssh/authorized_keys" do
  source "user_authorized_keys.erb"
  mode '0600'
end