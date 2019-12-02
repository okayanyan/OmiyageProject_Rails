module ErrorsHelper
  
  # function
  #   ・save argument error messages by session
  # used
  #   ・save message to render
  def set_error_info(object)
    if object.errors.any?
      arr = []
      object.errors.full_messages.each do |msg|
        arr.push(msg)
      end
      session[:error_info] = arr
    end
  end

  # function
  #   ・get argument error messages by session
  # used
  #   ・describe message to render
  def get_error_info
    if session[:error_info]
      error_info = session[:error_info]
      session.delete(:error_info)
      error_info
    end
  end

  # function
  #   ・judge existance of error messages by session
  # used
  #   ・describe message to render
  def has_error_info?
    !(session[:error_info].nil?)
  end
end