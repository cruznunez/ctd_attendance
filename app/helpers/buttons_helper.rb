module ButtonsHelper
  def add_button(path)
    button = <<-HTML.html_safe
      <span class="fa-stack fa-2x">
        <i class="fa fa-circle fa-stack-2x green"></i>
        <i class="fa fa-plus fa-stack-1x"></i>
      </span>
    HTML

    link_to button, path, id: 'action'
  end

  def back_button(path)
    angle = <<-HTML.html_safe
      <span class="fa-stack fa-2x">
        <i class="fa fa-circle fa-stack-2x gray"></i>
        <i class="fa fa-angle-left fa-stack-1x"></i>
      </span>
    HTML

    link_to angle, path, id: 'back'
  end

  def edit_button(path)
    button = <<-HTML.html_safe
      <span class="fa-stack fa-2x">
        <i class="fa fa-circle fa-stack-2x yellow"></i>
        <i class="fa fa-pencil fa-stack-1x"></i>
      </span>
    HTML

    link_to button, path, id: 'action'
  end

  def submit_button
    <<-HTML.html_safe
      <div id="action">
        <span id="submit" class="fa-stack fa-2x">
          <i class="fa fa-circle fa-stack-2x green"></i>
          <i class="fa fa-check fa-stack-1x"></i>
        </span>
      </div>
    HTML
  end
end
