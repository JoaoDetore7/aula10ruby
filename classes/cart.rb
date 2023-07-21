class Cart
  include Shippable
  include Payable

  attr_accessor :customer, :items, :shipping_cost, :payment_method, :card

  def initialize(attributes = {})
    @customer       = attributes[:customer]
    @items          = []
    @shipping_cost  = nil
    @payment_method = attributes[:payment_method]
    @card           = attributes[:card] || {}
  end

  def show
    return puts 'Carrinho vazio' if items.empty?

    items.each do |item|
      puts "#{item.name} - #{item.price}"
    end

    puts '------'
    puts "Valor dos itens somados: #{partial_amount}"
    puts "Valor do frete: #{shipping_cost}"
    puts "Total: #{amount}"
  end

  def add(item)
    @items.push(item)
    refresh_shipping_cost
  end

  def remove(item)
    @items.delete(item)
    refresh_shipping_cost
  end

  def clear
    @items.clear
    @shipping_cost = nil
  end

  def checkout
    return puts validate_checkout if validate_checkout.any?

    invoice = pay({
      method: payment_method,
      amount: amount,
      options: payment_method == 'bank_slip' ? bank_slip_options : card
    })

    if invoice
      puts 'Compra realizada com sucesso!'
      puts "Recibo: #{invoice[:invoice]}"
      puts "Valor: #{invoice[:amount]}"
      customer.add_invoice(invoice)
      reset_after_purchase
    else
      puts 'Erro no pagamento, tente novamente mais tarde.'
    end
  end

  private

  def refresh_shipping_cost
    @shipping_cost = calculate_shipping(items.length)
  end

  def validate_checkout
    [].tap do |errors|
      errors.push('Cliente não enviado ou inválido') unless customer && customer.class == Customer
      errors.push('Carrinho vazio') if items.empty?
      errors.push('Frete ainda não calculado') if shipping_cost.nil?
    end
  end

  def partial_amount
    items.sum(&:price)
  end

  def amount
    partial_amount + shipping_cost
  end

  def reset_after_purchase
    clear
    @payment_method = nil
    @card           = {}
  end

  def bank_slip_options
    { name: customer.name, document: customer.document, email: customer.email }
  end
end