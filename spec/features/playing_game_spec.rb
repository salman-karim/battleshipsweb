require 'spec_helper'
require 'requests/helpers.rb'

feature 'Throwing bombs' do

  before (:each) do

    $game = nil

    in_browser(:one) do
      visit '/'
      click_link 'New Game'
      fill_in 'name', :with => 'p1'
      click_button 'Submit'
      # save_and_open_page
      click_button "Let\'s Go!"
      select 'Battleship', :from => 'ship'
      fill_in 'coords', :with => 'A1'
      select 'Horizontally', :from => 'direction'
      click_button 'submit'
    end

    in_browser(:two) do
      visit '/'
      click_link 'New Game'
      fill_in 'name', :with => 'p2'
      click_button 'Submit'
      # save_and_open_page
      click_button "Let\'s Go!"
      save_and_open_page
      select 'Battleship', :from => 'ship'
      fill_in 'coords', :with => 'A1'
      select 'Horizontally', :from => 'direction'
      click_button 'submit'
    end
  end

  # context 'begin shooting' do

    scenario 'Start Shooting button takes player to bomb page' do
      in_browser(:one) do
        click_button 'Start Shooting'
        expect(page).to have_content "Where do you want to attack your opponent?"
      end
    end

    #
    # end
    #
    # scenario 'can bomb coordinates' do
    #   # p $game.own_board_view($game.player_2)
    #   # p $game.own_board_view($game.player_1)
    #   in_browser(:one) do
    #     # p $game.own_board_view($game.player_1)
    #     click_button 'Start Shooting'
    #     fill_in 'coords', :with => 'A1'
    #     click_button 'Bomb!'
    #     expect(page).to have_content 'hit'
    #   end
    # end
  # end
end


  # context 'Start shooting at opponents ships' do
    # before (:each) do
    #   visit '/start_game'
    #   click_button 'Let\'s Go!'
    #   select 'Battleship', :from => 'ship'
    # #   fill_in 'coords', :with => 'A1'
    # #   select 'Horizontally', :from => 'direction'
#     # #   click_button 'submit'
#     # end
#
#     scenario 'can win game' do
#       click_button 'Start Shooting'
#       fill_in 'coords', :with => 'A1'
#       click_button 'Bomb!'
#       fill_in 'coords', :with => 'B1'
#       click_button 'Bomb!'
#       expect(page).to have_content 'Player_1 wins!'
#     end
#
#     scenario 'can lose game' do
#       click_button 'Start Shooting'
#       $game.player_2.shoot :A1
#       fill_in 'coords', :with => 'A1'
#       click_button 'Bomb!'
#       expect(page).to have_content 'Player_2 wins!'
#     end
#   end
# end
