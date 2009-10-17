module My
  class AccountsController < BaseController
    def show
    end

    def redirect_to_show
      redirect_to :action => :show
    end

  end
end