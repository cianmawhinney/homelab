# Naming scheme

## Goals
The naming scheme:
 - should be consistent and uniformly built for all devices on the network
   - would be a lot easier to split up virtual infrastructure from racked equipment
 - should not be unnecessarily cumbersome to type manually
 - does not necessarily need to produce hostnames shorter than 15 characters


 
## Desired information in each FQDN

- Machine function category
- Specific use case
- production/staging/commit etc
- site name
- some sort of incremented ID to distinguish between similar servers
- Quite a fan of docker-compose style naming, though that style of naming doesn't really work for say, a network switch.
  - unless I gave the switch a 


## Category Values
### Machine function
- 2 characters?

Short code | Full name
-----------|-----------------------------------
UP         | Uninterruptible Power Supply (UPS)
PD | Power Distribution Unit
SW         | Switch
RT         | Router
VM         | Virtual Machine
VH         | Virtual Host
LB         | Load Balancer/Reverse Proxy


## Incremented ID
- Padded to 2 digits
- Starts at 01, and next free ID is chosen
  - eg. If 01, 03, 04 exist, 02 would be chosen next
- ID is scoped to individual enviromnent at a particular location

# Examples
[]