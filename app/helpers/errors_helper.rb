module ErrorsHelper
  def set_error_info(object)
    if object.errors.any?
      arr = []
      object.errors.full_messages.each do |msg|
        arr.push(msg)
      end
      session[:error_info] = arr
    end
  end

  def get_error_info
    if session[:error_info]
      error_info = session[:error_info]
      session.delete(:error_info)
      error_info
    end
  end

  def has_error_info?
    !(session[:error_info].nil?)
  end
end