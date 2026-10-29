extends Node

@export var recipe: RecipeData
@export var recipe_progress: RecipeData
@export var ingredients_in_pot: Array[GlobalEnums.IngredientIDs]

func score_recipe() -> bool:
	var score = 0
	score += abs(recipe.color.r - recipe_progress.color.r)
	score += abs(recipe.color.g - recipe_progress.color.g)
	score += abs(recipe.color.b - recipe_progress.color.b)
	score += abs(recipe.cook_time - recipe_progress.cook_time)

	return score < recipe.correctness_threshold
