# The MIT License (MIT)
#
# Copyright (c) 2024 Manybrain, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require_relative "mailinator_client/version"
require_relative "mailinator_client/error"
require_relative "mailinator_client/utils"
require_relative "mailinator_client/authenticators"
require_relative "mailinator_client/domains"
require_relative "mailinator_client/stats"
require_relative "mailinator_client/messages"
require_relative "mailinator_client/rules"
require_relative "mailinator_client/webhooks"
require_relative "mailinator_client/client"

module MailinatorClient

  def self.client
    @client ||= Client.new
  end

  def self.method_missing(sym, *args, &block)
    self.client.__send__(sym, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    self.client.respond_to?(method_name, include_private)
  end

end
