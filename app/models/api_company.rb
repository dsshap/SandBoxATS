class ApiCompany
	@job_listings = Array.new
	
	def initialize(name, city, state, url, jobs)
		@name = name
		@city = city
		@state = state
		@url = url
		@job_listings = []
		
		
	
		jobs.each do |job|
			@job_listings.push(ApiJobListing.new(job.id, job.title, job.description, job.email, job.city, job.state, job.created_at, nil, nil, nil, nil))
		end
	end
	
end