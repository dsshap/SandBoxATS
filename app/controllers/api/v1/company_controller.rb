class Api::V1::CompanyController < ApplicationController
	
#	respond_to :json, :text
	def listings
		
		return render :json => {"error_code"=> 01, "error_msg"=> "missing company name."} if params[:name].nil?		
		
		if params[:name] == 'all'
			return render :json => {:ats => {:companies => Company.all}}
		else
			company = Company.where(name: params[:name]).first
			return render :json => {"error_code"=> 02, "error_msg"=> "company not found. Please check your company name and token."} if company.nil?
		end

		
		render :json => company
		
		# respond_to do |format|
		# 	format.json { render :json => company}
		# 	format.text { render :text => company}
		# end
	end
	
	def listing
		return render :json => {"error_code"=> 01, "error_msg"=> "missing company name."} if params[:name].nil?	
		return render :json => {"error_code"=> 03, "error_msg"=> "missing job id."} if params[:job_id].nil?	
		
		
		company = Company.where(name: params[:name]).first
		return render :json => {"error_code"=> 02, "error_msg"=> "company not found. Please check your company name."} if company.nil?
		
		job = company.job_listings.where(_id: params[:job_id]).first
		return render :json => {"error_code"=> 04, "error_msg"=> "job not found. Please check your job id."} if job.nil?
		return render :json => {"error_code"=> 05, "error_msg"=> company.name+" is no longer searching for this position."} if job.status != 'Active'
		
		listing = ApiJobListing.new(job.id, job.title, job.description, job.email, job.city, job.state, job.created_at, company.name, company.url, company.city, company.state)
		return render :json => {:ats => {:job_listing => listing}}

		
		
	end
	
	
end