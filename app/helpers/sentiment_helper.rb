module SentimentHelper

  require "sentimental"

  def sentiment(text)
    Sentimental.load_defaults
    sentiment = Sentimental.new
    if sentiment.get_sentiment(text) == :negative
      "redacted"
    end
  end

end
