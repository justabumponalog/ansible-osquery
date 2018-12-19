require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('auditd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe command('auditctl -s') do
  its(:stdout) { should_not match /enable 0/ }
  its(:stderr) { should match /^$/ }
  its(:exit_status) { should eq 0 }
end

# Following tests can't be validated inside a container (docker, lxd), need full VM
if ENV['SERVERSPEC_OSQUERY_AUDITD']
  describe command('auditctl -l') do
    its(:stdout) { should match /-a always,exit -S read/ }
    its(:stdout) { should match /-a always,exit -S write/ }
    its(:stdout) { should match /-a always,exit -S clone/ }
    its(:stdout) { should match /-a always,exit -S bind/ }
    its(:stderr) { should match /^$/ }
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/osquery/osqueryd.results.log') do
    its(:content) { should match /{"name":"process_events","hostIdentifier":/ }
    its(:content) { should match /{"name":"socket_events","hostIdentifier":/ }
    its(:content) { should match /{"name":"fim","hostIdentifier":/ }
  end
end
