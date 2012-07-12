class ApplicationController < ActionController::Base
  protect_from_forgery
	include HTTParty
  base_uri 'localhost:3200'
	default_params :token => ''

	def show
		get = self.class.get('/api/v1/company/all', options={})
		@result = JSON.parse(get.body)
	end
	
	def job
		get = self.class.get('/api/v1/company/'+params[:name]+'/'+params[:job_id])
		logger.debug(get)
		@result = JSON.parse(get.body)
	end
	
	
end
