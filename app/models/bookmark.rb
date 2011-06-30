class Bookmark
  include Mongoid::Document
  
  # - Relationships -
  has_and_belongs_to_many :users

  # - Fields -
  field :url,   :type => String
  field :title, :type => String
  field :tags,  :type => Array
end
