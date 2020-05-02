class MigratePostContentToActionText < ActiveRecord::Migration[6.0]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :comments, :content, :content_old
    Comment.all.each do |comment|
      comment.update_attribute(:content, simple_format(comment.content_old))
    end
    remove_column :comments, :content_old
  end
end
