# A Puppet environment
Facter.add(:environment) do
  setcode do
  	require 'puppet'
    Puppet[:environment]
  end
end
