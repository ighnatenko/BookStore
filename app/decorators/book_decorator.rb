class BookDecorator < Draper::Decorator
  delegate_all

  def dimensions
    ["H: #{height}\"", "W: #{width}\"", "D: #{depth}\""].join(' x ')
  end

  def root_image
    images.any? ? images.first.url : 'default'
  end

  def authors
    authors = []
    authors.each do |a|
      authors << "#{a.firstname} #{a.lastname}"
    end
    authors.join(', ')
  end
end