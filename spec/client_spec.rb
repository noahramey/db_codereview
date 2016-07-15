require('spec_helper')

describe(Client) do
  describe("#first_name") do
    it('should return the clients first name') do
      test_client = Client.new({first_name: "Jessica", last_name: "Brown"})
      expect(test_client.first_name()).to(eq("Jessica"))
    end
  end

  describe("#last_name") do
    it('should return the clients last name') do
      test_client = Client.new({first_name: "Jessica", last_name: "Brown"})
      expect(test_client.last_name()).to(eq("Brown"))
    end
  end

  describe("#==") do
    it('is the same client if they have the same first and last name') do
      test_client = Client.new({first_name: "Jessica", last_name: "Brown"})
      test_client2 = Client.new({first_name: "Jessica", last_name: "Brown"})
      expect(test_client).to(eq(test_client2))
    end
  end

  describe('.all') do
    it('should return empty') do
      expect(Client.all()).to(eq([]))
    end
  end
end
