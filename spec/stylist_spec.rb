require('spec_helper')

describe(Stylist) do
  describe("#first_name") do
    it('should return the stylists first name') do
      test_stylist = Stylist.new({first_name: "Jessica", last_name: "Brown"})
      expect(test_stylist.first_name()).to(eq("Jessica"))
    end
  end

  describe("#last_name") do
    it('should return the stylists last name') do
      test_stylist = Stylist.new({first_name: "Jessica", last_name: "Brown"})
      expect(test_stylist.last_name()).to(eq("Brown"))
    end
  end

  describe("#==") do
    it('is the same stylist if they have the same first and last name') do
      test_stylist = Stylist.new({first_name: "Jessica", last_name: "Brown"})
      test_stylist2 = Stylist.new({first_name: "Jessica", last_name: "Brown"})
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
      test_stylist = Stylist.new({first_name: "Jessica", last_name: "Brown"})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe("#update") do
    it('should update a stylist from the table "stylists"') do
      test_stylist = Stylist.new({first_name: "Jessica", last_name: "Brown"})
      test_stylist.save()
      test_stylist.update({first_name: "John", last_name: "Smith", stylist_id: 2})
      expect(test_stylist.first_name()).to(eq("John"))
    end
  end

  describe("#delete") do
    it('should delete a stylist from the database') do
      test_stylist = Stylist.new({first_name: "Jessica", last_name: "Brown"})
      test_stylist.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe(".find") do
    it('finds a stylist by its id') do
      stylist1 = Stylist.new({first_name: "Jessica", last_name: "Brown"})
      stylist1.save()
      stylist2 = Stylist.new({first_name: "John", last_name: "Smith"})
      stylist2.save()
      expect(Stylist.find(stylist1.id())).to(eq(stylist1))
    end
  end
end
