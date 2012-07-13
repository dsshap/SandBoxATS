class JobListing
  include Mongoid::Document
  include Mongoid::Timestamps

	field :title, 						type: String
	field :job_type,					type: String
	field :category,					type: String
	field :description, 			type: String, :default =>  '<h2>Overview</h2>
																												<p>&lt;Description...&gt;</p>
																												<hr />
																												<h3>Responsibilities</h3>
																												<ul>
																												<li>1st responsibility</li>
																												<li>2nd responsibility</li>
																												</ul>
																												<hr />
																												<h3>Qualifications</h3>
																												<ul>
																												<li>1st requirement</li>
																												<li>2nd requirement</li>
																												</ul>
																												<hr />
																												<h3>Benefits of working here</h3>
																												<p>&lt;About the company...&gt;</p>
																												<hr />
																												<h3>Compensation</h3>
																												<p>Based on experience.</p>
																												<hr />
																												<h3>How to Apply</h3>
																												<p>&lt;Instructions on how to apply...&gt;</p>'
	field :email,							type: String
	field :city,							type: String
	field :state,							type: String
	field :category,					type: String
	
	field :status,						type: String, :default => 'Active'
	
	field :google_analytics,		type: String
	
	has_and_belongs_to_many :companies
	validates_presence_of :title, :description, :email
	attr_accessible :title, :description, :email, :city, :state, :status, :google_analytics, :companies_attributes, :category, :job_type
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
	
	def as_json(options={})
		 super(options.merge(:only => [:_id, :title, :job_type, :category, :description, :email, :city, :state, :google_analytics, :created_at])) 
		
		# hash = {
		# 	_id: self._id,
		# 	title: self.title,
		# 	job_type: self.job_type,
		# 	category: self.category,
		# 	description: self.description,
		# 	email: self.email,
		# 	city: self.city,
		# 	state: self.state,
		# 	google_analytics: self.google_analytics
		# 	
		# }
	end

end