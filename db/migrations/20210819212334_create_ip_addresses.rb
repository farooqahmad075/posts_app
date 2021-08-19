# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:ip_addresses) do
      primary_key :id
      String :ip, null: false, default: '0.0.0.0'
      foreign_key :post_id, :posts, null: false
    end

    add_index :ip_addresses, :id, unique: true
    add_index :ip_addresses, :post_id
  end
end
