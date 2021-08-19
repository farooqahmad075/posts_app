# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, 'text', null: false

      primary_key [:filename]
    end

    create_table(:users) do
      primary_key :id
      column :username, 'text', null: false

      index [:id], unique: true
      index [:username], name: :users_username_key, unique: true
    end

    create_table(:feedbacks) do
      primary_key :id
      column :feedbackable_id, 'integer', null: false
      column :feedbackable_type, 'text', null: false
      column :comment, 'text', null: false
      foreign_key :owner_id, :users, null: false, key: [:id]

      index [:id], unique: true
      index %i[feedbackable_id feedbackable_type owner_id], name: :single_feedback_from_an_owner_index,
                                                            unique: true
    end

    create_table(:posts) do
      primary_key :id
      column :title, 'text', null: false
      column :content, 'text', null: false
      column :average_rating, 'double precision', default: 0.0, null: false
      column :total_ratings, 'integer', default: 0, null: false
      foreign_key :user_id, :users, null: false, key: [:id]

      index [:id], unique: true
      index [:user_id]
    end

    create_table(:ip_addresses) do
      primary_key :id
      column :ip, 'text', default: '0.0.0.0', null: false
      foreign_key :post_id, :posts, null: false, key: [:id]

      index [:id], unique: true
      index [:post_id]
    end

    create_table(:ratings) do
      primary_key :id
      column :value, 'integer', default: 1, null: false
      foreign_key :post_id, :posts, null: false, key: [:id]

      index [:id], unique: true
      index [:post_id]
    end
  end
end
