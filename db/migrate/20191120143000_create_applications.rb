class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :key ,  index: { unique: true }
      t.string :name       , null: false
      t.bigint :chat_count , :default => 0
      t.timestamps
    end
  end
end
