require "rails_helper"

FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'password1' }
  end
end

RSpec.describe ProjectsController, type: :controller do
  context "GET #index" do
    it "returns a success response" do
      get :index
      # expect(response.success).to eq(true)
      expect(response).to be_successful
    end
  end

  context "GET #show" do
    let!(:project) { Project.create(title: "Test title", description: "Test description") }
    it "returns a success response" do
      get :show, params: { id: project }
      expect(response).to be_successful
    end
  end
end

require "rails_helper"

RSpec.feature "Visiting the homepage", type: :feature do
  scenario "The visitor should see projects" do
    visit root_path
    expect(page).to have_text("Projects")
  end
end

require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should fail" do
      visit new_project_path
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Log in")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Log in")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      visit project_path(project)
      click_button "Destroy this project"
      expect(page).to have_content("Log in")
      expect(Project.count).to eq(1)
    end
  end
end