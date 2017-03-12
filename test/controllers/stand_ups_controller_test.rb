require 'test_helper'

class StandUpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stand_up = stand_ups(:one)
  end

  test "should get index" do
    get stand_ups_url
    assert_response :success
  end

  test "should get new" do
    get new_stand_up_url
    assert_response :success
  end

  test "should create stand_up" do
    assert_difference('StandUp.count') do
      post stand_ups_url, params: { stand_up: { completed: @stand_up.completed, date: @stand_up.date, goals: @stand_up.goals, obstacles: @stand_up.obstacles, project_id: @stand_up.project_id, student_id: @stand_up.student_id } }
    end

    assert_redirected_to stand_up_url(StandUp.last)
  end

  test "should show stand_up" do
    get stand_up_url(@stand_up)
    assert_response :success
  end

  test "should get edit" do
    get edit_stand_up_url(@stand_up)
    assert_response :success
  end

  test "should update stand_up" do
    patch stand_up_url(@stand_up), params: { stand_up: { completed: @stand_up.completed, date: @stand_up.date, goals: @stand_up.goals, obstacles: @stand_up.obstacles, project_id: @stand_up.project_id, student_id: @stand_up.student_id } }
    assert_redirected_to stand_up_url(@stand_up)
  end

  test "should destroy stand_up" do
    assert_difference('StandUp.count', -1) do
      delete stand_up_url(@stand_up)
    end

    assert_redirected_to stand_ups_url
  end
end
