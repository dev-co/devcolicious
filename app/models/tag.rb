class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  identity :type => String

  field :name,  :type => String
  field :count, :type => Float, :default => 0.0
  field :used_at, :type => Time

  referenced_in :user

  index :name

  validates_uniqueness_of :name,  :allow_blank => false

  class << self
   def cache_tags(bookmark, at_time)
     if bookmark.is_a? String
       bookmark = Bookmark.find(bookmark)
     end

      tags = bookmark.tags
      existing_tags = Tag.where(:name.in => tags).only(:name).map(&:name)

      if !existing_tags.blank?
        Tag.collection.update({ :name => {:$in => existing_tags}},
                              { :$inc => {:count => 1}, :$set => {:used_at => at_time }},
                              { :multi => true })
      end

      (tags-existing_tags).each do |name|
        Tag.new( {name: name,
                  count: 1,
                  user_id: bookmark.user_ids.first,
                  created_at: at_time,
                  updated_at: at_time,
                  used_at: at_time}).save
      end
   end 
  end


end
