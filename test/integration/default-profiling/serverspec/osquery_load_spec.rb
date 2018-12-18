require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/var/log/osquery/osqueryd.results.log') do
  it { should contain '"system_info",' }
  it { should contain '"physical_memory":' }
  it { should contain '"target_path":"\/etc\/testing-big-file"' }
  it { should contain '"target_path":"\/etc\/testing-aa"' }
  it { should contain '"target_path":"\/etc\/testing-hh' }
# for some reason, this one requires two slashes (root fim rule)
  it { should contain '"target_path":"\/\/fim-testing1' }
  it { should contain '"target_path":"\/root\/fim-testing2' }
  it { should contain '"target_path":"\/lib\/fim-testing3' }
  it { should contain '"target_path":"\/usr\/bin\/fim-testing4' }
  it { should contain '"target_path":"\/usr\/bin\/.fim-testing5' }
  it { should contain '"action":"CREATED"' }
  it { should contain '"action":"UPDATED"' }
  it { should contain '"action":"DELETED"' }
#  it { should_not contain '"target_path":"\/tmp\/' }
  it { should_not contain '"target_path":"\/var\/' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events\/testing-aa' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events\/testing-hh' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events2\/test\/testing-aa' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events\/fim-testing1' }
  it { should contain '"target_path":"\/tmp\/too_many_events\/a\/fim-testing2' }
  it { should contain '"target_path":"\/tmp\/too_many_events\/a\/b\/fim-testing3' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events2\/fim-testing1' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events2\/a\/fim-testing2' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events2\/a\/b\/fim-testing3' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events3\/fim-testing1' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events3\/a\/fim-testing2' }
  it { should_not contain '"target_path":"\/tmp\/too_many_events3\/a\/b\/fim-testing3' }
  it { should_not contain '"target_path":"\/tmp\/excluded1-abcdef' }
  it { should_not contain '"target_path":"\/tmp\/abcdef-excluded2' }
  it { should_not contain '"target_path":"\/tmp\/excluded3-abcdef-testing' }
  it { should_not contain '"target_path":"\/tmp\/excluded4-abcdef-testing-ghijkl-testing-mnopqr' }
  it { should_not contain '"target_path":"\/tmp\/excluded5-exact-match' }
  it { should_not contain '"target_path":"\/tmp\/excluded6-abcdef' }
  it { should_not contain '"target_path":"\/tmp\/excluded6-testing\/excluded-abcdef' }
end
