class BooksController < ApplicationController
  load_and_authorize_resource

  def show
    @book = Book.find_by(id: params[:id]).decorate
  end
end