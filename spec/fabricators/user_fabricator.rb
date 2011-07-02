Fabricator( :user ) do
  email     { "jonh+#{ Fabricate.sequence :number }@doe.com" }
  password  's3cr3t'
end
