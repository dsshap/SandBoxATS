class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name,              :type => String
  field :city,              :type => String
  field :state,             :type => String
  field :url,               :type => String, :null => false, :default => "http://"
	field :access_token,			:type => String
  
  has_and_belongs_to_many :admin_users
	has_and_belongs_to_many :job_listings
  attr_accessible :name, :city, :url, :state, :admin_users_attributes, :job_listings_attributes
	accepts_nested_attributes_for :admin_users, :job_listings, :allow_destroy => true
  validates_presence_of :name, :city, :url, :state
  before_create :create_token
	
  def create_token
		o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
		self.access_token  =  (0..30).map{ o[rand(o.length)]  }.join;
  end

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
		 super(options.merge(:include => {:job_listings => { :only => [:_id, :title, :description, :email, :city, :state]}}, :except => [:_id, :created_at, :updated_at, :job_listing_ids, :admin_user_ids])) 
	end
	

  
end