class TagsController < ApplicationController
  def index
    respond_to do |wants|
      wants.html
      wants.js { autocomplete_tag_suggestions }
    end
  end
  
  # TODO - this can be used to suggest tags to the user that they can then click
  # on to add to their message
  def suggest
    (Message.find_related_tags(params[:current_tags]) + 
      tags_from_text(params[:message_body])).sort(&:taggings_count)
  end
  
  def show
    @tag = message_tags { Tag.find_by_id_or_name(params[:id]) }
    
    path = if @tag
      tag_messages_path(@tag)
    else
      flash[:error] = "That tag does not exist"
      messages_path
    end
    
    redirect_to(path)
  end
  
  protected
  
    def message_tags(&block)
      Tag.with_type_scope('Message', &block)
    end
    
    def tags_from_text(text)
      [] # TODO
    end
  
    def autocomplete_tag_suggestions
      # tags = Tag.popular.search(params[:val]).limit(params[:limit] || 5)
      tags = Tag.popular.map do |tag|
        name = tag.name
        display = "#{name} (#{tag.taggings_count})"
        
        [name, name, name, display]
      end
      
      render :json => tags.to_json
    end
end