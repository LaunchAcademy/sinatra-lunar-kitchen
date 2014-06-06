require 'csv'

CSV.foreach('db/data/recipe_info.csv', headers: true) do |row|
  recipe = Recipe.find_or_create_by(name: row['name'], description: row['description'], instructions: row['instructions'])
  Ingredient.find_or_create_by(recipe: recipe, name: row['ingredient'])
end

