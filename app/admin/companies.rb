ActiveAdmin.register Company do
	#scope_to :current_admin_user
	
	action_item :only => :show do
      link_to("Create New Job Listing", new_admin_job_listing_path)
    end
	
	index do
		column :name do |comp|
			link_to comp.name, admin_company_path(comp)
		end
		column "Job Listings" do |comp|
			comp.job_listings.count
		end
		column :department
		column :city
		column :state
		column :url
		default_actions
	end
	
	show :title => :name do
  	panel "Company Details" do
    	attributes_table_for company do
				row :id
				row :name
				row :department
				row :city
				row :state
				row :url
				row("Admins"){
					array = Array.new
					company.admin_users.each do |admin|
						array.push(admin.email)
					end
					array.to_s
				}
			end
		end
		
		panel "Job Listings" do
			table_for company.job_listings do |job|
				column :title
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
				column :created_at
				column :updated_at	
				column "Actions" do |i|
						link_to("View", admin_job_listing_path(i), :method => :get, :class=> "member_link view_link")+"\t".html_safe+
            link_to("Edit", edit_admin_job_listing_path(i), :class=> "member_link view_link")
          end
			end
		end
	end
	
	form do |f|
		f.inputs do
  		f.input :name
			f.input :department, :as => :select, :collection => Department.collection.distinct('name')
			f.input :city
			f.input :state
			f.input :url
			#f.input :admin_users, :as => :select, :collection => AdminUser.collection.distinct('email')
		end
		f.inputs do
    	f.has_many :admin_users do |company_admin|
				if company_admin.object.created_at
          company_admin.input :_destroy, :as => :boolean, :label => "Delete"
        end
				company_admin.input :email, :as => :select, :collection => AdminUser.collection.distinct('email')
			end
		end
		f.buttons
	end
  
end
