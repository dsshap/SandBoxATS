class CompanyController < ApplicationController
	
#	respond_to :json, :text
	def listings
		
		return render :json => {"error_code"=> 01, "error_msg"=> "missing company name."} if params[:name].nil?		
		return render :json => {"error_code"=> 02, "error_msg"=> "missing token."} if params[:token].nil?
		
		company = Company.where(name: params[:name], access_token: params[:token]).first
		return render :json => {"error_code"=> 03, "error_msg"=> "company not found. Please check your company name and token."} if company.nil?

		
		render :json => company
		
		# respond_to do |format|
		# 	format.json { render :json => company}
		# 	format.text { render :text => company}
		# end
	end
end