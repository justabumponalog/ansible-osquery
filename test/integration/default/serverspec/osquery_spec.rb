require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('osqueryd') do
  it { should be_enabled }
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

describe file('/var/log/osquery/osqueryd.results.log') do
  it { should be_file }
end
describe file('/var/log/osquery/osqueryd.INFO') do
  it { should be_symlink }
end
