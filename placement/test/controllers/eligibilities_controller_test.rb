require 'test_helper'

class EligibilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @eligibility = eligibilities(:one)
  end

  test "should get index" do
    get eligibilities_url
    assert_response :success
  end

  test "should get new" do
    get new_eligibility_url
    assert_response :success
  end

  test "should create eligibility" do
    assert_difference('Eligibility.count') do
      post eligibilities_url, params: { eligibility: { branch: @eligibility.branch, cgpa_max: @eligibility.cgpa_max, cgpa_min: @eligibility.cgpa_min, comments: @eligibility.comments, package_max: @eligibility.package_max, package_min: @eligibility.package_min, schedule_id: @eligibility.schedule_id, skills: @eligibility.skills } }
    end

    assert_redirected_to eligibility_url(Eligibility.last)
  end

  test "should show eligibility" do
    get eligibility_url(@eligibility)
    assert_response :success
  end

  test "should get edit" do
    get edit_eligibility_url(@eligibility)
    assert_response :success
  end

  test "should update eligibility" do
    patch eligibility_url(@eligibility), params: { eligibility: { branch: @eligibility.branch, cgpa_max: @eligibility.cgpa_max, cgpa_min: @eligibility.cgpa_min, comments: @eligibility.comments, package_max: @eligibility.package_max, package_min: @eligibility.package_min, schedule_id: @eligibility.schedule_id, skills: @eligibility.skills } }
    assert_redirected_to eligibility_url(@eligibility)
  end

  test "should destroy eligibility" do
    assert_difference('Eligibility.count', -1) do
      delete eligibility_url(@eligibility)
    end

    assert_redirected_to eligibilities_url
  end
end
