class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name,              :type => String
  field :city,              :type => String
  field :state,             :type => String
  field :url,               :type => String, :null => false, :default => "http://"
	field :department,				:type => String

  
  has_and_belongs_to_many :admin_users
	has_and_belongs_to_many :job_listings
  attr_accessible :name, :city, :url, :state, :admin_users_attributes, :job_listings_attributes, :department
	accepts_nested_attributes_for :admin_users, :job_listings, :allow_destroy => true
  validates_presence_of :name, :city, :url, :state
	validates_uniqueness_of :name
	

	def admin_users_attributes=(str)
		str.each do |key, value|
			admin = AdminUser.where(email: str[key]['email']).first
      self.admin_users.push(admin) 
   		self.save

			if str[key]["_destroy"] == "1"
        self.admin_users.delete(admin)
				admin.companies.delete(self)
      end
    end
	end
	
	def as_json(options={})		
		logger.debug("Options")
		logger.debug(options.to_json)
		
		jobs = self.job_listings.where(status: 'Active')
		hash = {
			name: self.name,
			department: self.department,
			city: self.city,
			state: self.state,
			url: self.url
		}
		
		if(options[:template] == 'listings')
			hash[:job_listings] = jobs
		end
		
		hash
	end
	
end