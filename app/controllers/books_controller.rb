class BooksController < ApplicationController

  before_action :require_admin, except: [:index]

  # def index
  #   matching_books = Book.all

  #   @list_of_books = matching_books.order({ :end_date => :desc })

  #   render({:template => "reading/index"})
  # end

  def index
    if params[:see_all] == "true"
      @list_of_books = Book.order(end_date: :desc)   # no pagination
    else
      @list_of_books = Book.order(end_date: :desc).page(params[:page]).per(4)
    end
    render({:template => "reading/index"})
  end

  def show
    the_id = params.fetch("book_id")

    matching_books = Book.where({ :id => the_id })

    @the_book = matching_books.at(0)

    render({ :template => "reading/show" })
  end

  def new_book_form
    @book = Book.new
    render(:template => "reading/new")
  end

  def create
    the_book = Book.new
    the_book.title = params.fetch("query_title")
    the_book.author = params.fetch("query_author")
    the_book.rating = params.fetch("query_rating")
    the_book.notes = params.fetch("query_notes")
    the_book.start_date = params.fetch("query_start_date")
    the_book.end_date = params.fetch("query_end_date")

    if the_book.valid?
      the_book.save
      redirect_to("/reading", { :notice => "Book created successfully." })
    else
      redirect_to("/reading", { :alert => the_book.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("book_id")
    matching_books = Book.where({ id: the_id })
    @the_book = matching_books.at(0)

    @the_book.title = params.fetch("book")["title"]
    @the_book.author = params.fetch("book")["author"]
    @the_book.notes = params.fetch("book")["notes"]
    @the_book.rating = params.fetch("book")["rating"]
    @the_book.start_date = params.fetch("book")["start_date"]
    @the_book.end_date = params.fetch("book")["end_date"]

    if @the_book.save
      redirect_to("/reading", { notice: "Book updated successfully." })
    else
      render({ template: "reading/show" })
    end
  end

  def destroy
    the_id = params.fetch("book_id")
    the_book = Book.where({ :id => the_id }).at(0)

    the_book.destroy

    redirect_to("/reading", { :notice => "Book deleted successfully."} )
  end

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end

end
