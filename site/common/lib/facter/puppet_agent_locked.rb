Facter.add(:puppet_agent_locked) do
  setcode do
    vardir = Facter.value :puppet_vardir
    lock = "#{vardir}/state/agent_disabled.lock"
    File.exists? lock
  end
end