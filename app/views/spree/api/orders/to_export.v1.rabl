object false
child(@orders => :orders) do
  extends "spree/api/orders/order"
end
node(:count) { @orders.count }
