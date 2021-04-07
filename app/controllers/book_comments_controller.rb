class BookCommentsController < ApplicationController
 def create
	@book = Book.find(params[:book_id])#findは主キーを取得してくる。
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = @book.id
    if @book_comment.save
      flash[:success] = "Comment was successfully created."
      #redirect_to book_path(@book)非同期のため
    else
      @book_comments = BookComment.where(book_id: @book.id)
      render '/books/show'
    end
 end
 def destroy
       @book_comment = BookComment.find(params[:book_id])
    if @book_comment.user != current_user
       redirect_to request.referer
    end
    @book_comment.destroy
    #redirect_to request.referer
 end
 private
 def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
