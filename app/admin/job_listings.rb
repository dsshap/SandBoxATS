ActiveAdmin.register JobListing do
	
	index do
		column :title do |job|
			link_to job.title, admin_job_listing_path(job)
		end
		column :category
		column :job_type
		column :status do |job|
			if job.status == "Active"
		  	status_tag("Actively Searching", :ok)
      end
			if job.status == "Interviewing"
      	status_tag("Interviewing", :warning)
      end
			if job.status == "Hired"
      	status_tag("Hired", :error)
      end
		end
		column :email
		column :city
		column :state
		column "Companies" do |job|
			array = Array.new
				job.companies.each do |company|
					array.push(company.name)
				end
				array.to_s
		end
		default_actions
	end
	
	show :title => :title do
  	panel "Job Listing Details" do
    	attributes_table_for job_listing do
				row :title
				row :category
				row :job_type
				row('Description'){
					job_listing.description.html_safe
				} 
				row	:email
				row :city
				row :state
				row('Status'){
					if job_listing.status == "Active"
				  	status_tag("Actively Searching", :ok)
		      end
					if job_listing.status == "Interviewing"
		      	status_tag("Interviewing", :warning)
		      end
					if job_listing.status == "Hired"
		      	status_tag("Hired", :error)
		      end
				}
				row :google_analytics
				row("Companies"){
					array = Array.new
					job_listing.companies.each do |comp|
						array.push(comp.name)
					end
					array.to_s
				}
			end
		end
	end
	
	form do |f|
		f.inputs do
  		f.input :title
			f.input :category, :as => :select, :collection => Category.collection.distinct('name')
			f.input :job_type, :as => :select, :collection => ["Full-Time", "Part-Time", "Contractor", "Intern"]
			f.input :description, :as => :text, :input_html => { :class => 'autogrow', :rows => 40}
			f.input :email
			f.input :city
			f.input :state
			f.input :status, :as => :select, :collection => ["Active", "Interviewing", "Hired"]
		end
		f.inputs do
    	f.has_many :companies do |company|
				if company.object.created_at
          company.input :_destroy, :as => :boolean, :label => "Delete"
        end
				company.input :name, :as => :select, :collection => Company.collection.distinct('name')
			end
		end
		f.buttons
	end

end
