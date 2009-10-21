module My
  class BaseController < ApplicationController
    before_filter :require_user
  end
end