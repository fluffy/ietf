%%%
    #
    # DTLS Tunnel for PERC
    #
    # Generation tool chain:
    #   mmark (https://github.com/miekg/mmark)
    #   xml2rfc (http://xml2rfc.ietf.org/)
    #
    Title = "DTLS Tunnel between Media Distribution Device and Key Management Function to Facilitate Key Exchange"
    abbrev = "DTLS Tunnel for PERC"
    category = "std"
    docName = "draft-jones-perc-dtls-tunnel-01"
    ipr= "trust200902"
    area = "Internet"
    keyword = ["PERC", "SRTP", "RTP", "DTLS", "DTLS-SRTP", "DTLS tunnel", "conferencing", "security"]
    
    [pi]
    subcompact = "yes"

    [[author]]
    initials = "P."
    surname = "Jones"
    fullname = "Paul Jones"
    organization = "Cisco Systems"
      [author.address]
      email = "paulej@packetizer.com"
      phone = "+1 919 476 2048"
      [author.address.postal]
      street = "7025 Kit Creek Rd."
      city = "Research Triangle Park"
      region = "North Carolina"
      code = "27709"
      country = "USA"
      
    #
    # Revision History
    #   00 - Initial draft.
    #   01 - Removed TLS-style syntax.
    #        Require the MDD to always send its list of protection profiles.
    #        Removed EKT stuff, since it's not relevant to the tunnel protocol.
    #        Added a visual representation of the tunneling protocol.
    #        Changed the message names to be simpler.
    #        Simplified message flows, because they were overly complex.
    #        Simplified the text overall.
    #
%%%

.# Abstract

This document defines a DTLS tunneling protocol for use in multimedia
conferences that enables a Media Distribution Device (MDD) to facilitate key
exchange between an endpoint in a conference and the Key Management Function
(KMF) responsible for key distribution.  The protocol is designed to ensure that
the key material used for hop-by-hop encryption and authentication is accessible
to the MDD, while the key material used for end-to-end encryption and
authentication is inaccessible to the MDD.

{mainmatter}

# Introduction

An objective of the work in the Privacy-Enhanced RTP Conferencing (PERC) working
group is to ensure that endpoints in a multimedia conference have access to the
end-to-end (E2E) and hop-by-hop (HBH) key material used to encrypt and
authenticate Real-time Transport Protocol (RTP) [@!RFC3550] packets, while the
Media Distribution Device (MDD) has access only to the hop-by-hop (HBH) key
material for encryption and authentication.

This specification defines a tunneling protocol that enables the MDD to tunnel
DTLS [@!RFC6347] messages between an endpoint and the KMF, thus allowing an
endpoint to use DTLS-SRTP [@!RFC5764] for establishing encryption and
authentication keys with the KMF.

The tunnel established between the MDD and KMF is a DTLS association that is
established before any messages are forwarded on behalf of the endpoint by the
MDD.  DTLS packets received from the endpoint are encapsulated by the MDD inside
this tunnel as data to be sent to the KMF.  Likewise, when the MDD receives data
from the KMF over the tunnel, it extracts the DTLS message inside and forwards
that to the endpoint.  In this way, the DTLS association for the DTLS-SRTP
procedures is established between the endpoint and the KMF, with the MDD simply
forwarding packets between the two entities and having no visibility into the
confidential information exchanged or derived.

Following the existing DTLS-SRTP procedures, the endpoint and KMF will arrive at
a selected cipher and key material, which are used for HBH encryption and
authentication by both the endpoint and the MDD.  However, since the MDD would
not have direct access to this information, the KMF explicitly shares the HBH
key information with the MDD via the tunneling protocol defined in this
document.

By establishing this DTLS tunnel between the MDD and KMF and implementing the
protocol defined in this document, it is possible for the MDD to facilitate the
establishment of a secure DTLS association between an endpoint and the KMF in
order for the endpoint to receive E2E and HBH key material.  At the same time,
the KMF can securely provide the HBH key material to the MDD.

# Conventions Used In This Document

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL
NOT**", "**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and
"**OPTIONAL**" in this document are to be interpreted as described in RFC 2119
[@!RFC2119] when they appear in ALL CAPS.  These words may also appear in this
document in lower case as plain English words, absent their normative meanings.

# Tunneling Concept

A DTLS association (tunnel) is established between the MDD and the KMF.  This
tunnel is used to relay DTLS messages between the endpoint and KMF, as depicted
in (#fig-tunnel):

{#fig-tunnel align="center"}
```
                        +------------------------------+
+-----+                 |        Switching MDD         |
|     |                 |                              |
| KMF |<===============>|<============+ (Tunnels DTLS) |
|     |     DTLS        |             v                |
+-----+     Tunnel      +------------------------------+
                                      ^
                                      |             
                                      | DLTS-SRTP
                                      |
                                      v
                                 +----------+
                                 | Endpoint |
                                 +----------+
```
Figure: DTLS Tunnel to KMF

The three entities involved in this communication flow are the endpoint, the
MDD, and the KMF. The behavior of each entity is described in
(#tunneling-procedures).

The KMF is a logical function that might might be co-resident with a key
management server operated by an enterprise, reside in one of the endpoints
participating in the conference, or elsewhere that is trusted with E2E key
material.  This document does not preclude any location, it only requires that
the KMF not allow the MDD to gain access to the E2E key material by following
the operations defined.

# Example Message Flows

This section provides an example message flow to help clarify the procedures
described later in this document.  Note that it is assumed that a mutually
authenticated DTLS association is already established between the MDD and KMF
for the purpose of sending tunneled messages.

Once the tunnel is established, it is possible for the MDD to relay the DTLS
messages between the endpoint and the KMF. (#fig-message-flow) shows a message
flow wherein the endpoint uses DTLS-SRTP to establish an association with the
KMF.  In the process, the MDD shares its supported SRTP protection profile
information and the KMF shares HBH key material and selected cipher with the
MDD.  The message used to tunnel the DTLS messages is named "Tunnel" and can
include Profiles or Key Info data.

{#fig-message-flow align="center"}
```
Endpoint                     MDD                       KMF
    |                         |                         |
    |------------------------>|========================>|
    | DTLS handshake message  | Tunnel + Profiles       |
    |                         |                         |
    |<------------------------|<========================|
    | DTLS handshake message  |                  Tunnel |
    |                         |                         |
       .... may be multiple handshake messages ...
    |------------------------>|========================>|
    | DTLS handshake message  | Tunnel + Profiles       |
    |                         |                         |
    |<------------------------|<========================|
    |  DTLS handshake message |       Tunnel + Key Info |
    |    (including Finished) |                         |
    |                         |                         |
```
Figure: Sample DTLS-SRTP Exchange via the Tunnel

Each of these tunneled messages on the right-hand side of (#fig-message-flow) is
a message of type "Tunnel" (see (#tunneling-protocol)).  Each message contains
the following information:

* Protocol version
* Association ID
* DTLS message being tunneled
    
Additionally, all messages sent by the MDD will contain MDD-supported SRTP
protection profiles at the end of the Tunnel message.  The KMF will need to
select a common profile supported by both the endpoint and the MDD to ensure
that hop-by-hop operations can successfully be performed.

Further, the KMF will provide the SRTP [@!RFC3711] key material for HBH
operations at the time it sends a DTLS Finished message to the endpoint via the
tunnel.  The MDD would extract this Key Info when received and use it for
hop-by-hop encryption and authentication.  The delivery of the keying
information along with the completion of the DTLS handshake ensures the delivery
of the keying information is fate shared with completion of the DTLS handshake
so that the MDD is guaranteed to have the HBH keying information before it
receives any media that is encrypted or authenticated with that key.

# Tunneling Procedures

The following sub-sections explain in detail the expected behavior of the
endpoint, the media distribution device (MDD), and the key management function
(KMF).

It is important to note that the tunneling protocol described in this document
is not an extension to TLS [@!RFC5246] or DTLS [@!RFC6347].  Rather, it is a
protocol that transports endpoint or KMF-generated DTLS messages as data inside
of the DTLS association established between the MDD and KMF.

## Endpoint Procedures

The endpoint follows the procedures outlined for DTLS-SRTP [@!RFC5764] in order
to establish the keys used for encryption and authentication.  The endpoint uses
the normal procedures to establish a DTLS-SRTP association with the KMF.

## Media Distribution Device Tunneling Procedures

The MDD, acting as a client, establishes a mutually authenticated DTLS
association between itself and a KMF to relay DTLS messages from any number of
endpoints to that KMF.  This MDD initiated DTLS association is called a "tunnel"
to differentiate it from the DTLS associations initiated by endpoints.

The MDD **MUST** establish a tunnel with the KMF in advance of, or no later than
the point, when an endpoint attempts to establish a DTLS association with the
KMF.

The MDD **MUST** forward all messages received from an endpoint for a given DTLS
association through the same tunnel if more than one tunnel has been established
between it and a KMF.  An MDD is not precluded from establishing more than one
tunnel to a given KMF.

The MDD **MUST** assign a tunnel-unique "association identifier" for each
endpoint-initiated DTLS association and include it in all messages forwarded to
the KMF.  The KMF will subsequently include in this identifier in all messages
it sends so that the MDD can map messages received via a given tunnel and
forward those messages to the correct endpoint.

The tunnel protocol enables the KMF to separately provide HBH key material to
the MDD for each of the individual endpoint DTLS associations, though the MDD
cannot decrypt messages between the KMF and endpoints.

When a DTLS message is received by the MDD from an endpoint, it forwards the UDP
payload portion of that message to the KMF encapsulated in a Tunnel + Profiles
message (see (#tunneling-protocol)).  The Tunnel + Profiles message allows the
MDD to signal which SRTP protection profiles it supports for HBH operations.

The MDD **MUST** support the same list of protection profiles for the life of a
given endpoint's DTLS association, which is represented by the association
identifier.

When a message from the KMF includes "Key Info," the MDD **MUST** extract the
cipher and key material conveyed in order to subsequently perform HBH encryption
and authentication operations for RTP and RTCP packets sent between it and an
endpoint.  Since the HBH key material will be different for each endpoint, the
MDD uses the tunnel-unique association identifier included by the KMF to ensure
that the HBH material is used with the correct endpoint.

The MDD **MUST** forward all messages received from either the endpoint or the
KMF to ensure proper communication between those two entities.

## Key Management Function Tunneling Procedures

The KMF **MUST** be prepared to establish one or more tunnels (DTLS
associations) with the MDD for the purpose of relaying DTLS messages between an
endpoint and the KMF.  The KMF acts as a server and the MDD acts as a client to
establish a tunnel.

When the MDD relays a DTLS message from an endpoint, the MDD will include an
association identifier that is unique per endpoint-originated DTLS association
and is relayed via the tunnel.  The association identifier remains constant for
the life of the DTLS association.  The KMF identifies each distinct
endpoint-originated DTLS association by the association identifier and the
tunnel over which the DTLS association was established.  The KMF **MUST** use
the same association identifier in messages it sends to the endpoint and
**MUST** send all messages for a given DTLS association via the same tunnel.
This is to ensure that the MDD can properly relay messages to the correct
endpoint.

The KMF extracts tunneled DTLS messages and acts on those messages as if the
endpoint had established the DTLS association directly with the KMF.  The
handling of the messages and certificates is exactly the same as normal
DTLS-SRTP procedures between endpoints.

When sending a message to the endpoint, the KMF encapsulates the DTLS message
inside a Tunnel message (see (#tunneling-protocol)).  At the point the DTLS
handshake completes with the endpoint, the KMF will send a DTLS Finished message
(perhaps along with other messages) to the endpoint.  As it sends the Finished
message, the KMF will also provide key information to the MDD.  This is
accomplished by utilizing the Tunnel + Key Info message.  The Key Info includes
the selected cipher, MKI [@!RFC3711] value (if any), SRTP master keys, and SRTP
master salt values.

Since the KMF acts as the server in the DTLS-SRTP exchanges with the endpoint,
it will negotiate with the endpoint which cipher to employ for encryption and
authentication.  To ensure successful HBH operations, the ciphers negotiated by
the KMF **MUST** be a cipher that is supported by the MDD.

# Tunneling Protocol

The tunneling protocol is transmitted over the DTLS association established
between the MDD and KMF as application data.  The basic message is referred to
as the Tunnel message.  The MDD will append supported SRTP protection profiles
to all Tunnel messages it sends, forming the Tunnel + Profiles message.  The KMF
will append information necessary for the MDD to perform HBH encryption and
authentication as it transmits the DTLS Finished message to the endpoint,
forming the Tunnel + Key Info message.  The Tunnel, Tunnel + Profiles, and
Tunnel + Key Info messages are detailed in the following sub-sections.

## Tunnel Message

Tunneled DTLS messages are transported via the "Tunnel" message as application
data between the MDD and the KMF.  The "Tunnel" Message has the following
format:

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+---------------+---------------+-------------------------------+
| Version (H)   | Version (L)   |                               |
+---------------+---------------+                               |
|                                                               |
|   Association Identifier                                      |
|                                                               |
|                               +-------------------------------+
|                               |  DTLS Message Length          |
+-------------------------------+-------------------------------:
:                                                               :
:                     Tunneled DTLS Message                     :
:                                                               :
+---------------------------------------------------------------+
```

Version (H): This is the protocol major version number (set to 0x01).

Version (L): This is the protocol minor version number (set to 0x00).

Association Identifier: This is the 16-octet association identifier.

DTLS Message Length: Length in octets of following Tunneled DTLS Message.

Tunneled DTLS Message: This is the DTLS message exchanged between the endpoint
and KMF.

## Tunnel Message + Profiles

Each Tunnel message transmitted by the MDD contains an array of SRTP protection
profiles at the end of the message.  The format of the message is shown below:

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+---------------+---------------+-------------------------------+
| Version (H)   | Version (L)   |                               |
+---------------+---------------+                               |
|                                                               |
|                     Association Identifier                    |
|                                                               |
|                               +-------------------------------+
|                               |  DTLS Message Length          |
+-------------------------------+-------------------------------:  
:                                                               :
:                     Tunneled DTLS Message                     :
:                                                               :
+---------------+---------------+-------------------------------+
| Data Type     | Length        |                               : 
+---------------+---------------+                               : 
:                      Protection Profiles                      :
+---------------------------------------------------------------+
```

Beyond the fields included in the Tunnel message, this message introduces the
following additional fields.

Data Type: Indicates the type of data that follows.  For MDD supported SRTP
protection profiles, this value is 0x01.

Length: This is the length in octets of the protection profiles.  This length
must be greater than or equal to 2.

Protection Profiles: This is an array of two-octet SRTP protection profile
values as per [@!RFC5764], with each value represented in network byte order.

## Tunnel Message + Key Info

When the KMF has key information to share with the MDD so it can perform HBH
encryption and authentication on received media packets, the KMF will send a
Tunnel message with the Key Info appended as shown below:

```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+---------------+---------------+-------------------------------+
| Version (H)   | Version (L)   |                               |
+---------------+---------------+                               |
|                                                               |
|   Association Identifier                                      |
|                                                               |
|                               +---------------+---------------+
|                               |  DTLS Message Length          |
+-------------------------------+-------------------------------: 
:                                                               :
:                     Tunneled DTLS Message                     :
:                                                               :
+---------------+-------------------------------+---------------+
| Data Type     | MKI Length    | Master Key Identifier (MKI)   ~
+---------------+---------------+-------------------------------+
| CWSMK Length                  |                               :
+-------------------------------+                               :
:                 Client Write SRTP Master Key                  :
+-------------------------------+-------------------------------+
| SWSMK Length                  |                               :
+-------------------------------+                               :
:                 Server Write SRTP Master Key                  :
+-------------------------------+-------------------------------+
| CWSMS Length                  |                               :
+-------------------------------+                               :
:                 Client Write SRTP Master Salt                 :
+-------------------------------+-------------------------------+
| SWSMS Length                  |                               :
+-------------------------------+                               :
:                 Server Write SRTP Master Salt                 :
+---------------------------------------------------------------+
```

Beyond the fields included in the Tunnel message, this message introduces the
following additional fields.

Data Type: Indicates the type of data that follows.  For key information, this value is 0x02.

MKI Length: This is the length in octets of the MKI field.  A value of zero
indicates that the MKI field is absent.

CWSMK Length: The length of the "Client Write SRTP Master Key" field.

Client Write SRTP Master Key: The value of the SRTP master key used by the client (endpoint).

SWSMK Length: The length of the "Server Write SRTP Master Key" field.

Server Write SRTP Master Key: The value of the SRTP master key used by the server (MDD).

CWSMS Length: The length of the "Client Write SRTP Master Salt" field.

Client Write SRTP Master Salt: The value of the SRTP master salt used by the client (endpoint).

SWSMS Length: The length of the "Server Write SRTP Master Salt" field.

Server Write SRTP Master Salt: The value of the SRTP master salt used by the server (MDD).

# To-Do List

The MDD and KMF may need to coordinate or exchange a "conference identifier"
common to the endpoints a MDD is bridging together.  Alternatively, information
the KMF needs to know about conference-to-endpoint correlations might be
satisfied by getting info directly from the endpoints, or some trusted entity on
their behalf, via some other means.  Need to revisit this design choice in the
context of all the alternatives.

# IANA Considerations

There are no IANA considerations for this document.

# Security Considerations

TODO - Much more needed.

The encapsulated data is protected by the DTLS session from the endpoint to KMF
and the MDD is merely an on path entity. This does not introduce any additional
security concerns beyond a normal DTLS-SRTP session.

The HBH keying material is protected by the mutual authenticated DTLS session
between the MDD and KMF. The KMF MUST ensure that it only forms associations
with authorized MDDs or it could hand HBH keying information to untrusted
parties.

The supported profile information send from the MDD to the KMF is not
particularly sensitive as it only provides the crypt algorithms supported by the
MDD but it is still protected by the DTLS session from the MDD to KMF.

# Acknowledgments

The author would like to thank David Benham and Cullen Jennings for reviewing
this document and providing constructive comments.

{backmatter}
