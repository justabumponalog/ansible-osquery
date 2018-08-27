require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/var/log/osquery/osqueryd.results.log') do
  it { should contain '"system_info",' }
  it { should contain '"physical_memory":' }
  it { should contain '"target_path":"\/etc\/testing-big-file"' }
  it { should contain '"target_path":"\/etc\/testing-aa"' }
  it { should contain '"target_path":"\/etc\/testing-zz' }
# for some reason, this one requires two slashes (root fim rule)
  it { should contain '"target_path":"\/\/fim-testing1' }
  it { should contain '"target_path":"\/root\/fim-testing2' }
  it { should contain '"target_path":"\/lib\/fim-testing3' }
  it { should contain '"target_path":"\/usr\/bin\/fim-testing4' }
  it { should contain '"action":"CREATED"' }
  it { should contain '"action":"UPDATED"' }
  it { should contain '"action":"DELETED"' }
  it { should_not contain '"target_path":"\/tmp\/' }
  it { should_not contain '"target_path":"\/var\/' }
end
