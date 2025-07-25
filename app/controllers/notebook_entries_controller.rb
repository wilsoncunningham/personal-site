class NotebookEntriesController < ApplicationController

  before_action :require_admin, except: []

  def index
    @notebook_entries = NotebookEntry.order(is_pinned: :desc, created_at: :desc)

    render({:template => "notebook_entries/index"})
  end

  def show
    the_id = params.fetch("notebook_entry_id")

    matching_notebook_entries = NotebookEntry.where({ :id => the_id })

    @the_entry = matching_notebook_entries.at(0)

    render({ :template => "notebook_entries/show" })
  end

  def new_entry_form
    @entry = NotebookEntry.new
    render(:template => "notebook_entries/new")
  end

  def create
    entry = NotebookEntry.new
    entry.title = params.fetch("query_title")
    entry.entry_type = params.fetch("query_entry_type")
    entry.content = params.fetch("query_content")
    entry.link_url = params.fetch("query_link_url")
    entry.image_url = params.fetch("query_image_url")
    entry.tags = params.fetch("query_tags")
    entry.is_public = params.fetch("query_is_public")
    entry.is_pinned = params.fetch("query_is_pinned")

    if entry.valid?
      entry.save
      redirect_to("/notebook", { :notice => "Notebook Entry created successfully." })
    else
      redirect_to("/notebook", { :alert => entry.errors.full_messages.to_sentence })
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
