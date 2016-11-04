class AddUserReferenceToSecrets < ActiveRecord::Migration
  def change
    add_reference :secrets, :user, index: true, foreign_key: true
  end
end
