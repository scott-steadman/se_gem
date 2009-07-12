

# from http://coderrr.wordpress.com/2008/05/28/get-your-local-ip-address/
#
# This method does NOT make a connection or send any packets to 64.233.187.99
# (Google).  Since UDP is a stateless protocol connect() merely makes a
# system call which figures out how to route the packets based on the address
# and what interface (and therefore IP address) it should bind to. addr()
# returns an array containing the family (AF_INET), local port, and local
# address (which is what we want) of the socket.
#
def Socket.local_ip
  @local_ip ||= begin
    # turn off reverse DNS resolution temporarily
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true
    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  end
ensure
  Socket.do_not_reverse_lookup = orig
end

