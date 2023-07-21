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

book  = Book.new({ name: 'Livro de Teste', price: 20, author: 'John Doe', pages: 50 })
book2 = Book.new({ name: 'Livro de Teste 2', price: 50, author: 'Jane Doe', pages: 500 })
cart = Cart.new({ customer: customer})
products = [book,book2]
payment_methods = [
    {references: 'credit_card', label: 'Cartão de crédito'},
    {references: 'bank_slip', label: 'Boleto bancário'}
]
loop do
    puts "Olá #{customer.name}."
    puts "----"
    puts "1. Adicionar item no carrinho."
    puts "2. Visualizar carrinho."
    puts "3. Comprar."
    puts "4. Visualizar compras."
    puts "5. Sair."
    puts "----"
    print "Digita a opção desejada: "
    option = gets.chomp.to_i

    case option
    when 1
        puts "----"
        puts "Produtos disponíveis:"

        products.each_with_index do |product,index|
            puts "#{index + 1}. #{product.name} - #{product.price}"
        end

        loop do
        print "Digite a opção desejada ou 0 para voltar ao menu principal: "
        chosen_product = gets.chomp.to_i

        break if chosen_product == 0


        final_product = products[chosen_product - 1]

        if final_product
            puts "produto adicionado com sucesso."
            cart.add(final_product)
        else
            puts "Produto inválido!"
        end
        end

        puts "----"
    when 2
        puts "----"
        cart.show
        puts "----"
    when 3
        puts "----"
        return puts "Carrinho vazio." if cart.items.empty?
        puts "Selecione o método de pagamento: "

        payment_methods.each_with_index do |payment_method, index|
            puts "#{index + 1} - #{payment_method[:label]}"
        end

        loop do
            print "Digite a opção desejada ou 0 para voltar ao menu principal: "
            chosen_method = gets.chomp
            

            break if chosen_method == '0'

            normalized_chosen_method = chosen_method.to_i - 1

            final_method = payment_methods[normalized_chosen_method]

            if final_method
                final_method_reference = final_method[:references]
                cart.payment_method = final_method_reference

                if final_method_reference == 'credit_card'
                    puts 'Preencha com as informações de seu cartão'
                    print "Número do cartão: "
                        number = gets.chomp

                    print "CVV do cartão: "
                        cvv = gets.chomp

                    print "Nome impresso no cartão: "
                        holder = gets.chomp

                    print "Data de expiração do cartão: "
                        expiry = gets.chomp
                    
                cart.card = {number: number, cvv: cvv, holder: holder, expiry: expiry}
                end

                cart.checkout
                break
            else
                puts "Método de pagamento inválido."
            end
        end

        puts "----"
    when 4
        puts "----"
        customer.show_invoices
        puts "----"
    when 5
        puts "Até mais."
        break
    else
        puts "Opção inválida."
    end
end