class BooksController < ApplicationController
    def index
      @books = Book.all.order(ranking: :desc)
    end

    def show
      @book = Book.find(params[:id])
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      @book.ranking = 0

      if @book.save
        redirect_to book_path(@book)
      else
        render :new
      end
    end

    def edit
      @book = Book.find(params[:id])
    end

    def update
      @book = Book.find(params[:id])

      if @book.update(book_params)
        redirect_to book_path(@book)
      else
        render :edit
      end
    end

    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
    end

    def upvote
      @book = Book.find(params[:id])
      @book.ranking += 1
      @book.save
      redirect_to book_path(@book)
    end

  private

  def book_params
    params.require(:book).permit(:name, :author, :description, :ranking)
  end
end
