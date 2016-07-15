require('spec_helper')

describe(Stylist) do
  describe("#name") do
    it('should return the stylists name') do
      test_stylist = Stylist.new({name: "Jamie Brown", id: nil})
      expect(test_stylist.name()).to(eq("Jamie Brown"))
    end
  end

  describe("#==") do
    it('is the same stylist if they have the same first and last name') do
      test_stylist = Stylist.new({name: "Jamie Brown", id: nil})
      test_stylist2 = Stylist.new({name: "Jamie Brown", id: nil})
      expect(test_stylist).to(eq(test_stylist2))
    end
  end

  describe('.all') do
    it('should return empty') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#save") do
    it('should insert the stylist into the the stylist table within the database') do
      test_stylist = Stylist.new({name: "Jamie Brown", id: nil})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe("#update") do
    it('should update a stylist from the table "stylists"') do
      test_stylist = Stylist.new({name: "Jamie Brown", id: nil})
      test_stylist.save()
      test_stylist.update({name: "John Smith"})
      expect(test_stylist.name()).to(eq("John Smith"))
    end
  end

  describe("#delete") do
    it('should delete a stylist from the database') do
      test_stylist = Stylist.new({name: "Jamie Brown", id: nil})
      test_stylist.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe(".find") do
    it('finds a stylist by its id') do
      test_stylist1 = Stylist.new({name: "Jamie Brown", id: nil})
      test_stylist1.save()
      test_stylist2 = Stylist.new({name: "John Smith", id: nil})
      test_stylist2.save()
      expect(Stylist.find(test_stylist1.id())).to(eq(test_stylist1))
    end
  end

  describe('#clients') do
    it "returns an array of clients for that stylist" do
      test_stylist = Stylist.new({name: "Jamie Brown", id: nil})
      test_stylist.save()
      test_client = Client.new({name: "Jessica Brown", stylist_id: test_stylist.id(), id: nil})
      test_client.save()
      test_client2 = Client.new({name: "John Smith", stylist_id: test_stylist.id(), id: nil})
      test_client2.save()
      expect(test_stylist.clients()).to(eq([test_client, test_client2]))
    end
  end
end
