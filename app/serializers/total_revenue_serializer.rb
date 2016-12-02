class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
  	'%.2f' % (object / 100.00).to_s
  end
end
