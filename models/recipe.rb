class Recipe
  attr_reader :id, :name

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
end
