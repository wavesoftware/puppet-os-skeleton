# Fact that guess node type from it's hostname
Facter.add(:guess_type) do
  setcode do
    hostname = Facter.value :hostname
    hostname.gsub /[_-]?[0-9]+$/, ''
  end
end