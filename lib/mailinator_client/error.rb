module MailinatorClient
  class ResponseError < StandardError
    attr_reader :code
    attr_reader :type

    def initialize(code, result = nil, raw_body = nil)
      result_hash = result.is_a?(Hash) ? result : {}
      @code = code
      @type = result_hash["type"] || result_hash[:type]

      message = result_hash["message"] || result_hash[:message]
      if (message.nil? || message.to_s.empty?) && !raw_body.nil?
        message = raw_body.to_s.strip
      end
      message = "HTTP #{code}" if message.nil? || message.to_s.empty?

      super(message)
    end
  end
end
