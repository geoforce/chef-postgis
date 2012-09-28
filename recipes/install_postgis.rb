package "postgresql-9.1-postgis" do
  action :install
  options "--force-yes" # due the workaround to add new repositories, this option is needed to installed the new packages
end
package "checkinstall"
package "libpq-dev"

tarball = "postgis-#{node[:postgis][:version]}.tar.gz"

execute "wget postgis 1.5" do
 tarball_url = "http://postgis.refractions.net/download/#{tarball}"
 cwd "/tmp"
 command "wget #{tarball_url}"
 creates "/tmp/#{tarball}"
 action :run
end

remote_file "/tmp/#{tarball}" do
 source "http://postgis.refractions.net/download/#{tarball}"
 mode "0644"
 checksum "a2334f8b229446c0497d48a430a40152a3b71a5da02f414a0340a0a025d416cf" 
 notifies :run, "bash[install_postgis_#{node[:postgis][:version]}]", :immediately
end

bash "install_postgis_#{node[:postgis][:version]}" do
 not_if "psql -d #{node[:postgis][:template_name]} -c 'SELECT postgis_full_version();' | grep -q '#{node[:postgis][:version]}'" 
 user "root"  
 tar_dir = "/usr/local/src"
 cwd tar_dir
 code <<-EOH
   tar zxf /tmp/#{tarball}
   cd postgis-#{node[:postgis][:version]}/
   ./configure
   make
   make install
   sudo checkinstall --pkgname postgis-#{node[:postgis][:version]} --pkgversion #{node[:postgis][:version]}-src --default) 
   EOH
 command ""
 creates tar_dir + "/postgis-#{node[:postgis][:version]}"
 action :run
end 

# execute "create postgis 1.5 share dir" do  
#  command "mkdir -p '`pg_config --sharedir`/contrib/postgis-#{node[:postgis][:version]}'"
#  creates "'`pg_config --sharedir`/contrib/postgis-#{node[:postgis][:version]}'"
#  action :run
# end


# bash "upgrade to postgis 1.5" do
#   user "root"  
#   code <<-EOH     
#   sudo mkdir -p '`pg_config --sharedir`/contrib/postgis-1.5' 
#   # fetch, compile and install PostGIS
#   wget http://postgis.refractions.net/download/postgis-1.5.3.tar.gz
#   tar zxvf postgis-1.5.3.tar.gz 
#   cd postgis-1.5.3/
#   sudo ./configure
#   sudo make
#   sudo make install
#   sudo checkinstall --pkgname postgis-1.5.3 --pkgversion 1.5.3-src --default 
#   EOH
# end