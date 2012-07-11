ActiveAdmin.register AdminUser do
	index do
		column :email
		column :overlord
		column :current_sign_in_at
		column :last_sign_in_at
		column :sign_in_count
		default_actions
	end
	
	show :title => :email do
  	panel "Admin User Details" do
    	attributes_table_for admin_user do
				row :id
				row :email
				row :reset_password_token
				row :reset_password_sent_at
				row :sign_in_count
				row :overlord
				row("Companies"){
					array = Array.new
					admin_user.companys.each do |company|
						array.push(company.name)
					end
					array.to_s
				}
			end
		end
	end
    
	form do |f|
		f.inputs "Admin Details" do
			f.input :email
			if current_admin_user.overlord
				f.input :overlord, :as => :boolean
			end
		end
		f.buttons
	end

		
end
