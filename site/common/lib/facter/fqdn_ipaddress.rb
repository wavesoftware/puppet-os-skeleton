# Fact that gets ipaddress of FQDN
Facter.add(:fqdn_ipaddress) do
  setcode do
  	require 'resolv'
    fqdn = Facter.value :fqdn
    begin
    	res = Resolv::DNS.open { |dns| dns.getresources fqdn, Resolv::DNS::Resource::IN::A }
    	ip = res.map { |r| r.address }[0]
    	ip.to_s
    rescue
    	begin
    		Resolv.getaddress fqdn
    	rescue
    		nil
    	end
    end
  end
end