import os
import shutil

def display_blacklist():
    bl_sites = []
    with open("blacklist/site.txt") as sites:
        for line in sites:
            bl_sites.append(line.split('\n')[0])

    bl_IPs = []
    with open("blacklist/IP.txt") as IPs:
        for line in IPs:
            bl_IPs.append(line.split('\n')[0])
    print("Blacklisted IPs: ", bl_IPs)
    print("Blacklisted websites: ", bl_sites)

def add_to_blacklist(subject, list_type):
    filename = "blacklist/"+list_type+".txt"
    bl= open(filename,'a')
    try:
        bl.write(subject+"\n")
        print(bcolors.BOLD +bcolors.OKGREEN+"Success! Added to blacklist."+ bcolors.ENDC)
    except:
        print(bcolors.BOLD +bcolors.FAIL+"Fail! Could not add to blacklist."+ bcolors.ENDC)
    bl.close()

def rem_from_blacklist(subject, list_type):
    filename = "blacklist/"+list_type+".txt"
    is_in_list = 0
    try:
        with open(filename, "r") as f:
            lines = f.readlines()
    except:
        print(bcolors.BOLD +bcolors.FAIL+"Could not open"+list_type+"blacklist file."+ bcolors.ENDC)

    try:
        with open(filename, "w") as f:
            for line in lines:
                if line.strip("\n") != subject:
                    f.write(line)
                if line.strip("\n") == subject:
                    is_in_list =1
    except:
        print(bcolors.BOLD +bcolors.FAIL+"Could not open"+list_type+"blacklist file."+ bcolors.ENDC)
    if(is_in_list == 0):
        print(subject, "is not in",list_type,"blacklist so it cannot be removed.")
    elif(is_in_list == 1):
        print(bcolors.BOLD +bcolors.OKGREEN+ subject,"successfully removed from",list_type,"blacklist!"+ bcolors.ENDC)

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def console():
    print(bcolors.BOLD + bcolors.OKBLUE+"\n*******************************************************"+ bcolors.ENDC)
    print(bcolors.BOLD + bcolors.OKBLUE+"* Welcome to the Web Proxy Server Management Console! *"+ bcolors.ENDC)
    print(bcolors.BOLD +bcolors.OKBLUE+"*******************************************************"+ bcolors.ENDC)

    print("\n"+bcolors.BOLD +bcolors.OKGREEN+"1."+bcolors.ENDC+" Start proxy server...")
    print(bcolors.BOLD +bcolors.OKGREEN+"2."+bcolors.ENDC+" View blacklisted IPs and websites...")
    print(bcolors.BOLD +bcolors.OKGREEN+"3."+bcolors.ENDC+" Add content to blacklist...")
    print(bcolors.BOLD +bcolors.OKGREEN+"4."+bcolors.ENDC+" Remove content from blacklist...")
    print(bcolors.BOLD +bcolors.OKGREEN+"5."+bcolors.ENDC+" Clear cache...")
    print(bcolors.BOLD +bcolors.OKGREEN+"e."+bcolors.ENDC+" Exit management console.\n")

    option = input("What would you like to do?"+ bcolors.BOLD +bcolors.OKGREEN+"(Enter option number)\n"+bcolors.ENDC)

    if(option == '1'):
        print("\n Server is starting up...")
        os.system("python3 web_proxy_server.py")

    if(option == '2'):
        display_blacklist()
        go_back = input(bcolors.BOLD +bcolors.OKGREEN+"Return to main menu? (y/n)"+bcolors.ENDC)
        if(go_back == 'y'):
            console()
        else:
            print(bcolors.BOLD +bcolors.OKBLUE+"\nThank you, goodbye."+bcolors.ENDC)

    if(option == '3'):
        op_list_type = input("Add to IP or website blacklist? "+bcolors.BOLD +bcolors.OKGREEN+"(Enter 'ip'/'site') \n"+bcolors.ENDC)
        if(op_list_type == 'ip'):
            ip_addr = input(bcolors.BOLD +bcolors.OKGREEN+"Enter ip address you wish to add to blacklist...\n"+bcolors.ENDC)
            add_to_blacklist(ip_addr, 'ip')
        elif(op_list_type == 'site'):
            site_name = input(bcolors.BOLD +bcolors.OKGREEN+"Enter website name you wish to add to blacklist...\n"+bcolors.ENDC)
            add_to_blacklist(site_name, 'site')
        else:
            print(bcolors.BOLD +bcolors.FAIL+"Incorrect input.\n"+bcolors.ENDC)
            go_back = input("Return to main menu?"+bcolors.BOLD +bcolors.OKGREEN+"(y/n)"+bcolors.ENDC)
            if(go_back == 'y'):
                console()
            else:
                print(bcolors.BOLD +bcolors.OKBLUE+"\nThank you, goodbye."+bcolors.ENDC)
           

    if(option == '4'):
        display_blacklist()
        op_list_type = input("Remove from IP or website blacklist?"+bcolors.BOLD +bcolors.OKGREEN+"(Enter 'ip'/'site') \n"+bcolors.ENDC)
        
        if(op_list_type == 'ip'):
            ip_addr = input(bcolors.BOLD +bcolors.OKGREEN+"Enter ip address you wish to remove from blacklist...\n"+bcolors.ENDC)
            rem_from_blacklist(ip_addr, 'ip')
        elif(op_list_type == 'site'):
            site_name = input(bcolors.BOLD +bcolors.OKGREEN+"Enter website name you wish to remove from blacklist...\n"+bcolors.ENDC)
            rem_from_blacklist(site_name, 'site')
        else:
            print(bcolors.BOLD +bcolors.FAIL+"Incorrect input.\n"+bcolors.ENDC)
            go_back = input("Return to main menu?"+bcolors.BOLD +bcolors.OKGREEN+ "(y/n)"+bcolors.ENDC)
            if(go_back == 'y'):
                console()
            elif(go_back == 'n'):
                print(bcolors.BOLD +bcolors.OKBLUE+"\nThank you, goodbye."+bcolors.ENDC)

    if(option == '5'):
        print("Clearing cache...")
        try:
            shutil.rmtree("cache")
        except OSError:
            print ("Deletion of cache failed.")
        else:
            print ("Successfully cleared cache.")

        try:
            os.mkdir("cache")
        except OSError:
            print ("Creation of cache folder failed.")
    
    if(option == 'e'):
        print(bcolors.BOLD +bcolors.OKBLUE+"\nThank you, goodbye."+bcolors.ENDC)
        
    
if __name__ == "__main__":   
    console()

