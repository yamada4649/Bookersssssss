class FavoritesController < ApplicationController

	def create
		#book = Book.find(params[:book_id])#findparamsでbook_idをとってきてあげて、Book.findでBookモデルとbook_idを参照してくる。
		#favorite = book.favorites.new(user_id: current_user.id)
		#favorite.save
    #redirect_to request.referer
    #非同期の場合
     @book = Book.find(params[:book_id])
     favorite = @book.favorites.new(user_id: current_user.id)
     favorite.save

  end
  def destroy
    	#book = Book.find(params[:book_id])#URLのbook_idからきている。
    	#favorite = current_user.favorites.find_by(book_id: book.id)
      #favorite.destroy
      #redirect_to request.referer

      @book = Book.find(params[:book_id])
      favorite = @book.favorites.find_by(user_id: current_user.id)
      favorite.destroy
  end
private
  def redirect
    case params[:redirect_id].to_i
    when 0
      redirect_to books_path
    when 1
      redirect_to book_path(@book)
    end
  end
  α = gets.chomp.to_s
  if /\A[a-z]+\z/.match?(α)
    puts α
  else /\A[A-Z]+\z/.match?(α)
    puts α
  end

end
