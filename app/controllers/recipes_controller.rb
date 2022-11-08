class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end
    
    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.user_id = current_user.id
        respond_to do |format|
          if @recipe.save
            format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
          else
            format.html { render :new, alert: 'An error has occurred while creating the recipt, try again' }
          end
        end
      end

      def destroy
        @recipe = Recipe.find(params[:id])
        if @recipe.delete
          format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was deleted successfully.' }
        else
          format.html { render :new, alert: 'An error has occurred while deleting the recipt, try again' }
        end
      end

      def recipe_params
        params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
      end

  end
  