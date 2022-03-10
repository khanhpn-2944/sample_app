module ApplicationHelper
  # Returns the full title on a per-page basis
  def full_title page_title
    default_title = t("default_title")
    page_title.blank? ? default_title : "#{page_title} | #{default_title}"
  end
end
