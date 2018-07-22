# frozen_string_literal: true

# ActionView
class ActionView::TestCase::TestController
  def default_url_options(*)
    { locale: I18n.default_locale }
  end
end

# ActionDispatch
class ActionDispatch::Routing::RouteSet
  def default_url_options(*)
    { locale: I18n.default_locale }
  end
end
