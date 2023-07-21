module Payable
  def pay(params = {})
    method  = params[:method]
    amount  = params[:amount]
    options = params[:options]

    return puts 'O valor a ser cobrado não foi enviado' unless amount
    return puts 'O valor mínimo não foi atingido' if amount < 1

    options[:amount] = amount

    if method == 'credit_card'
      credit_card(options)
    elsif method == 'bank_slip'
      bank_slip(options)
    else
      puts 'O método é inválido, por favor utilize credit_card ou bank_slip.'
    end
  end

  private

  def credit_card(options = {})
    card_number = options[:number]
    card_cvv    = options[:cvv]
    card_holder = options[:holder]
    card_expiry = options[:expiry]
    amount      = options[:amount]

    if card_number && card_cvv && card_holder && card_expiry
      puts "Pago com sucesso com o cartão de crédito de #{card_holder} a quantia de #{amount}"
      generate_invoice(amount)
    else
      puts 'Número do cartão não enviado' unless card_number
      puts 'CVV do cartão não enviado' unless card_cvv
      puts 'Nome impresso no cartão não enviado' unless card_holder
      puts 'Data de validade do cartão não enviada' unless card_expiry
      false
    end
  end

  def bank_slip(options = {})
    name     = options[:name]
    document = options[:document]
    email    = options[:email]
    amount   = options[:amount]

    if name && document && email
      puts "Boleto de valor #{amount} emitido e enviado no e-mail #{email}"
      generate_invoice(amount)
    else
      puts 'Nome não foi enviado' unless name
      puts 'CPF não foi enviado' unless document
      puts 'E-mail não foi enviado' unless email
      false
    end
  end

  def generate_invoice(amount)
    { invoice: rand(5000..15000), amount: amount}
  end
end