RSpec::Matchers.define :permit_action do |action|
  match do |policy|
    policy.public_send("#{action}?")
  end

  failure_message do |policy|
    "expected to permit #{action} on #{policy.record} for #{policy.user}"
  end

  failure_message_when_negated do |policy|
    "expected not to permit #{action} on #{policy.record} for #{policy.user}"
  end
end

RSpec::Matchers.define :forbid_action do |action|
  match do |policy|
    !policy.public_send("#{action}?")
  end

  failure_message do |policy|
    "expected to forbid #{action} on #{policy.record} for #{policy.user}"
  end

  failure_message_when_negated do |policy|
    "expected not to forbid #{action} on #{policy.record} for #{policy.user}"
  end
end