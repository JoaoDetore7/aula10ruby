def exibir_menu
    puts "---- Agenda Telefônica ----"
    puts "1. Adicionar contato"
    puts "2. Remover contato"
    puts "3. Atualizar contato"
    puts "4. Visualizar contatos"
    puts "5. Sair"
    puts "---------------------------"
  end
  
  def adicionar_contato(contact_list)
    puts "----"
    print "Digite o nome do contato: "
    name = gets.chomp
    print "Digite o número de telefone: "
    phone = gets.chomp
    contact_list[name] = phone
    puts "Contato adicionado com sucesso!"
    puts "----"
  end
  
  def remover_contato(contact_list)
    puts "----"
    print "Digite o nome do contato que deseja remover: "
    name = gets.chomp
    if contact_list.key?(name)
      contact_list.delete(name)
      puts "Contato removido com sucesso!"
    else
      puts "Contato não encontrado na agenda."
    end
    puts "----"
  end
  
  def atualizar_contato(contact_list)
    puts "----"
    print "Digite o nome do contato que deseja atualizar: "
    name = gets.chomp
    if contact_list.key?(name)
      print "Digite o novo número de telefone: "
      phone = gets.chomp
      contact_list[name] = phone
      puts "Contato atualizado com sucesso!"
    else
      puts "Contato não encontrado na agenda."
    end
    puts "----"
  end
  
  def visualizar_contatos(contact_list)
    puts "----"
    if contact_list.empty?
      puts "A agenda está vazia."
    else
      puts "Contatos na agenda:"
      contact_list.each { |name, phone| puts "#{name}: #{phone}" }
    end
    puts "----"
  end
  
  contact_list = {}
  
  loop do
    exibir_menu
    opcao = gets.chomp.to_i
  
    case opcao
    when 1
      adicionar_contato(contact_list)
    when 2
      remover_contato(contact_list)
    when 3
      atualizar_contato(contact_list)
    when 4
      visualizar_contatos(contact_list)
    when 5
      puts "----"
      puts "Até logo!"
      puts "----"
      break
    else
      puts "Opção inválida! Digite um número de 1 a 5."
    end
  end