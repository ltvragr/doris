module LDAP
   CONFIG = {
   :auth_provider => "CAS",
   :ldap_host => "directory.yale.edu",
   :ldap_port => 389,
   :ldap_login => "uid",
   :ldap_base_query => "ou=People,o=yale.edu",
   :ldap_first_name => "givenname",
   :ldap_last_name => "sn",
   :ldap_phone => "telephoneNumber",
   :ldap_email => "mail"
  }

    def search_ldap(login)
      ldap = Net::LDAP.new(:host => LDAP::CONFIG[:ldap_host], :port => LDAP::CONFIG[:ldap_port])
      
      filter = Net::LDAP::Filter.eq(LDAP::CONFIG[:ldap_login], login)
      
      attrs = [LDAP::CONFIG[:ldap_login], LDAP::CONFIG[:ldap_first_name], LDAP::CONFIG[:ldap_last_name], 
               LDAP::CONFIG[:ldap_phone], LDAP::CONFIG[:ldap_email]]
      
      result = ldap.search(:base => LDAP::CONFIG[:ldap_base_query], :filter => filter, :attributes => attrs)
      
      unless result.empty?
      return { :first_name  => result[0][LDAP::CONFIG[:ldap_first_name].to_sym][0],
               :last_name   => result[0][LDAP::CONFIG[:ldap_last_name].to_sym][0],
               :login       => result[0][LDAP::CONFIG[:ldap_login].to_sym][0],
               :email       => result[0][LDAP::CONFIG[:ldap_email].to_sym][0] 
             }
      end
  end

end