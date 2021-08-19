# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:feedbacks) do
      primary_key :id
      Integer :feedbackable_id, null: false
      String :feedbackable_type, null: false
      String :comment, null: false
      foreign_key :owner_id, :users, null: false, key: :id
    end

    add_index :feedbacks, :id, unique: true
    add_index :feedbacks, %i[feedbackable_id feedbackable_type owner_id], name: :single_feedback_from_an_owner_index,
                                                                          unique: true
  end
end
