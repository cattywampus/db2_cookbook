#
# Cookbook Name:: db2
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe "db2::_prerequisites"

db2_install "default server install" do
  binary_url node['db2']['zip']['url']
end
