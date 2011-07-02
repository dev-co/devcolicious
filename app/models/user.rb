class User
  include Mongoid::Document

  # - Relationships -
  has_and_belongs_to_many :bookmarks

  # - Devise -
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # - Instance Methods -
  def bookmarks_count
    self.bookmark_ids.size
  end

end
