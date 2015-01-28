class DropColumnsFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :photo_category
    remove_column :photos, :photo_term
    remove_column :photos, :genus_species
    add_reference :photos, :alum, index: true
  end
end

