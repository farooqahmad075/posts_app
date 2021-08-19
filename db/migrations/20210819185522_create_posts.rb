# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id
      String :title, null: false
      String :content, null: false
      Float :average_rating, null: false, default: 0.0
      Integer :total_ratings, null: false, default: 0
      foreign_key :user_id, :users, null: false
    end

    add_index :posts, :id, unique: true
    add_index :posts, :user_id
  end
end
