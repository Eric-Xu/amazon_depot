Order.transaction do
	(1..100).each do |i|
		Order.create(name: "Customer #{1}", address: "#{i} Grizzly Peak Blvd", email: "customer-#{i}@example.com", pay_type: "Check")
	end
end