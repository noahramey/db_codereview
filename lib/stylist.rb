class Stylist
  attr_reader(:first_name, :last_name, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @id = attributes[:id]
  end

  define_method(:==) do |another_stylist|
    self.first_name() == another_stylist.first_name() &&
    self.last_name() == another_stylist.last_name()
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      first_name = stylist.fetch('first_name')
      if first_name.include? "ß"
        first_name = first_name.gsub(/ß/, "'")
      end
      last_name = stylist.fetch('last_name')
      if last_name.include? "ß"
        last_name = last_name.gsub(/ß/, "'")
      end
      id = stylist.fetch('id').to_i()
      stylists.push(Stylist.new({first_name: first_name, last_name: last_name}))
    end
    stylists
  end

  define_method(:save) do
    if @first_name.include? "'"
      @first_name = @first_name.gsub(/'/, "ß")
    end
    if @last_name.include? "'"
      @last_name = @last_name.gsub(/'/, "ß")
    end
    result = DB.exec("INSERT INTO stylists (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
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
    @id = self.id()

    DB.exec("UPDATE stylists SET first_name = '#{@first_name}' WHERE id = #{@id};")
    DB.exec("UPDATE stylists SET last_name = '#{@last_name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()}")
  end

  define_singleton_method(:find) do |id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id().==(id)
        found_stylist = stylist
      end
    end
    found_stylist
  end


end
