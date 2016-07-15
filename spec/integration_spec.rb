require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the clients path', {:type => :feature}) do
  it('render the page that displays a list of clients') do
    visit('/')
    click_on("View Clients")
    expect(page).to have_content("Clients")
  end
end

describe('the stylists path', {:type => :feature}) do
  it('render the page that displays a list of stylists') do
    visit('/')
    click_on("View Stylists")
    expect(page).to have_content("Stylists")
  end
end

describe('the new stylist path', {:type => :feature}) do
  it('adds a new stylist to the hair salon') do
    visit('/stylists')
    click_on("Add Stylist")
    expect(page).to have_content("Add New Stylist")
    fill_in('name', :with => "Barry")
    click_button("Submit")
    expect(page).to have_content("Barry")
  end
end

describe('the specific stylist path', {:type => :feature}) do
  it('shows a specific stylists attributes in a list format') do
    stylist1 = Stylist.new({name: "Barry"})
    stylist1.save()
    visit('/stylists')
    click_on("Barry")
    expect(page).to have_content("Name: Barry")
  end

  it('allows the user to edit a particular stylist') do
    stylist1 = Stylist.new({name: "Barry"})
    stylist1.save()
    visit("/stylists/#{stylist1.id()}")
    click_on("Edit")
    expect(page).to have_content("Edit Barry")
    fill_in('name', :with => "Rodrigo")
    click_on("Update")
    expect(page).to have_content('Name: Rodrigo')
  end
end

describe('the new client path', {:type => :feature}) do
  it('adds a new client to a stylist') do
    stylist1 = Stylist.new({name: "Barry"})
    stylist1.save()
    visit('/stylists')
    click_on("Barry")
    fill_in("name", :with => "Roger")
    click_on("Add client")
    click_on("Roger")
    expect(page).to have_content("Roger")
  end

  it('allows the user to edit a particular client') do
    stylist1 = Stylist.new({name: "Barry"})
    stylist1.save()
    client1 = Client.new({name: "Derek", stylist_id: stylist1.id()})
    client1.save()
    visit("/clients/#{client1.id()}")
    click_on("Edit")
    expect(page).to have_content("Edit Derek")
    fill_in('name', :with => "Aziz")
    click_on("Update")
    expect(page).to have_content('Name: Aziz')
  end

  it('allows the user to delete a particular client') do
    stylist1 = Stylist.new({name: "Barry"})
    stylist1.save()
    client1 = Client.new({name: "Derek", stylist_id: stylist1.id()})
    client1.save()
    visit("/clients/#{client1.id()}")
    click_on("Delete")
    expect(page).to have_content("Clients")
  end
end
