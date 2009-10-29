task :get_top_keywords => [:environment] do
  keyword_counts = Hash.new(0)
  Comment.all.each do |comment|
    comment.get_keywords.each do |k|
      keyword_counts[k.singularize] += 1
    end
  end
  
  keyword_array = keyword_counts.to_a
  keyword_array.sort! do |a, b|
    b.last <=> a.last
  end
  
  puts keyword_array[0...100].map { |set| "#{set.last}\t\t#{set.first}" }.join("\n")
end