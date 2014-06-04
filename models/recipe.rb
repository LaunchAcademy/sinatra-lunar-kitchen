class Recipe
  attr_reader :id, :name, :description, :instructions

  def initialize(id, name, instructions = nil , description = nil)
    @id = id
    @name = name
    @instructions = instructions
    @description = description
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
    query = "SELECT * FROM recipes WHERE id = $1"

    connection = PG.connect(dbname: 'recipes')
    result = connection.exec_params(query, [id]).first
    connection.close

    Recipe.new(
      result['id'],
      result['name'],
      result['instructions'],
      result['description']
      )
  end
end
