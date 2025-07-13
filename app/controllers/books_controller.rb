class BooksController < ApplicationController

  def index
    matching_books = Book.all

    @list_of_books = matching_books.order({ :end_date => :desc })

    # @ot_books_list = Book.where({:testament => "old"})
    # @nt_books_list = Book.where({:testament => "new"})

    render({:template => "reading/index"})
  end

  # def show
  #   the_id = params.fetch("path_id")

  #   matching_books = Book.where({ :id => the_id })

  #   @the_book = matching_books.at(0)

  #   render({ :template => "books/show" })
  # end

  def create
    the_book = Book.new
    the_book.title = params.fetch("query_title")
    the_book.author = params.fetch("query_author")
    the_book.rating = params.fetch("query_rating")
    the_book.notes = params.fetch("query_notes")
    the_book.start_date = params.fetch("query_start_date")
    the_book.end_date= params.fetch("end_date")

    if the_book.valid?
      the_book.save
      redirect_to("/books", { :notice => "Book created successfully." })
    else
      redirect_to("/books", { :alert => the_book.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_book = Book.where({ :id => the_id }).at(0)

    the_book.title = params.fetch("query_title")
    the_book.author = params.fetch("query_author")
    the_book.rating = params.fetch("query_rating")
    the_book.notes = params.fetch("query_notes")
    the_book.start_date = params.fetch("query_start_date")
    the_book.end_date= params.fetch("end_date")

    if the_book.valid?
      the_book.save
      redirect_to("/books/#{the_book.id}", { :notice => "Book updated successfully."} )
    else
      redirect_to("/books/#{the_book.id}", { :alert => the_book.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_book = Book.where({ :id => the_id }).at(0)

    the_book.destroy

    redirect_to("/books", { :notice => "Book deleted successfully."} )
  end

end
