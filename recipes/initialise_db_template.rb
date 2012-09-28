execute :load_postgis_sql do
	user "postgres"
	command "psql -d #{node[:postgis][:template_name]} -f `pg_config --sharedir`/contrib/#{node[:postgis][:sql_folder]}/postgis.sql"
	only_if "psql -qAt --list | grep '^#{node[:postgis][:template_name]}\|'", :user => 'postgres'
	action :run
end 

execute :load_spatial_ref_sys_sql do
	user "postgres"
	command "psql -d #{node[:postgis][:template_name]} -f `pg_config --sharedir`/contrib/#{node[:postgis][:sql_folder]}/spatial_ref_sys.sql"
	only_if "psql -qAt --list | grep '^#{node[:postgis][:template_name]}\|'", :user => 'postgres'
	action :run
end