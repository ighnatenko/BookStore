# frozen_string_literal: true

# BooksController
class BooksController < ApplicationController
  load_and_authorize_resource

  def show
    @book = @book.decorate
  end
end
