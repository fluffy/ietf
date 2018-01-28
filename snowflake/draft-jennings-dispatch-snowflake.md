%%%
    title = "Snowflake - A Lighweight, Asymmetric, Flexible, Receiver Driven Connectivity Establishment"
    abbrev = "snowflake"
    category = "std"
    docName = "draft-jennings-dispatch-snowflake"
    ipr = "trust200902"

    [pi]
    symrefs = "yes"
    sortrefs = "yes"
    toc = "yes"

    [[author]]
    initials = "C."
    surname = "Jennings"
    fullname = "Cullen Jennings"
    organization = "Cisco"
      [author.address]
      email = "fluffy@iii.ca"


%%%

.# Abstract

Interactive Connectivity Establishment (ICE) (RFC5245) 
defines protocol machinery for 2 peers to discover each 
other and establish connectivity in order to send and receive 
Media Streams.

This draft raises some issues inherent in the assumptions with 
ICE and proposes a lightweight receiver driven protocol for 
asymmetric connecitivity establishment.

{mainmatter}


# Introduction

ICE was designed over a decade and certain assumptions about the
network topology, timing considerations, application complexity 
have drastically changed since then. Newer additions/clarifications 
to ICE in ICEBis and Trickle ICE have indeed help improve its performance 
and the way the connectivity checks are performed. However enforcing
stringent global pacing requirements, coupled timing dependencis between
the agents, the need for symmetric connection setup, for example
has rendered the protocol inflexible for innovation and increasingly 
difficult to apply and debug in a dynamic network and application contexts.


# Terminology

In this document, the key words "MUST", "MUST NOT", "SHOULD", "SHOULD
NOT", "MAY", and "OPTIONAL" are to be interpreted as described in RFC
2119 [@!RFC2119] and indicate requirement levels for compliant
implementations.



# Problem Statement

ICE was developed roughly ten years ago and several things have been 
learned that could be improved:

1. It is spectacularly difficult to debug and analyze failures or 
successes in ICE or develop good automated tests. Many 
implementations have had significant bugs for long periods of time.
This is further complicated by the timing dependency as explained
next.

2. It is timing dependent.  It relies on both sides to to do
something (candidate pairing, validation) at roughly the same time 
and that ability to do this goes down with the number of interfaces 
and candidates being handled.  Mobile interfaces, dual stack agents
make this situation worse.

3. Differences in interpretation and implementation of the protocol
with respect to aggressive vs normal nomination may hinder rapid
convergence or end up in agents choosing suboptimal routes.

4. It does not discover asymmetric routes. For example UDP leaving
a device may work just fine even thought UDP coming into that 
device does not work at all.

5. May deployments consider using a TURN/Media Router in their topology 
today in order to support fast session start or ensuring reliable
connection (although with small latency overhead). 
At the time ICE was designed it was not understood if this would be too 
expensive or not so ICE works without TURN but better with it.

6. The asymmetric nature of the controlling / controlled roles has caused
many interoperability problems and bugs. Also Role conflicts might 
lead to degrade connection setup depending on which side gets the
the controlling role.

7. Priorities are complicated in dual stack world and ICE is brittle
to changes in this part of the algorithm. Although there are advises 
in dual-stack-fairness specification that might help here.


# Snowflake for connectivity establishment

Snowflake is a light weight, asymmetric, flexible
and receiver controlled protocol for end points to establish 
connectivity between them. 

Following various subsections go in further details of its
working

## System Components 
A typical Snowflake operating model has the following components

- Sender Agent: Software agent interested in sending data stream(s) 
to a remote receiver.

- Receiver Agent: Software agent capable of receiving data stream(s)

- Signaling Server: Publicly reachable Server in the cloud accessible 
by both the Sender and the receiver agents. Acts as backchannel/message 
bus for carrying signals between the Snowflake agents

- STUN Server: Optional component for determining the public facing 
transport address of an agent behind NAT

- TURN Server/Media Router: Recommended component acting as media relay 
between the agents. It is recommended to act as backchannel/message bus 
similar to the Signaling Server.

 
## Protocol Workings

To begin there exists a dedicated backchannel either in the form of a 
Signaling Server or a TURN Server that a Receiver Agent uses to invoke 
operations on the Sender Agent to trigger test for connectivity or 
perform updates for the same as the session progresses.
Frow now on, the term backchannel will be used irrespective of its 
physical instantiation in this document.

The basic principle here is, each side (Receiver Agent) is responsible 
for discovering a viable path for it's incoming media and the 
other end (Sender Agent) sends media to the location indicated by
the Sender Agent. This deviates from ICE by negating the need for
agent's role (controlled vs controlling) and nomination procedures 
(aggressive vs passive).

The protocol starts by Receiver Agent gathering the candidates defined
by its local policies. The candidate along with additional 
attributes (priority, type for example) are the exchaged by invoking 
an appropriate operation on the Sender Agent via the backchannel.

On the sender agent, the candidates thus obtained are used by the
STUN client to carry out connectivity checks towards the receiver.
This opens up local pinholes and are further maintained by the 
sender for the duration of the session.  The Sender Agent then tells
the far end using the backchannel to send it a STUN ping from a
given location to one of a specific candidates.  If this works, it
knows it has a viable path.

The above set of procedures are continously performed during the 
lifetime of the session as and when either side determines there
is a better candidate for receiving the media. Such a decision 
is totally defined by the local policies and can be performed 
independently of the other side.

Also to ensure receiver's consent for sending the media, the 
sender should follow the procedures in XXXX_consent_freshness 
to get the consent and it is also RECOMMENDED that the 
sender perform consent procedures via  the backchannel as well.
This will ensure reliable consent verification in the case 
STUN messages are lost.


It is also highly RECOMMENDED the the agents support multiplexing
various datastreams wherever possible to improve connectivity times
and success probabilities

~~~

Picture goes here

~~~

## Advantages

###  Diagnostics

This makes it very easy to see which outbound connection were sent
from side A to open a pin hole, then when side A asked B to send a
test PING and if B received that.  It becomes easier to set up a
client with an automated test jig that tests all the combinations and
makes sure they work as you only need to test receiving capability
and sender capability independently.

### Timing

This more or less removes the timing complexity by allowing both
sides to be responsible for their own timing.  If it turns out that
we can pace things much faster than 50ms then this allows us to 
take advantage of that without both sides upgrading at the same time.  
If we end up with a lot more candidates due to v6, mobile etc, this removes 
the issue we have today where a path might have worked but the two sides 
did not find it due to timing issues.

### Asymmetric Media

This allows media to be sent in one direction over a path that does
not work in the reverse direction.

### Fast Start 

Given there exists a dedicated backchannel, this protocol can speed 
up the media flow by using TURN server for the backchannel. Once
either agents learn more about the candidates, each can update the
other side to ensure a better low latency path is used for media.

### Innovation and Experimentation

TODO

### Backwards Compatibility

At IETF 92 I thought it would be possible to design a backwards
compatibly solution that did roughly this.  That might be possible if
all the major implementations fully implemented the current ICE spec
but many of them do not.  Even worse, they implement different parts.
My proposal here is more or less make an ICE2.  ICE2 advertises the
same candidates as ICE but also adds some SDP signaling to indicate
the device supports ICE and ICE2.

In the short term we would need device such as web browsers would be
requires to support ICE and the ICE2 extensions here but in the
future we could move to devices that only did ICE2.

The main mechanisms between ICE and ICE2 are largely the same but the
way paths are chosen and used is somewhat different.


# IANA Consideration 

TODO 


# Security Considerations 

TODO

# Acknowledgements 

TODO

