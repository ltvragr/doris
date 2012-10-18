require 'test_helper'

class InfoFieldsControllerTest < ActionController::TestCase
  setup do
    @info_field = info_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:info_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create info_field" do
    assert_difference('InfoField.count') do
      post :create, info_field: { associated_object: @info_field.associated_object, associated_role: @info_field.associated_role, category: @info_field.category, content: @info_field.content, content_type: @info_field.content_type, label: @info_field.label, sort_order: @info_field.sort_order }
    end

    assert_redirected_to info_field_path(assigns(:info_field))
  end

  test "should show info_field" do
    get :show, id: @info_field
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @info_field
    assert_response :success
  end

  test "should update info_field" do
    put :update, id: @info_field, info_field: { associated_object: @info_field.associated_object, associated_role: @info_field.associated_role, category: @info_field.category, content: @info_field.content, content_type: @info_field.content_type, label: @info_field.label, sort_order: @info_field.sort_order }
    assert_redirected_to info_field_path(assigns(:info_field))
  end

  test "should destroy info_field" do
    assert_difference('InfoField.count', -1) do
      delete :destroy, id: @info_field
    end

    assert_redirected_to info_fields_path
  end
end
