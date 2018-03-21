class AddPeriodsAndDateTemporaryRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :temporary_registrations, :periods, :text
    add_column :temporary_registrations, :schedules, :text
  end
end
