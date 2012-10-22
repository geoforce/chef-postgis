#
# Cookbook Name:: postgis
# Recipe:: default
#
# Copyright 2012, prog-web.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install postGIS 1.5

package 'libxml2'
package 'libxml2-dev'
package 'proj'
package 'libgdal1-dev'

#include_recipe 'gdal'
include_recipe 'postgis::geos'
#include_recipe 'proj' 

include_recipe "postgis::fix_locale"
# postgresql client and server
include_recipe "postgresql::server"
include_recipe "postgresql::server_debian"

package "postgresql-server-dev-9.1"

# install support packages
include_recipe "postgis::install_support_packages"

# install support packages
include_recipe "postgis::install_postgis"

# create db template
#include_recipe "postgis::create_db_template"

# initialise db template
#include_recipe "postgis::initialise_db_template"
