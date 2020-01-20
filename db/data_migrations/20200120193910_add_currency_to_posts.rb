class AddCurrencyToPosts < ActiveRecord::DataMigration
  def up
    Post.update_all(currency_id: Currency.last.id)
  end
end