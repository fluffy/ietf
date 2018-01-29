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

    [[author]]
    initials = "S."
    surname = "Nandakumar"
    fullname = "Suhas Nandakumar"
    organization = "Cisco"
      [author.address]
      email = "snandaku@cisco.com"

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
to ICE in  [@I-D.ietf-ice-rfc5245bis] and Trickle ICE [@I-D.ietf-ice-trickle] 
have indeed help improve its performance and the way the connectivity checks 
are performed. However enforcing stringent global pacing requirements, 
coupled timing dependencis between the ICE agents, the need for symmetric 
connection setup, for example has rendered the protocol inflexible for 
innovation and increasingly difficult to apply and debug in a dynamic 
network and evolving application contexts.

This specification defines Snowflake, where like in ICE, both sides gather a
set of address candidates that may work for communication. Howevver, instead of 
both sides trying to synchronize connectivity checks in time-coupled fashion, 
the sending side acts as a slave and sends STUN packets wherever the receiving
side tells it to and when it is told to do so. The receiving sides is free to choose 
whatever algorithm and timing it wants to find a path that works. The sender and 
receiver roles are reversed for media flow in the opposite direction. 

The current version of the draft builds on its original instantiation submitted in
year 2015 as https://datatracker.ietf.org/doc/draft-jennings-mmusic-ice-fix/


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

- Receiver Agent: Software agent capable of receiving data stream(s).
An Snowflak Receiver Agent can be 

- Snowflake Agent: An Snowflake Agent implementation is
expected to have a STUN Client implementation at the minimum for
gathering candidates and performing connectivity checks.

- Signaling Server: Publicly reachable Server in the cloud accessible 
by both the Sender and the receiver agents. Acts as backchannel/message 
bus for carrying signals between the Snowflake agents

- STUN Server: Optional component for determining the public facing 
transport address of an agent behind NAT

- TURN Server/Media Router: Recommended component acting as media relay 
between the agents. A TURN Server can also act as backchannel in certain 
instantiations.

- BackChannel: A dedicated channel used by the agents to convey Snowflake
messages. Can be a Signaling Server/Turn Server that can be reached 
publicly by the agents.
 
## Protocol Workings

The basic principle here is, each side (Receiver Agent) is responsible 
for discovering a viable path for it's incoming media. It does so by 
indicating the addresses for the Sender to verify the connectivity.
Once a viable path is established, the Sender Agent continues to
transmit the media. This processs deviates from ICE by negating the need 
for agent's role (controlled vs controlling), nomination procedures 
(aggressive vs passive) and tightly coupled symmetric checklists 
validation.


As a precursor to connectivity establishment,  the protocol 
assumes that there exists a dedicated backchannel that a Receiver Agent 
uses to invoke operations on the Sender Agent to trigger test for 
connectivity or perform updates for the same as the session progresses.

The protocol starts with the Sender Agent conveying its intention to 
send media via the backchannel to the Receiver agent. The Sender can
provide additional details on type of media, its quality requirements 
as part of its "Media Send Intention" message.

On receiving the Sender's media send intention message, the 
Receiver Agent gathering the candidates defined by its local policies or
previous knowledge of connectivity checks. The candidate(s) along with 
additional attributes (priority, type for example) are then exchanged by 
invoking an appropriate operation (Connectivity Check) on the Sender Agent. 
An message of type "Test Candidates" is sent with encapsualted 
candidate information. This is equivalent to the way the ICE candidates 
are trickled in the Trickle ICE via a signaling server.


On the Sender Agent, the candidates thus obtained (in the Test Candidates message) 
are used by the STUN client implementation to carry out connectivity checks 
towards the receiver. The connectivity checks are performed along the media 
path as its done today. This opens up the required local pinholes as needed and 
are further maintained by the Sender for the duration of the session. 

The Sender Agent then requests the Receiver Agent to send it a "STUN Ping" 
message from a given address (source of connectivity check) to a specific
candidate provided in the "Test Candidates" message. This is done via 
sending "STUN Ping Request" message by populating the aforementioned 
information. Eventually, the Receiver Agent follows up with a "STUN Ping"
message 
do 
"STUN Ping Request" from a
given location to one of a specific candidates.  If this works, it
knows it has a viable path.


Failure in connectivity checks (timeouts/icmp errors) are reported via 
"Test Candidate Result" message to the Receiver Agent. 





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

Below picture captures one instance of protocol exchange where
the Receiver Agent indicates the Sender Agent to carry out the
connectivity checks. One can envision mulitple executions of
the protocol as and when receiver has updated his knowledge
of addresses or priorities or bandwidth availability.

~~~
           Snowflake Information Flow Model 
        ---------------------------------------

       Sender Agent   BackChannel  Receiver Agent
          |              |              |
          |              |              |
          |              |              |
          |(1) connect to backchannel   |
          |.............................|
          |              |              |
          |              |              |
          |(2) Media Send Intention (via backchannel)
          |---------------------------->|
          |              |              |
          |              |              |
          |              |              |Gather candidate address(es)
          |              |              |
          |              |              |
          |              |              |
          |              |(3) Test Candidate(s) [address,priority..]
          |              |<-------------|
          |              |              |
          |              |              |
          |(4) Test Candidate(s) [address,priority..]
          |<-------------|              |
          |              |              |
          |              |              |
          |(5) STUN connectivity check  |
          |---------------------------->|
          |              |              |
          |              |              |
          |              |(6) STUN Check Confirm (transactionId)
          |              |<-------------|
          |              |              |
          |              |              |
          |(7) STUN Check Confirm (transactionId)
          |<-------------|              |
          |              |              |
          |              |              |
          |(8) Found a viable path, transmit media
          |.............................|
          |              |              |
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

