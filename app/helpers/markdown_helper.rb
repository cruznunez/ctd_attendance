# includes markdown support
module MarkdownHelper
  def full_md(text)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true, disable_indented_code_blocks: true, highlight: true,
      space_after_headers: true, strikethrough: true, superscript: true,
      underline: true
    )
    markdown.render(text).html_safe
  end

  # apperently we don't use simple md because RenderWithoutWrap doesn't exist or
  # something
  def simple_md(text)
    markdown = Redcarpet::Markdown.new(
      RenderWithoutWrap.new(
        autolink: true, disable_indented_code_blocks: true, escape_html: true,
        hard_wrap: true, no_images: true, space_after_headers: true,
        safe_links_only: true
      )
    )
    text = plus_filter dash_filter asterisk_filter pound_filter text
    markdown.render(text).html_safe
  end

  def asterisk_filter(text)
    text.gsub(/^\*\s{1}/, '\* ')
  end

  def pound_filter(text)
    text.gsub(/^#/, '\#')
  end

  def dash_filter(text)
    text.gsub(/^-/, '\-')
  end

  def plus_filter(text)
    text.gsub(/^\+/, '\+')
  end
end
