# frozen_string_literal: true

user = node['user']
home = node['home']
mise_bin = "#{home}/.local/bin/mise"
mise_config = "#{home}/.config/mise/config.toml"
user_path = "#{home}/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

raise 'node["user"] is required' if user.nil? || user.empty?
raise 'node["home"] is required' if home.nil? || home.empty?

directory "#{home}/.local/bin" do
  owner user
  mode '755'
end

execute 'install mise' do
  user user
  command "env HOME='#{home}' USER='#{user}' PATH='#{user_path}' curl -fsSL https://mise.run | sh"
  not_if "test -x #{mise_bin}"
end

execute 'mise install tools' do
  user user
  command "env HOME='#{home}' USER='#{user}' PATH='#{user_path}' MISE_GLOBAL_CONFIG_FILE='#{mise_config}' '#{mise_bin}' install"
  only_if "test -f #{mise_config}"
end
