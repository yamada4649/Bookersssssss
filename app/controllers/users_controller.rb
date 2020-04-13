class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    #.allを使うかもしれない
    @user = current_user
    @book = Book.new
    @users =  User.all
  end

  def show
  	 @book = Book.new
  	 @user = User.find(params[:id])#どのユーザーの名前を表示
     @userbooks = @user.books#投稿したbookの情報をもってくる.booksで
  	 #@user = current_user

  end
  def create
  	book = Book.new(book_params)
    if book.save
       flash[:notice] = "You have creatad book successfully."
       redirect_to book_path(book.id)
  	 else
      @books = Book.all
      render :show
    end
  end
  def new
  end
  def update
      @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def edit
   @user = User.find(params[:id])
   redirect_to user_path(current_user) unless @user == current_user
  end
private


  def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
