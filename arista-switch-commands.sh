## Initial Connection and Basic Navigation
## Connect to the switch:
# SSH connection
ssh admin@<switch-ip>
# Console connection (if available)
# Connect via console cable and terminal emulator

## Basic EOS navigation:
# Enter privileged mode
enable
# or 
en

# Enter configuration mode
configure terminal

# Exit configuration mode
exit

# Return to user mode
disable

# Show current mode
show privilege

## Configuration Management
# View and manage configurations:
# Show running configuration
show running-config

# Show startup configuration
show startup-config

# Show specific sections
show running-config interfaces
show running-config spanning-tree

# Save configuration
copy running-config startup-config
# or
write memory

# Show configuration differences
show running-config diffs

# View configuration sessions
show configuration sessions

# Enter configuration session mode
configure session <session-name>

## Port Status and Management
# Check port status:
# Show all interfaces
show interfaces status

# Show specific interface
show interfaces ethernet 1/1

# Show interface counters
show interfaces counters

# Show interface descriptions
show interfaces description

# Show physical interface details
show interfaces ethernet 1/1 phy detail

# Check cable/transceiver information
show interfaces transceiver

## Enable/Disable ports:
# Enter configuration mode
configure terminal

# Select interface
interface ethernet 1/1

## Port-Channel Interface Configuration:
interface port-Channel 293
   description GPUEE49                    # Identifies what this connects to
   switchport access vlan 2138            # Assigns VLAN (like a regular port)
   port-channel lacp fallback static      # Fallback if LACP negotiation fails
   port-channel lacp fallback timeout 5   # Wait 5 seconds before fallback
   mlag 293                               # MLAG peer-link identifier

## Physical Interface Configuration:
interface ethernet 29/3
   description GPUEE49                    # Same description for consistency
   speed forced 25gfull                   # Force 25Gb speed
   channel-group 293 mode active         # Join this port to port-channel 293
   lacp timer fast                        # Faster LACP hello timers
   lacp port-priority 1                   # Higher priority for this port

# These remove the old trunk configuration
no switchport trunk native vlan    # Remove native VLAN setting
no switchport trunk allowed vlan    # Remove allowed VLANs list  
no switchport mode                  # Remove explicit trunk mode
switchport access vlan 2138        # Set as access port in VLAN 2138

# Enable port (remove shutdown)
no shutdown

# Disable port
shutdown

# Configure description
description "Server Connection"

# Set speed and duplex (if needed)
speed forced 1000full
# or
speed auto

# Save configuration
copy running-config startup-config
# or
write memory

# Exit interface configuration
exit

## Bulk port configuration:
# Configure multiple interfaces
interface ethernet 1/1-10
no shutdown
description "Access Ports"
exit

## VLAN Management
# View VLAN information:
# Show all VLANs
show vlan

# Show VLAN brief
show vlan brief

# Show specific VLAN
show vlan 100

# Show VLAN interface assignments
show interfaces switchport
VLAN Configuration:

# Create VLANs
configure terminal
vlan 100
name "Data_VLAN"
vlan 200
name "Voice_VLAN"
exit

# Assign VLAN to access port
interface ethernet 1/5
switchport mode access
switchport access vlan 100
exit

# Configure trunk port
interface ethernet 1/1
switchport mode trunk
switchport trunk allowed vlan 100,200,300
# or allow all VLANs
switchport trunk allowed vlan all
exit

# Remove VLAN from trunk
interface ethernet 1/1
switchport trunk allowed vlan remove 150
exit

# Add VLAN to trunk
interface ethernet 1/1
switchport trunk allowed vlan add 400
exit

## Spanning Tree Monitoring and Management
# Monitor Spanning Tree:
# Show spanning tree summary
show spanning-tree

# Show spanning tree for specific VLAN
show spanning-tree vlan 100

# Show spanning tree interface details
show spanning-tree interface ethernet 1/1

# Show spanning tree root information
show spanning-tree root

# Show spanning tree topology changes
show spanning-tree topology-changes

# Show detailed spanning tree information
show spanning-tree detail

# Monitor spanning tree events
show logging | grep -i span

## Spanning Tree Configuration:
# Configure spanning tree mode
configure terminal
spanning-tree mode rapid-pvst
# or
spanning-tree mode mstp

# Set bridge priority (lower = higher priority)
spanning-tree vlan 100 priority 4096

# Configure port priorities
interface ethernet 1/1
spanning-tree port-priority 64
spanning-tree cost 10
exit

# Enable/disable spanning tree on interface
interface ethernet 1/5
spanning-tree portfast
# For access ports connected to end devices

# Disable spanning tree (use with caution)
no spanning-tree vlan 100
Advanced Monitoring Commands
System monitoring:
bash# Show system resources
show processes top
show system memory
show system cpu

# Show environment status
show system environment all
show system environment temperature
show system environment power

# Show logging
show logging
show logging last 50

# Show version information
show version
show boot-config
Network monitoring:
bash# Show MAC address table
show mac address-table
show mac address-table dynamic

# Show ARP table
show arp

# Show LLDP neighbors
show lldp neighbors
show lldp neighbors detail

# Monitor port utilization
show interfaces counters rates
show interfaces counters errors

# Real-time monitoring
monitor interfaces
# Press Ctrl+C to exit

## Troubleshooting Commands
# Interface troubleshooting:
# Show interface errors
show interfaces counters errors

# Show interface discards
show interfaces counters discards

# Clear interface counters
clear counters

# Show interface buffer usage
show interfaces counters queue

# Test connectivity
ping <ip-address>
traceroute <ip-address>
Configuration verification:
bash# Verify configuration syntax
configure terminal
! Make changes
show running-config diffs
! If satisfied:
commit
! If not:
abort
Common Management Tasks
Regular maintenance:
bash# Backup configuration
copy running-config flash:backup-config-$(date +%Y%m%d)

# Update software (example)
copy scp://user@server/EOS-4.xx.x.swi flash:
boot system flash:EOS-4.xx.x.swi

# Schedule configuration saves
configure terminal
event-handler save-config
trigger on-boot
action bash FastCli -p 15 -c "copy running-config startup-config"
Monitoring scripts:
bash# Create alias for common commands
configure terminal
alias spt show spanning-tree
alias sir show interfaces status
alias svi show vlan brief

## Advanced Port Configuration
# Link Aggregation (Port-Channel) Management
# View existing port-channels:
# Show all port-channels
show port-channel summary

# Show specific port-channel
show port-channel 293

# Show LACP details
show lacp neighbor
show lacp interface ethernet 29/3

# Show MLAG status
show mlag
show mlag interfaces

# Create a port-channel:
# Step 1: Create the port-channel interface
configure terminal
interface port-channel 293
description "Server Connection"
switchport access vlan 100
# or for trunk:
# switchport mode trunk
# switchport trunk allowed vlan 100,200,300

# Step 2: Add physical interfaces to the port-channel
interface ethernet 29/3
channel-group 293 mode active
exit

interface ethernet 29/4  
channel-group 293 mode active
exit