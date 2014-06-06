require 'spec_helper'

feature "User views a recipe" do
  scenario "user the basic recipe information" do
    recipe = Recipe.where(name: 'Rosemary Duck with Apricots').first
    visit "/recipes/#{recipe.id}"

    expect(page).to have_content recipe.name
    expect(page).to have_content recipe.description
    expect(page).to have_content recipe.instructions
  end

  # you may have to modify the view to get these next two tests to pass

  scenario "user views a recipe without a description" do
    recipe = Recipe.where(description: nil).first
    visit "/recipes/#{recipe.id}"

    expect(page).to have_content "This recipe doesn't have a description."
  end

  scenario "user views a recipe without any instructions" do
    recipe = Recipe.where(instructions: nil).first
    visit "/recipes/#{recipe.id}"

    expect(page).to have_content "This recipe doesn't have any instructions."
  end

  scenario "user views a recipe's ingredients" do
    recipe = Recipe.where(name: 'Rosemary Duck with Apricots').first
    visit "/recipes/#{recipe.id}"

    ingredients = recipe.ingredients

    ingredients.each do |ingredient|
      expect(page).to have_content ingredient.name
    end
  end
end
