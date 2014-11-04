Facter.add(:puppet_agent_lock) do
  setcode do
    vardir = Facter.value :puppet_vardir
    lock = "#{vardir}/state/agent_disabled.lock"
    not File.exists? lock
  end
end