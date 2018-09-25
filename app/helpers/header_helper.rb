module HeaderHelper
  def destroy
    return if request.path['stand_ups'] || request.path['code_reviews']
    if request.path['edit']
      delete_button @lesson || @student || @semester || @course || @user || @project
    else
      logout_button
    end
  end

  def delete_button(resource)
    path = case resource
    when Student then student_path resource
    when Semester then course_semester_path resource.course_id, resource
    when User then user_path resource
    when Project then project_path resource
    when Lesson then [@course, @semester, resource]
    else course_path resource
    end

    msg = "Delete this #{resource.class.to_s.downcase}?"
    btn = %(<i class="fa fa-trash-o fa-lg" aria-hidden="true"></i>).html_safe

    link_to btn, path, method: :delete, data: { confirm: msg }
  end

  def login_button
    link_to new_student_session_path do
      <<-HTML.html_safe
        <i class="fa fa-sign-in fa-lg" aria-hidden="true"></i>
      HTML
    end
  end

  def logout_button
    if user_signed_in?
      link_to destroy_user_session_path, method: :delete do
        <<-HTML.html_safe
          <i class="fa fa-sign-out fa-flip-horizontal fa-lg" aria-hidden="true"></i>
        HTML
      end
    elsif student_signed_in?
      link_to destroy_student_session_path, method: :delete do
        <<-HTML.html_safe
        <i class="fa fa-sign-out fa-flip-horizontal fa-lg" aria-hidden="true"></i>
        HTML
      end
    end
  end
end
