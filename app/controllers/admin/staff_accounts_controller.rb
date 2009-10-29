module Admin
  class StaffAccountsController < BaseController
    before_filter :load_object, :except => [:index]
    
    def index
      @unverified_staff_accounts = User.unverified_staff
      @verified_staff_accounts = User.verified_staff
    end
    
    def show
    end
    
    def approve
      @staff_account.approve_as_staff!
      flash[:notice] = "Staff account has been approved!"
      redirect_to admin_staff_accounts_path
    end
    
    def deny
      @staff_account.update_attribute(:staff, false)
      flash[:notice] = "Staff account has been denied!"
      redirect_to admin_staff_accounts_path
    end

    private
      
      def load_object
        @staff_account = User.staff.find(params[:id])
      end
      
  end
end
