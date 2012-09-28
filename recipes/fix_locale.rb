execute :fix_locale do
	command 'export LANGUAGE=en_NG.UTF-8'
	command 'export LANG=en_NG.UTF-8'
	command 'export LC_ALL=en_NG.UTF-8'
	command 'locale-gen en_NG.UTF-8'
	command 'sudo dpkg-reconfigure locales'
end