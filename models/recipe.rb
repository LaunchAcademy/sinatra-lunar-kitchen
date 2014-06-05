class Recipe
  attr_reader :id, :name, :description, :instructions, :ingredients

  def initialize(id, name, instructions = nil, description = nil, ingredients = [])
    @id = id
    @name = name
    @instructions = instructions
    @description = description
    @ingredients = ingredients
  end

  def self.all
    query = "SELECT * FROM recipes"

    connection = PG.connect(dbname: 'recipes')
    results = connection.exec(query)
    connection.close

    recipes = []
    results.each do |result|
      recipes << Recipe.new(
        result['id'],
        result['name'],
        result['instructions'],
        result['description']
        )
    end

    recipes
  end

  def self.find(id)
    recipe_query = "SELECT * FROM recipes WHERE id = $1"
    ingred_query = "SELECT * FROM ingredients WHERE recipe_id = $1"

    connection = PG.connect(dbname: 'recipes')
    recipe_result = connection.exec_params(recipe_query, [id]).first
    ingredients_result = connection.exec_params(ingred_query, [id]).to_a
    connection.close

    Recipe.new(
      recipe_result['id'],
      recipe_result['name'],
      recipe_result['instructions'] || "This recipe doesn't have any instructions.",
      recipe_result['description'] || "This recipe doesn't have a description.",
      ingredients
      )
  end
end
