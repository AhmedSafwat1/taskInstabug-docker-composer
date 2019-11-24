class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.bigint :number
      t.bigint :message_count , :default => 0
      t.references :application, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
