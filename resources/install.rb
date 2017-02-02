property :install_path, String, default: '/opt/ibm/db2'
property :binary_url, String, default: nil
property :binary_checksum, String, default: nil

# Installation Response file configuration
property :product_type, String, default: 'DB2_SERVER_EDITION'
property :install_type, String, default: 'CUSTOM'

action :install do
  require 'tmpdir'

  binary_uri = ::URI.parse(binary_url)
  binary_filename = ::File.basename(binary_uri.path)

  if binary_filename !~ /\.tar\.gz$/
    raise "DB2 package #{binary_filename} is archived in an unsupported format"
  end

  tmp_path = Dir.mktmpdir('db2_installer', Chef::Config['file_cache_path'])

  begin
    directory tmp_path

    local_binary = ::File.join(tmp_path, binary_filename)
    remote_file local_binary do
      source binary_url
      checksum binary_checksum
    end

    execute "extract #{binary_filename}" do
      cwd tmp_path
      command "tar -xzvf #{local_binary} --strip-components=1"
    end

    template ::File.join(tmp_path, "db2_install.rsp") do
      source "response_file.erb"
      variables(
        install_dir: install_path,
        install_type: install_type,
        product_type: product_type
      )
    end

    execute 'install db2' do
      cwd tmp_path
      command './db2setup -r db2_install.rsp'
    end
  ensure
    directory "cleaning up #{tmp_path}" do
      action :delete
    end
  end

end

