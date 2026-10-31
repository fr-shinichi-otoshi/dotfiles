# frozen_string_literal: true

execute 'apt-get update' do
  command 'DEBIAN_FRONTEND=noninteractive apt-get update'
end

%w[
  ca-certificates
  curl
  git
  git-lfs
].each do |name|
  package name do
    action :install
  end
end
