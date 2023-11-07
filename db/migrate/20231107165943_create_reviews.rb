class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, default: 0
      t.references :user, null: false, foreign_key: true
      t.string :brewery_id, null: false
      t.string :description

      t.timestamps
    end
  end
end
