class RevenueSerializer < ActiveModel::Serializer
 attributes :revenue

 	def revenue
  	'%.2f' % (object / 100.00).to_s
  end
end
