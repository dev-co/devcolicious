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
    def tags_from_string( tags )
      tags.split( ',' ).map { |tag| tag.gsub( ' ', '' ) }
    end
  end

end
