class Client
  attr_reader(:name, :stylist_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @stylist_id = attributes[:stylist_id]
    @id = attributes[:id]
  end

  define_method(:==) do |another_client|
    self.name() == another_client.name() &&
    self.stylist_id() == another_client.stylist_id() &&
    self.id() == another_client.id()
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      name = client.fetch('name')
      if name.include? "ß"
        name = name.gsub(/ß/, "'")
      end
      stylist_id = client.fetch('stylist_id').to_i()
      id = client.fetch('id').to_i()
      clients.push(Client.new({name: name, stylist_id: stylist_id, id: id}))
    end
    clients
  end

  define_method(:save) do
    if @name.include? "'"
      @name = @name.gsub(/'/, "ß")
    end
    result = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    if @name.include? "'"
      @name = @name.gsub(/'/, "ß")
    end
    @stylist_id = attributes.fetch(:stylist_id, @stylist_id)

    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{self.id()};")
    DB.exec("UPDATE clients SET stylist_id = #{@stylist_id} WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()}")
  end

  define_singleton_method(:find) do |id|
    found_client = nil
    Client.all().each() do |client|
      if client.id().==(id)
        found_client = client
      end
    end
    found_client
  end


end
