import psutil
import csv
import socket

def get_network_info():
    # Fetch network statistics
    net_stats = psutil.net_if_stats()

    # Prepare a list to hold all network information
    network_info = []

    for interface, stats in net_stats.items():
        if stats.isup:  # Include only interfaces that are up
            # Get IPv4 and IPv6 addresses
            addrs = psutil.net_if_addrs().get(interface, [])
            ipv4_addrs = ', '.join([addr.address for addr in addrs if addr.family == socket.AF_INET])
            ipv6_addrs = ', '.join([addr.address for addr in addrs if addr.family == socket.AF_INET6])

            network_info.append({
                'Interface': interface,
                'MTU': stats.mtu,
                'Speed': stats.speed,
                'Duplex': stats.duplex,
                'IPv4 Address': ipv4_addrs,
                'IPv6 Address': ipv6_addrs
            })

    return network_info

def write_to_csv(network_info):
    # Specify the CSV file path
    csv_file = 'network_info.csv'

    # Define the CSV fields
    fields = ['Interface', 'MTU', 'Speed', 'Duplex', 'IPv4 Address', 'IPv6 Address']

    # Write to CSV file
    with open(csv_file, mode='w', newline='') as file:
        writer = csv.DictWriter(file, fieldnames=fields)
        writer.writeheader()
        writer.writerows(network_info)

    print(f'Network information has been written to {csv_file}')

if __name__ == '__main__':
    network_info = get_network_info()
    write_to_csv(network_info)
