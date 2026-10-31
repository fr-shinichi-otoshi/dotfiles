# frozen_string_literal: true

execute 'apt-get update' do
  command 'DEBIAN_FRONTEND=noninteractive apt-get update'
end

%w[
  ca-certificates
  curl
  git
  git-lfs
  zsh
  vim
  poppler-utils
  pandoc
].each do |name|
  package name do
    action :install
  end
end
