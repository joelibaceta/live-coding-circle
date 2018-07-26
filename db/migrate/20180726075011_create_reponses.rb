class CreateReponses < ActiveRecord::Migration[5.2]
  def change
    create_table :reponses do |t|
      t.string :sender_id
      t.string :message
      t.date :sent_at

      t.timestamps
    end
  end
end
