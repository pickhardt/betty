class SimpleMatcher < Token
  definition(Proc.new do
    text_to_search.match(regex)
  end)

  def call
    text_to_search.match(regex)
  end
end
