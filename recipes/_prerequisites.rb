#
# Cookbook Name:: db2
# Recipe:: _prerequisites
#

package 'Archive Tools' do
  package_name %w(tar gzip)
end

package 'pam.i686'
package 'pam.x86_64'
package 'numactl'
package 'libstdc++.i686'
package 'libstdc++.x86_64'
package 'libaio'
package 'ksh'

# package 'DB2 System Requirements' do
#   package_name [
#     'pam.i686',
#     'pam.x86_64',
#     'numactl',
#     'libstdc++.i686',
#     'libstdc++.x86_64',
#     'libaio',
#     'ksh'
#   ]
#   action :install
# end
