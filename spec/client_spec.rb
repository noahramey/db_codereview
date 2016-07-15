require('spec_helper')

describe(Client) do
  describe("#name") do
    it('should return the clients first name') do
      test_client = Client.new({name: "Jessica Brown", stylist_id: 1, id: nil})
      expect(test_client.name()).to(eq("Jessica Brown"))
    end
  end

  describe("#stylist_id") do
    it('should return the clients stylist id') do
      test_client = Client.new({name: "Jessica Brown", stylist_id: 1, id: nil})
      expect(test_client.stylist_id()).to(eq(1))
    end
  end

  describe("#==") do
    it('is the same client if they have the same first and last name') do
      test_client = Client.new({name: "Jessica Brown", stylist_id: 1, id: nil})
      test_client2 = Client.new({name: "Jessica Brown", stylist_id: 1, id: nil})
      expect(test_client).to(eq(test_client2))
    end
  end

  describe('.all') do
    it('should return empty') do
      expect(Client.all()).to(eq([]))
    end
  end

  describe("#save") do
    it('should insert the client into the the client table within the database') do
      test_client = Client.new({name: "Jessica Brown", stylist_id: 1, id: nil})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

  describe("#update") do
    it('should update a client from the table "clients"') do
      test_client = Client.new({name: "Jessica Brown", stylist_id: 1, id: nil})
      test_client.save()
      test_client = Client.new({name: "John Smith", stylist_id: 2, id: nil})
      expect(test_client.name()).to(eq("John Smith"))
    end
  end

  describe("#delete") do
    it('should delete a client from the database') do
      test_client = Client.new({name: "Jessica Brown", stylist_id: 1, id: nil})
      test_client.save()
      test_client.delete()
      expect(Client.all()).to(eq([]))
    end
  end

  describe(".find") do
    it('finds a client by its id') do
      client1 = Client.new({name: "Jessica Brown", stylist_id: 1, id: nil})
      client1.save()
      client2 = Client.new({name: "John Smith", stylist_id: 2, id: nil})
      client2.save()
      expect(Client.find(client2.id())).to(eq(client2))
    end
  end
end
