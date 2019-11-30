require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/var/log/osquery/osqueryd.results.log') do
  it { should contain '"system_info",' }
  it { should contain '"physical_memory":' }
  it { should contain '"target_path":"\/etc\/testing-big-file"' }
  it { should contain '"target_path":"\/etc\/testing-aa"' }
  it { should contain '"target_path":"\/etc\/testing-hh' }
  it { should contain '"action":"CREATED"' }
  it { should contain '"action":"UPDATED"' }
  it { should contain '"action":"DELETED"' }
#  it { should_not contain '"target_path":"\/tmp\/' }
#  it { should_not contain '"target_path":"\/var\/' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events\/testing-aa' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events\/testing-hh' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events2\/test\/testing-aa' }
end
