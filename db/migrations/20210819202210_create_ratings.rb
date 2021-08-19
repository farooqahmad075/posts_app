# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:ratings) do
      primary_key :id
      Integer :value, null: false, default: 1
      foreign_key :post_id, :posts, null: false
    end

    add_index :ratings, :id, unique: true
    add_index :ratings, :post_id
  end
end
