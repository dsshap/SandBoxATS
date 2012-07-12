class ApiJobListing

	def initialize(id, title, description, email, city, state, posted_date, company, company_url, company_city, company_state)
		@id = id
		@company = company
		@company_url = company_url
		@company_city = company_city
		@company_state = company_state
		@title = title
		@description = description
		@email = email
		@city = city
		@state = state
		@posted_date = posted_date
	end
end