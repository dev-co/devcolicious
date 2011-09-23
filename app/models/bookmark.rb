class Bookmark
  include Mongoid::Document
  
  # - Relationships -
  has_and_belongs_to_many :users

  # - Attribute Accessors -
  attr_accessor :dirty_tags

  # - Fields -
  field :url,   type: String
  field :title, type: String
  field :tags,  type: Array

  # - Indexes -
  index :url, unique: true
  index :tags

  # - Validations -
  validate :format_of_url
  validates_presence_of :url

  # - Callbacks -
  before_save :clean_dirty_tags
  before_save :sanitize_tags

  # - Instance Methods -
  def format_of_url
    errors.add :url, "is not a valid" if ( self.url =~ URI::regexp ).nil?
  end

  def users_count
    self.user_ids.size
  end

  def sanitize_tags
    self.tags = self.tags.map( &:downcase ).uniq
  end

  def clean_dirty_tags
    if self.dirty_tags.is_a? String
      self.tags = Bookmark.tags_from_string self.dirty_tags
    end
  end

  # - Class Methods -
  class << self

    def find_by_tags( tags )
      all_in :tags => tags
    end

    def tags_from_string( tags )
      tags.split( ',' ).map { |tag| tag.gsub( ' ', '' ) }
    end

    def from_delicious_feed( user = nil, delicious_username )
      bookmarks = []
      begin
        feed = retrieve_feed_from_delicious delicious_username
        unless feed.is_a? Fixnum
          time = Time.now.utc
          feed.entries.each do |entry|
            bookmark = Bookmark.find_or_initialize_by url: entry.url
            bookmark.title  = entry.title
            bookmark.tags   = entry.categories
            bookmark.users  << user if user
            if bookmark.save
              bookmarks << bookmark
              Tag.cache_tags bookmark, time
            end
          end
        end
      rescue Exception => e
        Rails.logger.error e.message
      end
      bookmarks
    end

    def retrieve_feed_from_delicious( username )
      feed  = nil
      # TODO:                                         Fix this hack  vvvvv
      url = "http://feeds.delicious.com/v2/rss/#{ username }?count=999999"
      begin
        feed = Feedzirra::Feed.fetch_and_parse url
      rescue Exception => e
        Rails.logger.error e.message
      end
      feed
    end

  end

end
