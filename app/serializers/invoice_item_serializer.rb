class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at


  def unit_price
    sprintf('%.02f', (object.unit_price / 100.0)) rescue binding.pry
  end
end
