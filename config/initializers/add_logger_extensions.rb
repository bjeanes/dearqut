module ActionController
  class Base
    private
    
    def log_processing_for_parameters
      parameters = respond_to?(:filter_parameters) ? filter_parameters(params) : params.dup
      parameters = parameters.except!(:controller, :action, :format, :_method)

      logger.info "  Parameters: #{parameters.inspect}" unless parameters.empty?
      logger.info "  Cookies: #{cookies.inspect}"
      logger.info "  User Agent: #{request.user_agent}"
      logger.info "  Session ID: #{session[:session_id]}"
      forwarded_for = request.headers.find { |k, v| k =~ /forwarded/i }
      logger.info "  X-Forwarded-For: #{forwarded_for.last}" if forwarded_for
    end
  end
end