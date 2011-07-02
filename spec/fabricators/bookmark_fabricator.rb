Fabricator( :bookmark ) do
  url   "http://mongodb#{ Fabricate.sequence :number }.org"
  title 'MongoDB'
  tags  %w[ nosql sql mongodb document db database ]
end
