require 'test_helper'

module Harbour
  module V1
    class ProjectsTest < ApiTest
      def project_format
        {
          "uuid"       => String,
          "name"       => String,
          "links"      => Array,
          "users"      => Array
        }
      end

      test "api user must be authorized to access projects" do
        assert_resource_is_unauthorized "projects"
      end

      test "projects index has two projects" do
        get '/api/projects', authorized_headers_and_params
        assert_response :success
        assert_equal 2, response_body['projects'].count
      end

      test "projects index projects belong to org1" do
        get '/api/projects', authorized_headers_and_params
        names = response_body['projects'].map{|u| u['name']}
        assert names.include? "bogus"
        assert names.include? "excellent"
      end

      test "index project matches format" do
        get '/api/projects', authorized_headers_and_params
        user = response_body['projects'][1]
        assert_format_matches project_format, user
      end

      test "can find project 1" do
        get '/api/projects/1', authorized_headers_and_params
        assert_response :success
      end

      test "can't find project 3" do
        get '/api/projects/3', authorized_headers_and_params
        assert_response :not_found
      end

      test "project 1 matches format" do
        get '/api/projects/1', authorized_headers_and_params  
        assert_format_matches project_format, response_body['project']
      end

      test "create project succeeds with valid params" do
      end

      test "create project fails with invalid params" do
      end

      test "create project with user memberships" do
      end

      test "update project succeeds with valid params" do
      end

      test "update project fails with invalid params" do
      end

      test "update project with user memberships" do
      end

      test "delete project succeeds if project exists" do
      end

      test "delete project fails if project can't be found" do
      end

      test "delete project fails with suitable error if project can't be removed" do
        # e.g. if it's the primary project
      end
    end
  end
end