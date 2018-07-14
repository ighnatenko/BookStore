# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource

  def show
    @book = Book.find(params[:id]).decorate
  end
end
