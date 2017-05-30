class SetupTables < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :login_id
      t.string :password_digest
      t.string :user_type, null: false, default: 2
      t.string :email

      t.timestamps
    end

    create_table :lessons do |t|
      t.string :name
      t.string :content
      t.string :image_name #画像ネーム(旧,image)
      t.binary :image_data, limit: 10.megabyte #画像のデータ

      t.timestamps
    end

    create_table :reservations do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.datetime :date_time#旧,reservation_data

      t.timestamps
    end
  end
end
