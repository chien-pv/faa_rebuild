class AddReasonToRegistration < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :reason, :text
  end
end
