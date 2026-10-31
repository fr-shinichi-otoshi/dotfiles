# frozen_string_literal: true

user = node['user']
home = node['home']
bashrc = "#{home}/.bashrc"
marker = '# dotfiles-mise-activate'
helper = '/tmp/dotfiles-ensure-mise-bashrc.sh'

directory home do
  owner user
  mode '755'
end

file helper do
  owner user
  mode '755'
  content <<~SH
    #!/bin/bash
    set -euo pipefail
    bashrc=#{bashrc.inspect}
    marker=#{marker.inspect}
    if [ -f "${bashrc}" ] && grep -qxF "${marker}" "${bashrc}"; then
      exit 0
    fi
    if [ -f "${bashrc}" ] && [ -s "${bashrc}" ]; then
      printf '\\n' >> "${bashrc}"
    fi
    cat >> "${bashrc}" <<'EOF'
    # dotfiles-mise-activate
    if [ -x "$HOME/.local/bin/mise" ]; then
      eval "$("$HOME/.local/bin/mise" activate bash)"
    fi
    EOF
  SH
end

execute 'ensure mise activate in bashrc' do
  user user
  command "/bin/bash #{helper}"
end
