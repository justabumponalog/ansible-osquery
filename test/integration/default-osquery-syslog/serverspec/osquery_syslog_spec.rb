require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/var/log/osquery_syslog-prog.log'), :if => (host_inventory['virtualization'][:system] != 'docker') do
  it { should be_file }
#  its(:content) { should match /osqueryd: osqueryd started \[version=/ }
  its(:content) { should match /system_info/ }
  its(:content) { should match /Storing initial results for new scheduled query:/ }
  its(:content) { should_not match /Rocksdb open failed \(5:0\) IO error:/ }
  its(:content) { should_not match /osqueryd initialize failed: Could not initialize database/ }
end
describe file('/var/log/osquery_syslog-results.log'), :if => (host_inventory['virtualization'][:system] != 'docker') do
  it { should be_file }
  its(:content) { should match /hostIdentifier/ }
#  its(:content) { should match /pack/ }
#  its(:content) { should match /{"name":"system_info","hostIdentifier"/ }
  its(:content) { should_not match /kernel: Cannot access \/dev\/osquery/ }
  let(:sudo_options) { '-u root -H' }
end

describe command('journalctl -l'), :if => (host_inventory['virtualization'][:system] != 'docker') do
  its(:stdout) { should match /osqueryd/ }
#  its(:stdout) { should match /system_info/ }
  its(:stdout) { should match /Storing initial results for new scheduled query:/ }
  its(:stdout) { should match /hostIdentifier/ }
  its(:exit_status) { should eq 0 }
end
