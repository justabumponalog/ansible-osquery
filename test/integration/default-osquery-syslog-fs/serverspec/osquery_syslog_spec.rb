require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/var/log/osquery_syslog-prog.log') do
  it { should be_file }
  its(:content) { should match /osqueryd: osqueryd started \[version=/ }
end
describe file('/var/log/osquery_syslog-results.log') do
  it { should be_file }
  its(:content) { should match /hostIdentifier/ }
  its(:content) { should match /pack/ }
  its(:content) { should_not match /kernel: Cannot access \/dev\/osquery/ }
end
