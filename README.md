# OpenVPN client-site-to-client routing

This repository contains an OpenVPN docker based setup, where a client (GC - gateway client) exposes his private
subnet to other clients (C1, C2, C3).

![Diagram](diagram.png)

The project is based on the assumption that GC1 can act as a gateway to its subnetwork, which contains its
peers (P1, P2, P3). When GC1 is connected to the public OpenVPN server its (normal, non-gateway) clients (C1,
C2, C3) can access those peers (P1, P2, P3).


## Prerequisites

 - Enabled IP forwarding on GC1.
 - Installed docker on OpenVPN server machine.
 