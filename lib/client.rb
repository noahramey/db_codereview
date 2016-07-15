class Client
  attr_reader(:first_name, :last_name, :stylist_id, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @stylist_id = attributes[:stylist_id]
    @id = attributes[:id]
  end

  define_method(:==) do |another_client|
    self.first_name() == another_client.first_name() &&
    self.last_name() == another_client.last_name() &&
    self.stylist_id() == another_client.stylist_id()
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
      if last_name.include? "ß"
        last_name = last_name.gsub(/ß/, "'")
      end
      stylist_id = client.fetch('stylist_id').to_i()
      id = client.fetch('id').to_i()
      clients.push(Client.new({first_name: first_name, last_name: last_name, stylist_id: stylist_id}))
    end
    clients
  end

  define_method(:save) do
    if @first_name.include? "'"
      @first_name = @first_name.gsub(/'/, "ß")
    end
    if @last_name.include? "'"
      @last_name = @last_name.gsub(/'/, "ß")
    end
    result = DB.exec("INSERT INTO clients (first_name, last_name, stylist_id) VALUES ('#{@first_name}', '#{@last_name}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @first_name = attributes.fetch(:first_name, @first_name)
    if @first_name.include? "'"
      @first_name = @first_name.gsub(/'/, "ß")
    end
    @last_name = attributes.fetch(:last_name, @last_name)
    if @last_name.include? "'"
      @last_name = @last_name.gsub(/'/, "ß")
    end
    @stylist_id = attributes.fetch(:stylist_id, @stylist_id)
    @id = self.id()

    DB.exec("UPDATE clients SET first_name = '#{@first_name}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET last_name = '#{@last_name}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET stylist_id = #{@stylist_id} WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()}")
  end

  define_singleton_method(:find) do |id|
    found_client = nil
    Client.all().each() do |client|
      if client.id() == id
        found_client = client
      end
    end
    found_client
  end


end
