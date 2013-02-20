class User < ActiveRecord::Base
  rolify
  attr_accessible :email, :first_name, :last_name, :login, :status

  has_and_belongs_to_many :projects
  has_and_belongs_to_many :labs, join_table: 'labs_principles'

  def name
    first_name + " " + last_name
  end  

  def self.ldap_search(query)
    query = query << "*"
    ldap = Net::LDAP.new(:host => "directory.yale.edu", :port => 389)
    filter_id = Net::LDAP::Filter.eq("uid", query)
    filter_givenname = Net::LDAP::Filter.eq("givenname", query)
    filter_sn = Net::LDAP::Filter.eq("sn", query)
    filter_title = Net::LDAP::Filter.eq("title", "*Prof*")
    filter = (filter_id | filter_givenname | filter_sn) & filter_title
    attrs = [ "givenname", "sn", "uid", "mail"]
    result = ldap.search(:base => "ou=People,o=yale.edu", :filter => filter, :attributes => attrs)

    unless result.empty?
      results = []
      i = 0
      while i < result.length
        results[i] = {
                        :first_name  => result[i][:givenname][0],
                        :last_name   => result[i][:sn][0],
                        :login       => result[i][:uid][0],
                        :email       => result[i][:mail][0],
                      }
        i = i + 1
      end
      return results
    end
  end 
end
