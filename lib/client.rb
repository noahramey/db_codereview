class Client
  attr_reader(:first_name, :last_name, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @id = attributes[:id]
  end

  define_method(:==) do |another_client|
    self.first_name() == another_client.first_name() &&
    self.last_name() == another_client.last_name()
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      first_name = client.fetch('first_name')
      if first_name.include? "ß"
        first_name = first_name.gsub(/ß/, "'")
      end
      last_name = client.fetch('last_name')
      id = client.fetch('id').to_i()
      clients.push(Client.new({first_name: first_name, last_name: last_name}))
    end
    clients
  end
end