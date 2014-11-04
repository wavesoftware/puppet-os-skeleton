Facter.add(:puppet_vardir) do
  setcode do
    cmd = 'puppet config print vardir'
    begin
      dir = Facter::Util::Resolution.exec(cmd).chomp
    rescue Exception => e
      dir = nil
    end
    dir
  end
end