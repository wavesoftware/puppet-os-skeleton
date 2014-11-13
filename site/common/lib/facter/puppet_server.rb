# A fact to get puppet master server information
Facter.add(:puppet_server) do
  setcode do
    cmd = 'puppet config print server --section agent'
    begin
      server = Facter::Util::Resolution.exec(cmd).chomp
    rescue Exception => e
      server = 'puppet'
    end
    server
  end
end