# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :username, null: false, unique: true
    end

    add_index :users, :id, unique: true
  end
end
