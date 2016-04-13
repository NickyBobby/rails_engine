class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :created_at, :updated_at

  # def created_at
  #   # binding.pry
  #   DateTime.parse(params[:created_at].to_s) rescue binding.pry
  # end
  #
  # def updated_at
  #   DateTime.parse(object.updated_at.to_s)
  # end
end
