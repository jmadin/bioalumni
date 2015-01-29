class AddSocialToAlums < ActiveRecord::Migration
  def change
    add_column :alums, :linked_in, :string
    add_column :alums, :twitter, :string
    add_column :alums, :facebook, :string
  end
end
