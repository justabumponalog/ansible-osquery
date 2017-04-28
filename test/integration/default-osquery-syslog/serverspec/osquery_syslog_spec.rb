require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/var/log/osquery_syslog-prog.log') do
  it { should be_file }
  its(:content) { should match /osqueryd: osqueryd started \[version=/ }
  its(:content) { should match /scheduler.cpp:74\] Executing scheduled query system_info:/ }
  its(:content) { should_not match /Rocksdb open failed \(5:0\) IO error:/ }
  its(:content) { should_not match /osqueryd initialize failed: Could not initialize database/ }
end
describe file('/var/log/osquery_syslog-results.log') do
  it { should be_file }
  its(:content) { should match /hostIdentifier/ }
  its(:content) { should match /pack/ }
  its(:content) { should match /message=Executing scheduled query system_info:/ }
  its(:content) { should_not match /kernel: Cannot access \/dev\/osquery/ }
end
