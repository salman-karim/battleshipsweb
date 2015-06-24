require 'spec_helper'

feature 'Starting a new game' do

  scenario 'Starts a new game' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'New game page accepts player name' do
    visit '/new_game'
    fill_in 'name', :with => 'David'
    click_button 'Submit'
    expect(page).to have_content 'Welcome, David'
  end

  scenario 'New page can\'t accept a empty form' do
    visit '/new_game'
    click_button 'Submit'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Let\'s Go! starts a new game and loads a board' do
    visit '/start_game'
    click_button 'Let\'s Go!'
    expect(page).to have_content "ABCDEF"
  end

  scenario 'place a ship' do
    visit '/start_game'
    click_button 'Let\'s Go!'
    select 'Battleship', :from => 'ship'
    fill_in 'coords', :with => 'A1'
    fill_in 'direction', :with => 'horizontally'
    click_button 'submit'
    expect(page).to have_content "BBBB"
  end

end
feature 'Start shooting at opponents ships' do 
  before (:each) do
    visit '/start_game'
    click_button 'Let\'s Go!'
    select 'Battleship', :from => 'ship'
    fill_in 'coords', :with => 'A1'
    fill_in 'direction', :with => 'horizontally'
    click_button 'submit'
  end

  scenario 'Start Shooting button takes player to bomb page' do 
    click_button 'Start Shooting'
    expect(page).to have_content "Where do you place you bomb!!!"
  end

  scenario 'can bomb coordinates' do 
    click_button 'Start Shooting'
    fill_in 'coords', :with => 'A1'
    click_button 'Bomb!'
    expect(page).to have_content 'Hit'
  end

end