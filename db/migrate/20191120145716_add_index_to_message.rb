class AddIndexToMessage < ActiveRecord::Migration[5.2]
  def change
    add_index :messages, [:chat_id, :number], unique: true
  end
end
