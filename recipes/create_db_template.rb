execute :create_postgis_template do
	user "postgres"
	command "createdb -E UTF8 #{node[:postgis][:template_name]} -T template0"
	not_if "psql -qAt --list | grep '^#{node[:postgis][:template_name]}\|'", :user => 'postgres'
	action :run
end