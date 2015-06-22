require 'spec_helper'

feature 'Starting a new game' do

  scenario 'Starting a new game' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'New game page can accept Player name' do
    visit '/new_game'
    fill_in 'name', :with => 'David'
    click_button 'Submit'
    expect(page).to have_content 'Success'
  end

  scenario 'New page can"t accept a empty form' do
    visit '/new_game'
    click_button 'Submit'
    expect(page).to have_content "What's your name?"


  end




end