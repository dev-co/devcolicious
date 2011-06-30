class Bookmark
  include Mongoid::Document
  
  # - Relationships -
  has_and_belongs_to_many :users

  # - Fields -
  field :url,   type: String
  field :title, type: String
  field :tags,  type: Array

  # - Indexes -
  index :url, unique: true
  index :tags

  # - Validations -
  validate :format_of_url

  # - Instance Methods -
  def format_of_url
    errors.add :url, "is not a valid" if ( self.url =~ URI::regexp ).nil?
  end

end
