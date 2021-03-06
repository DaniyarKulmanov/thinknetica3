# frozen_string_literal: true

require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'menu_texts'
require_relative 'railways_data'

class RailWays
  include RailwaysData

  VIEW = { stations: :stations_list,
           routes: :routes_list,
           trains: :trains_list,
           cargo_wagons: :cargo_wagon_list,
           passenger_wagons: :passenger_wagon_list }.freeze

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @cargo_wagons = []
    @passenger_wagons = []
    seed
  end

  def main_menu
    command = paint_menu MAIN_MENU
    case command
    when 1 then station_actions(paint_menu(STATION_MENU))
    when 2 then route_actions(paint_menu(ROUTE_MENU))
    when 3 then train_actions(paint_menu(TRAIN_MENU))
    when 4 then wagon_actions(paint_menu(WAGON_MENU))
    end
  end

  private

  def paint_menu(list_actions)
    command = 0
    loop do
      puts list_actions
      input = gets.chomp
      if input == '0' || input.to_i < list_actions.size - 1
        command = input.to_i
        break
      end
    end
    command
  end

  def choose_from(variant, list)
    index = nil
    loop do
      send VIEW[variant]
      index = gets.chomp.to_i
      break unless list[index].nil?
    end
    list[index]
  rescue NoMethodError
    retry
  end
end
