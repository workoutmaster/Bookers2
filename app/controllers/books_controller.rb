class BooksController < ApplicationController
	before_action :authenticate_user!,except: [:about]

	  def index
		  @user = current_user
	  	  @books = Book.all
	  	  @book = Book.new
      end

      def create
       @user = current_user
  	   @books = Book.all
  	   @book = Book.new(book_params)
  	   @book.user_id = current_user.id
  	   if@book.save
  	   flash[:notice] = "Book was successfully created."
  	   redirect_to book_path(@book.id)
       else
       render :index
       end
      end

     def show
     @book_new = Book.new
  	 @book = Book.find(params[:id])
  	 @user = @book.user

     end
     def edit
     	 @book =Book.find(params[:id])
     	 @user = current_user
     	 if @book.user == current_user
     	 else
     	 redirect_to books_path
     	 end
     end

      def update
      #@book = Book.find(params[:id])
      #@book.update(book_params)
      #redirect_to books_path(@book.id)
       @book = Book.find(params[:id])
  	   if @book.update(book_params)
  	   flash[:notice] = "Book was successfully updated."
  	   redirect_to book_path(@book.id)
       else
       render :edit
       end
      end

     def destroy
     	@book = Book.find(params[:id])
     	@book.destroy
     	redirect_to books_path(@book.id)
     end

     def about
     end

     private

     def book_params
     params.require(:book).permit(:title, :body)
     end

end