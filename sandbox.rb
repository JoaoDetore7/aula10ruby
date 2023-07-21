require './modules/shippable'
require './modules/payable'
require './modules/validatable'
require './modules/addressable'
require './classes/product'
require './classes/book'
require './classes/electronic'
require './classes/customer'
require './classes/cart'

address = {
  public_area: 'Dorival Bueno',
  number: '110',
  district: 'Morro do Ouro',
  zipcode: '13840-064',
  city: 'Mogi Guaçu',
  federal_state: 'SP'
}

customer = Customer.new({
  first_name: 'john',
  last_name: 'appleseed',
  document: '123.456.789-10',
  email: 'john@appleseed.com',
  address: address
})

card = {
  number: '4444 4444 4444 4444',
  cvv: '123',
  holder: 'John Appleseed',
  expiry: '2023-10-10'
}

book  = Book.new({ name: 'Livro de Teste', price: 20, author: 'John Doe', pages: 50 })
book2 = Book.new({ name: 'Livro de Teste 2', price: 50, author: 'Jane Doe', pages: 500 })

cart = Cart.new({ customer: customer, payment_method: 'credit_card', card: card})
cart.add(book)
cart.add(book2)

cart.checkout
puts '---'
cart.show
puts '-----'
customer.show