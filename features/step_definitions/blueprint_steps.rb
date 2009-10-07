Given /^the following (.+?)(|\s+only)$/ do |model_name, only, table|
  model = model_name.parameterize("_").singularize.to_sym
  klass = model.to_s.classify.constantize
  klass.destroy_all if only =~ /only$/
  @they = table.hashes.map do |hash|
    attributes = hash.inject({}) do|h,(k,v)|
      h.delete(k)
      
      if m = /^:(.*?)\((.*?)\)$/.match(k)
        c = m[1].singularize.classify.constantize
        h.update(m[1] => v.split(/\s*,\s*/).map{|i| c.make(m[2].to_sym => i) })
      else
        h.update(k.gsub(/\s+/, "_") => v)
      end
    end
    object = klass.make attributes
    object.save! if object.respond_to?(:save!)
    object
  end
  if @they.size == 1
    @it = @they.last
  else
    @it = @they
  end

  instance_variable_set("@#{model}", @it)
end

Given /^(.*?) (?:has|have) the following (.+?)$/ do |what, model_name, table|
  what.gsub!(/\s/, '_')
  it = instance_variable_get("@#{what}")
  they = @they
  model = model_name.parameterize("_").singularize.to_s

  Given %(the following #{model_name}), table
  if Array === @it
    it.send("#{model.pluralize}=", @it)
  else
    it.send("#{model.pluralize}") << @it
  end
  it.save
  @it = it
  @they = they
  
  
end
