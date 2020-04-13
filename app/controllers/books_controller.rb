class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :eroor, only: [:edit,:update]
  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @book =Book.new
  end

  def show
 #@books = Book.where(id: params[:id])

  # books/2
     @books = Book.find(params[:id])
     @user = @books.user

  	#@book = Book.find(params[:id])
  end
  def destroy
     @book = Book.find(params[:id])
     @book.destroy
     redirect_to books_path
  end
  def create
   	 @book = Book.new(book_params)
     @book.user_id = current_user.id
     if @book.save
       flash[:notice] = "You have creatad book successfully."
       redirect_to book_path(@book.id)
     else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  def new
  	@book = Book.new 
  end


  def edit
    @books = Book.find(params[:id])

  end
  def update
     @books = Book.find(params[:id])
     if @books.update(book_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to book_path(@books.id)
     else
      render :edit
     end
  end
  private
  def eroor
    book = Book.find(params[:id])
    if (book.user_id != current_user.id)
      redirect_to books_path
    end
    
  end
  def book_params
      params.require(:book).permit(:title, :body,:user_id)
   end
end
