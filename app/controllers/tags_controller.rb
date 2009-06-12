class TagsController < ApplicationController
  def index
    respond_to do |wants|
      wants.html
      wants.js { autocomplete_tag_suggestions }
    end
  end
  
  def show
    path = if (@tag = Tag.find(params[:id]))
      tag_messages_path(@tag)
    else
      flash[:error] = "That tag does not exist"
      messages_path
    end
    
    redirect_to(path)
  end
  
  protected
  
    def autocomplete_tag_suggestions
      tags = Tag.popular.search(params[:val]).limit(params[:limit] || 5)
      render :json => tags.to_json
    end
end