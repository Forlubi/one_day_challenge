class AddDefaultValueToPiclink < ActiveRecord::Migration[6.0]
  # That's the more generic way to change a column
  def up
    change_column :challenges, :pic_link, :string, default: "https://www.pikpng.com/pngl/b/71-712706_challenge-logo-challenge-tv-logo-clipart.png"
  end

  def down
    change_column :challenges, :pic_link, :string, default: nil
  end

end
