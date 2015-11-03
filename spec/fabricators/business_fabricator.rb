Fabricator(:business) do
  name { Faker::Name.name }
  description { Faker::Lorem.paragraphs(2) }
  picture_url { "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.foodpeoplewant.com%2Fwp-content%2Fuploads%2F2010%2F03%2FTacos-de-Barbacoa.jpg&f=1" }
end