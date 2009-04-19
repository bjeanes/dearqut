module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the homepage/, /the home page/
      root_path
    
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)