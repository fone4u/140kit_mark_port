class RawCsv < AnalysisMetadata
  
  DEFAULT_CHUNK_SIZE = 1000

  def self.run(curation_id)
    curation = Curation.first({:id => curation_id})
    FilePathing.tmp_folder(curation, self.underscore)
    conditional = Analysis.curation_conditional(curation)
    tweet_fields = ["screen_name", "location", "language", "lat", "in_reply_to_status_id", "created_at", "lon", "in_reply_to_user_id", "text", "source", "retweeted", "retweet_count", "twitter_id", "truncated", "user_id", "in_reply_to_screen_name", "dataset_id"]
    user_fields = ["profile_background_image_url", "screen_name", "location", "profile_image_url", "utc_offset", "contributors_enabled", "profile_sidebar_fill_color", "url", "profile_background_tile", "profile_sidebar_border_color", "created_at", "followers_count", "notifications", "friends_count", "protected", "description", "geo_enabled", "profile_background_color", "twitter_id", "favourites_count", "following", "profile_text_color", "verified", "name", "lang", "time_zone", "statuses_count", "profile_link_color", "dataset_id"]
    FilePathing.file_init("tweets.csv")
    FilePathing.file_init("users.csv")
    self.query_to_csv(Tweet, {:fields => tweet_fields}.merge(conditional))
    self.query_to_csv(User, {:fields => user_fields}.merge(conditional))
    self.push_tmp_folder(curation.stored_folder_name)
    self.finalize(curation)
  end

  def self.query_to_csv(model, conditional, filename="/"+model.storage_name+".csv", path=ENV['TMP_PATH'])
    first = true
    keys = nil
    Sh::mkdir(path)
    FasterCSV.open(path+filename, "w") do |csv|
      model.all(conditional).chunks(DEFAULT_CHUNK_SIZE).each do |chunk|
        chunk.each do |row|
          if first
            keys = chunk.first.attributes.keys.collect{|k| k.to_s}
            puts keys.inspect
            csv << keys
            first = false
          end
          csv << keys.collect{|key| row.attributes[key.to_sym].to_s}
        end
      end
    end
  end
  
  def self.clear(am)
    self.remove_permanent_folder(am.curation.stored_folder_name)
    am.destroy
  end
  
  def self.finalize_analysis(curation)
    response = {}
    response[:recipient] = curation.researcher.email
    response[:subject] = "#{curation.researcher.user_name}, your raw CSV data for the #{curation.name} data set is complete."
    response[:message_content] = "Your CSV files are ready for download. You can grab them by visiting the collection's page: <a href=\"http://140kit.com/#{curation.researcher.user_name}/collections/#{curation.id}\">http://140kit.com/#{curation.researcher.user_name}/collections/#{curation.id}</a>."
    return response
  end
end
