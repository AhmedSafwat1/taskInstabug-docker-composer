class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.bigint :number
      t.string :message
      t.references :chat, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
