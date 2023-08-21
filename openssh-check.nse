-- Save this script as "openssh-check.nse"

description = "Check for OpenSSH service"
author = "Your Name"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"
categories = {"default", "safe"}

-- Define the script's arguments
portrule = function(host, port)
  return port.protocol == "tcp" and port.number == 22
end

-- The function to run when the script is executed
action = function(host, port)
  local result = ""

  -- Try to connect to the SSH port and check for the OpenSSH banner
  local socket = nmap.new_socket()
  local status, err = socket:connect(host, port.number)
  if status then
    local response = socket:receive_lines(2)
    if response and response[1] and response[1]:match("^SSH") then
      result = "OpenSSH service is running"
    else
      result = "Port is open, but not identified as OpenSSH"
    end
    socket:close()
  else
    result = "Port is closed or unreachable"
  end

  return result
end
