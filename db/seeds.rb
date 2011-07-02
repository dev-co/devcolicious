puts '>> Creating example bookmarks...'
Bookmark.create(
  :url    => 'http://mongodb.org',
  :title  => 'MongoDB',
  :tags   => %w[ mongo mongodb nosql sql ]
)
Bookmark.create(
  :url    => 'http://preguntas.dev-co.org',
  :title  => 'Preguntas DevCo',
  :tags   => %w[ ruby php java c++ delphi sql nosql ]
)
Bookmark.create(
  :url    => 'http://gmail.com',
  :title  => 'GMail',
  :tags   => %w[ email webmail googlemail ]
)
puts '>> Example bookmarks successfully created.'

puts '>> Creating example user...'
User.create :email => 'john@doe.com', :password => 's3cr3t'
puts '>> Example user successfully created.'
