class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
     t.column "name", :string
     t.column "parent_id", :integer
    end
    create_table(:categories_photos, :id=>false) do |t|
      t.column "category_id", :integer
      t.column "photo_id", :integer
    end
#    Category.new do |category|
#      category.name = "ALL"
#      category.photos.find(:all).each do |p|
#        p.categories << category
#        p.save
#      end
#    end
  end

  def self.down
    drop_table :categories
    drop_table :categories_photos
  end
end
