class LikesController < ApplicationController
  
  def create
     @like = Like.create(params[:like])
     @recipe = @like.recipe
     render :toggle
   end

   def destroy
     like = Like.find(params[:id]).destroy
     @recipe = like.recipe
     render :toggle
   end
   
end