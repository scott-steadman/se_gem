# From: http://blog.codefront.net/2008/01/14/retrying-code-blocks-in-ruby-on-exceptions-whatever/
#
# Adds +retryable+ method to Kernel.
#
module Kernel

  # Options:
  # * :tries - Number of retries to perform. Defaults to 1.
  # * :on    - The Exception on which a retry will be performed. (default Exception)
  #
  # Example
  # =======
  #   retryable(:tries => 1, :on => OpenURI::HTTPError) do
  #     # your code here
  #   end
  def retryable(options = {}, &block)
    opts = {:tries => 1}.merge!(options)

    retry_exception = opts[:on] || Exception

    begin
      return yield
    rescue retry_exception
      (opts[:tries] - 1).times do
        return yield rescue retry_exception
      end
    end

    yield
  end

end
