module MessagesHelper
  def tag_sentence(tags)
    sentence = tags.map { |tag| link_to_tag(tag) }.to_sentence.strip
    sentence = '<em>none</em>' if sentence.blank?
    sentence
  end
end
