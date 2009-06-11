class TagsController < ApplicationController
  def index
    respond_to do |wants|
      wants.html { render :text => "soon"}
      wants.js do
        tags = Tag.popular.search(params[:val]).limit(params[:limit] || 5)
        
        render :json => tags.to_json
      end
    end
  end
  
  
end