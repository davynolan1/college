import socket, sys, datetime, time
from _thread import start_new_thread

class Server:
    # Constructors initializing basic architecture
    def __init__(self, blacklisted_ips=False, blacklist_websites=False):
        self.max_conn = 0
        self.buffer_size = 0
        self.socket = 0
        self.port = 0
        self.blacklisted_ip_lookup = blacklisted_ips
        self.blacklist_websites_lookup = blacklist_websites


    # Function which triggers the server
    def start_server(self, conn=5, buffer=4096, port=8081):
        try:
            print(" Running on port: ",port)
            self.listen(conn, buffer, port)

        except KeyboardInterrupt:
            print("   Interrupting Server.")
            time.sleep(.5)

        finally:
            print("   Stopping Server...")
            sys.exit()

    # Listener for incoming connections
    def listen(self, No_of_conn, buffer, port):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.bind(('', port))
            s.listen(No_of_conn)
            print("   Listening...")
    
        except:
            print("   Error: Cannot start listening...")
            sys.exit(1)

        while True:
            # Try to accept new connections and read the connection data in another thread
            try:
                conn, addr = s.accept()
                print("   Request received from: ", addr)
                start_new_thread(self.connection_read_request, (conn, addr, buffer))

            except Exception as e:
                print("  Error: Cannot establish connection..." + str(e))
                sys.exit(1)

        s.close()

    # helper Function to generate header to send response in HTTPS connections
    def generate_header_lines(self, code, length):
        h = ''
        if code == 200:
            # Status code
            h = 'HTTP/1.1 200 OK\n'
            h += 'Server: Jarvis\n'

        elif code == 404:
            # Status code
            h = 'HTTP/1.1 404 Not Found\n'
            h += 'Date: ' + time.strftime("%a, %d %b %Y %H:%M:%S", time.localtime()) + '\n'
            h += 'Server: Jarvis\n'

        h += 'Content-Length: ' + str(length) + '\n'
        h += 'Connection: close\n\n'

        return h

    # Function to extract data from the request 
    def connection_read_request(self, conn, addr, buffer):
        # Try to extract the necessary information from the request 
        try:
            request = conn.recv(buffer)                     #receive info the size of buffer
            header = request.split(b'\n')[0]                #header is the first line of the request
            requested_filename = request                        
            requested_filename = requested_filename.split(b' ')
            url = header.split(b' ')[1]

            # Extracting Port and Domain from URL
            hostIndex = url.find(b"://")
            if hostIndex == -1:
                temp = url
            else:
                temp = url[(hostIndex + 3):]

            portIndex = temp.find(b":")

            serverIndex = temp.find(b"/")
            if serverIndex == -1:
                serverIndex = len(temp)

            # If there is no port in the header, use port 80 (default port)
            webserver = ""
            port = -1
            if (portIndex == -1 or serverIndex < portIndex):
                port = 80
                webserver = temp[:serverIndex]
            else:
                port = int((temp[portIndex + 1:])[:serverIndex - portIndex - 1])
                webserver = temp[:portIndex]

            # Extracting the requested file and checking if we have it stored in cache
            requested_filename = requested_filename[1]
            print("Requested File ", requested_filename)

            # Method to find if function is CONNECT or GET (i.e. HTTPS or HTTP)
            method = request.split(b" ")[0]

            # Checking if the ip is blacklisted
            if addr[0] in self.blacklisted_ip_lookup:
                print("    IP Blacklisted")
                conn.close()

            # Checking if the domain is blacklisted
            target = webserver
            target = target.replace(b"http://", b"").split(b".")[1].decode("utf-8")
            try:
                if target in self.blacklist_websites_lookup:
                    print("   Website Blacklisted")
                    conn.close()
            except:
                pass

            # If method is CONNECT (HTTPS)
            if method == b"CONNECT":
                print("   CONNECT Request")
                self.https_proxy(webserver, port, conn, request, addr, buffer, requested_filename)

            # If method is GET (HTTP)
            else:
                print("   GET Request")
                self.http_proxy(webserver, port, conn, request, addr, buffer, requested_filename)

        except Exception as e:
            #print("  Error: Cannot read connection request..." + str(e))
            return

    # This function looks after HTTP requests
    def http_proxy(self, webserver, port, conn, request, addr, buffer_size, requested_filename):
        # Extracting filename
        requested_filename = requested_filename.replace(b".", b"_").replace(b"http://", b"_").replace(b"/", b"")

        # Checking to see if filename is stored in cache
        try:
            print("  Searching for: ", requested_filename)
            print("  Cache Hit!")
            file_handler = open(b"cache/" + requested_filename, 'rb')       # Opening cache folder to see if requested_filename is in it
            response_content = file_handler.read()
            file_handler.close()
            response_headers = self.generate_header_lines(200, len(response_content))   # Generating header for cache file
            conn.send(response_headers.encode("utf-8"))       # Sending encoded response header
            time.sleep(1)
            conn.send(response_content)                       # Sending response content from cache
            conn.close()

        # If no cache hit occurs, request from the web 
        except Exception as e:
            print(e)
            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.connect((webserver, port))
                s.send(request)

                print("  Forwarding request from ", addr, " to ", webserver)
        
                # Makefile for socket
                file_object = s.makefile('wb', 0)
                file_object.write(b"GET " + b"http://" + requested_filename + b" HTTP/1.0\n\n")
                # Read the response into buffer
                file_object = s.makefile('rb', 0)
                buff = file_object.readlines()
                temp_file = open(b"cache/" + requested_filename, "wb+")     # Store new file in cache 
                for i in range(0, len(buff)):
                    temp_file.write(buff[i])
                    conn.send(buff[i])

                print("  Request of client " + str(addr) + " completed...")
                s.close()
                conn.close()

            except Exception as e:
                print("  Error: forward request..." + str(e))
                return

    # This function looks after HTTPS requests
    def https_proxy(self, webserver, port, conn, request, addr, buffer_size, requested_filename):
        # Extracting filename
        requested_filename = requested_filename.replace(b".", b"_").replace(b"http://", b"_").replace(b"/", b"")

        # Checking to see if filename is stored in cache
        try:
            print("  Searching for: ", requested_filename)
            file_handler = open(b"cache/" + requested_filename, 'rb')
            print("\n")
            print("  Cache Hit!\n")
            response_content = file_handler.read()
            file_handler.close()
            response_headers = self.generate_header_lines(200, len(response_content))
            conn.send(response_headers.encode("utf-8"))
            time.sleep(1)
            conn.send(response_content)
            conn.close()

        # If no cache hit occurs, request from the web 
        except:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            try:
                # If successful connection to socket is successful, send a 200 code response
                s.connect((webserver, port))
                reply = "HTTP/1.0 200 Connection established!\r\n"
                reply += "Proxy-agent: Jarvis\r\n"
                reply += "\r\n"
                conn.sendall(reply.encode())
            except socket.error as err:
                pass
                #print("  ERROR: No HTTPS cache hit as " + str(err))

            conn.setblocking(0)
            s.setblocking(0)
            print("  HTTPS Connection Established!")
            while True:
                try:
                    request = conn.recv(buffer_size)
                    s.sendall(request)
                except socket.error as err:
                    pass

                try:
                    reply = s.recv(buffer_size)
                    conn.sendall(reply)
                except socket.error as e:
                    pass
    


def get_blacklist():
    bl_sites = []
    with open("blacklist/site.txt") as sites:
        for line in sites:
            bl_sites.append(line.split('\n')[0])

    bl_IPs = []
    with open("blacklist/ip.txt") as IPs:
        for line in IPs:
            bl_IPs.append(line.split('\n')[0])

    return bl_IPs, bl_sites
        
if __name__ == "__main__":
    blacklist = get_blacklist()
    server = Server(blacklist[0], blacklist[1])
    server.start_server()