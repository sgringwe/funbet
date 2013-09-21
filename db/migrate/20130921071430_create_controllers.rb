class CreateControllers < ActiveRecord::Migration
  def change
    create_table :controllers do |t|
      t.string :bet

      t.timestamps
    end
  end
end
