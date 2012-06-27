class Company
  include Mongoid::Document
  include Mongoid::Timestamp
  
  field :name,              :type => String
  field :city,              :type => String
  field :state,             :type => String
  field :url,               :type => String
  field :access_token,      :type => String
  
  belongs_to :admin_user
  
  validates_presence_of :name, :access_token, :city, :url, :state
  
  protected
  def before_validation_on_create
    self.access_token = ActiveSupport::SecureRandom.base64(8).gsub("/","_").gsub(/=+$/,"")
  end
  
end