require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('osqueryd'), :if => (os[:family] == 'ubuntu' && os[:release] != '16.04') || (os[:family] == 'redhat' && os[:release] != '7') do
  it { should be_enabled }
end
describe service('osqueryd') do
  it { should be_running }
end

describe file('/usr/bin/osqueryd') do
  it { should be_executable }
end
describe file('/usr/bin/osqueryi') do
  it { should be_executable }
end

describe file('/etc/osquery/osquery.conf') do
  it { should contain '"config_plugin":' }
  it { should contain '"packs": {' }
end

describe process("osqueryd") do
  its(:user) { should eq "root" }
  its(:args) { should match /--config_path=\/etc\/osquery\/osquery.conf --pidfile=\/var\/run\/osqueryd.pid/ }
end

describe file('/var/log/osquery/osqueryd.INFO') do
  it { should be_symlink }
  its(:content) { should match /Log line format:/ }
end
describe file('/var/log/osquery/osqueryd.WARNING') do
  it { should be_symlink }
  its(:content) { should match /Log line format:/ }
end
describe file('/var/log/osquery/osqueryd.results.log') do
  it { should be_file }
  its(:content) { should match /hostIdentifier/ }
end
