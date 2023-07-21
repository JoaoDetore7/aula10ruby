module Validatable
  def valid_email?(email)
    /^[\w+.]+@\w+\.\w{2,}(?:\.\w{2})?$/.match(email)
  end

  def valid_document?(document)
    /^\d{3}\.?\d{3}\.?\d{3}-?\d{2}$/.match(document)
  end

  def invalid_email?(email)
    !valid_email?(email)
  end

  def invalid_document?(document)
    !valid_document?(document)
  end
end