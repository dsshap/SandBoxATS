class JobListing
  include Mongoid::Document
  include Mongoid::Timestamps

	field :title, 						type: String
	field :description, 			type: String
	field :email,							type: String
	field :city,							type: String
	field :state,							type: String
	
	field :status,						type: String, :default => 'Active'
	
	field :google_analytics,		type: String
	
	has_and_belongs_to_many :companies
	validates_presence_of :title, :description, :email
	attr_accessible :title, :description, :email, :city, :state, :status, :google_analytics, :companies_attributes
	accepts_nested_attributes_for :companies

	def companies_attributes=(str)
		str.each do |key, value|
			comapny = Company.where(name: str[key]['name']).first
      self.companies.push(comapny) 
   		self.save

			if str[key]["_destroy"] == "1"
        self.comapnies.delete(admin)
				company.job_listings.delete(self)
      end
    end
	end

end