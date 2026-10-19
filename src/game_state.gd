extends Node

@export var recipe: RecipeData
var current_progress: RecipeResult

func score_progress() -> int:
	var score: int = 0
	var checked_ingredients: Array[String]
	
	score += abs(recipe.cook_time - current_progress.cook_time)
	
	for ingredient in recipe.ingredients:
		for jngredient in current_progress.ingredients:
			if jngredient.ingredient_id != ingredient.ingredient_id:
				continue
			
			checked_ingredients.append(jngredient.ingredient_id)
			
			score += abs(ingredient.count - jngredient.count) * 5
			score += abs(ingredient.processing_level - jngredient.processing_level)
			
	score += abs(len(recipe.ingredients) - len(checked_ingredients)) * 20
	score += abs(len(current_progress.ingredients) - len(checked_ingredients)) * 20
	
	return score
			
