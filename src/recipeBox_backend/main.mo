import Array "mo:base/Array";
import Bool "mo:base/Bool";

actor RecipeBook{

  type Recipe = {
    id:Nat;
    title:Text;
    ingridients:Text;
    instruction:Text;
    image:Text;
  };

  var recipes:[Recipe]=[];

  public func addRecipe(title:Text,ingridients:Text,instruction:Text,image:Text){
    let id = Array.size(recipes);
    let newRecipe:Recipe = {
      id=id;
      title=title;
      ingridients=ingridients;
      instruction=instruction;
      image=image;
    };
    let updatedRecipes = Array.tabulate<Recipe>(id + 1, func(index : Nat) : Recipe {
        if (index < id) {
            return recipes[index];
        } else {
            return newRecipe;
        }
    });
    recipes := updatedRecipes;
    // return id ;
  };

  public func getAllRecipe():async[Recipe]{
    return recipes;
  };

  public func deleteRecipe(targetId:Nat): async(){
  recipes := Array.filter<Recipe>(recipes,func(recipe:Recipe):Bool{
    return recipe.id != targetId;
  });
  };
  public func updateRecipeById(targetId:Nat,updatedRecipe:Recipe):async(){
    recipes:=Array.tabulate<Recipe>(Array.size(recipes),func(i:Nat):Recipe{
      let currentRecipe = recipes[i];
      if(currentRecipe.id==targetId){
        return {
          id = targetId;
          title = updatedRecipe.title;
          ingridients = updatedRecipe.ingridients;
          instruction = updatedRecipe.instruction;
          image = updatedRecipe.image;
        };
      }else{
        return currentRecipe;
      }
    });
  }

  
}