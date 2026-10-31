# frozen_string_literal: true

user = node['user']
zsh_path = '/usr/bin/zsh'

raise 'node["user"] is required' if user.nil? || user.empty?

execute 'ensure /usr/bin/zsh is listed in /etc/shells' do
  command "grep -qxF '#{zsh_path}' /etc/shells || printf '%s\\n' '#{zsh_path}' >> /etc/shells"
  only_if "test -x #{zsh_path}"
end

execute 'set login shell to /usr/bin/zsh' do
  command "chsh -s #{zsh_path} #{user}"
  only_if "test -x #{zsh_path}"
  not_if "getent passwd #{user} | cut -d: -f7 | grep -qx #{zsh_path}"
end
