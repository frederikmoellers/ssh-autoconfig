from ssh_autoconfig.zones import zone, env, nm_option

# define your zones here
# use the decorator @zone and return either True or False

@zone
def ipv6():
    """
    Check for a global IPv6 address (EXAMPLE)
    """
    for address in nm_option("IP6.ADDRESS"):
        # localhost
        if address.startswith("::1"):
            continue
        # link-local
        if address.startswith("fe80::"):
            continue
        return True
    return False

@zone
def home():
    """
    Check for IPv4 address from the home network (EXAMPLE)
    """
    if nm_option("IP4.ADDRESS", "192.168.0.1"):
        return True
    return False
