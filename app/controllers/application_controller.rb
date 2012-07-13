class ApplicationController < ActionController::Base
  protect_from_forgery
	include HTTParty
  base_uri ENV['api_uri']
	default_params :token => ''

	def show
		auth = {:username => "sandbox", :password => "sandbox"}
		get = self.class.get('/api/v1/company/all', :basic_auth => auth)
		@result = JSON.parse(get.body)
	end
	
	def job
		auth = {:username => "sandbox", :password => "sandbox"}
		get = self.class.get('/api/v1/company/'+params[:name]+'/'+params[:job_id], :basic_auth => auth)
		@result = JSON.parse(get.body)
	end
	
	
end
