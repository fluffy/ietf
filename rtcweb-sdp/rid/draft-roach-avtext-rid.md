---
title: "RTP Payload Format Constraints"
abbrev: rid
docname:  draft-roach-avtext-rid
date: 2015-11-16
category: std
ipr: trust200902

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
-
    ins: A.B. Roach
    name: Adam Roach
    org: Mozilla
    email: adam@nostrum.com
-
    ins: S. Nandakumar
    name: Suhas Nandakumar
    org: Cisco Systems
    email: snandaku@cisco.com
-
    ins: P. Thatcher
    name: Peter Thatcher
    org: Google
    email: pthatcher@google.com

normative:
  RFC2119:
  RFC3550:
  RFC5285:
  RFC7656:
  I-D.ietf-avtext-sdes-hdr-ext:

informative:
  I-D.ietf-mmusic-rid:
  I-D.ietf-mmusic-msid:


--- abstract

This document defines and registers an RTCP SDES item, RID, for identification
of RTP streams associated with encoded and dependent streams.

--- middle

# Introduction {#sec-intro}

RTP sessions frequently consist of multiple streams, each of which is
identified at any given time by its SSRC; however, the SSRC associated
with a stream is not guaranteed to be stable over its lifetime. Within
a session, these streams can be tagged with a number of identifiers,
including CNAMEs and  MSIDs {{I-D.ietf-mmusic-msid}}. Unfortunately,
none of these have the proper ordinality to refer to an individual stream;
all such identifiers can appear in more than one stream at a time.
While approaches that use unique Payload Types (PTs) per stream have
been used in some applications, this is a semantic overloading of that
field, and one for which its size is inadequate: in moderately complex
systems that use PT to uniquely identify every potential combination of
codec configuration and unique stream, it is possible to simply run
out of values.

To address this situation, we define a new RTCP SDES identifier that
uniquely identifies a single stream. A key motivator for defining
this identifier is the ability to differentiate among different
encodings of a single Source Stream that are sent simultaneously
(i.e., simulcast). This need for unique identification extends to
Dependent Streams (i.e., simulcast layers used by a layered codec).

At the same time, when Redundancy RTP Streams are in use, we also need an
identifier that connects such streams to the RTP stream for which they are
providing redundancy. To that end, when this new identifier is in use, it
appears (and contains the same value) in both in the Redundancy RTP Stream as
well as the stream it is correcting.

For lack of a better term, we have elected to call this term "RID,"
which loosely stands for "RTP stream IDentifier." It should be noted
that this isn't an overly-precise use of the term "RTP Stream," due
to the lack of an existing well-defined term for the construct we
are attempting to identify. See {{sec-term}} for a formal definition
of the exact scope of a RID.

The use of RIDs in SDP is described in {{I-D.ietf-mmusic-rid}}.

# Key Words for Requirements

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
document are to be interpreted as described in {{RFC2119}}

# Terminology {#sec-term}

In this document, the terms "Source Stream", "Encoded Stream," "RTP Stream,",
"Source RTP Stream", "Dependent Stream", "Received RTP Stream", and
"Redundancy RTP Stream" are used as defined in {{RFC7656}}.

For Encoded Streams, the RID refers to the "Source RTP Stream" as defined by
{{RFC7656}} Section 2.1.10.  For Dependent Streams, it refers to the RTP Stream
that, like the Source RTP Stream of an Encoded Stream, is the RTP Stream that
is not a Redundancy RTP Stream.

For clarity, when RID is used, Redundancy RTP Streams that can be used to
repair Received RTP Streams will use the same RID value as the Received
RTP Stream they are intended to be combined with.

# Usage of 'rid' in RTP and RTCP

The RTP fixed header includes the payload type number and the SSRC values of
the RTP stream.  RTP defines how you de-multiplex streams within an RTP
session; however, in some use cases, applications need further identifiers in
order to effectively map the individual RTP Streams to their equivalent
payload configurations in the SDP.

This specification defines a new RTCP SDES item {{RFC3550}}, 'RID', which is
used to carry these identifiers within RTCP SDES packets.  This makes it
possible for a receiver to associate received RTP packets (identifying the
Source RTP Stream) with a media description having the format constraint
specified.

This specification also uses the RTP header extension for RTCP SDES items
{{I-D.ietf-avtext-sdes-hdr-ext}} to allow carrying RID information in RTP
packets. This allowes correlation at stream startup, or after stream changes
where the use of RTCP may not be sufficiently responsive.

## RTCP 'RID' SDES Extension

~~~~~~~

     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |      RID=TBD  |     length    | rid                         ...
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

~~~~~~~

The rid payload is UTF-8 encoded and is not null-terminated.

>RFC EDITOR NOTE: Please replace TBD with the assigned SDES identifier value.


## RTP 'RID' Header Extension

Because recipients of RTP packets will typically need to know which "a=rid"
constraints they correspond to immediately upon receipt, this specification
also defines a means of carrying RID identifiers in RTP extension headers,
using the technique described in {{I-D.ietf-avtext-sdes-hdr-ext}}.

As described in that document, the header extension element can be encoded
using either the one-byte or two-byte header, and the
identification-tag payload is UTF-8 encoded, as in SDP.

As the identification-tag is included in an RTP header extension, there should
be some consideration about the packet expansion caused by the
identification-tag. To avoid Maximum Transmission Unit (MTU) issues for the
RTP packets, the header extension's size needs to be taken into account when
the encoding media.  Note that set of header extensions included in the packet
needs to be padded to the next 32-bit boundary {{RFC5285}}.

It is RECOMMENDED that the identification-tag is kept short.  In many cases, a
one-byte tag will be sufficient; it is RECOMMENDED that implementations use
the shortest identifier that fits their purposes.

# IANA Considerations {#sec-iana}

## New SDES item

>RFC EDITOR NOTE: Please replace RFCXXXX with the RFC number of this document.

>RFC EDITOR NOTE: Please replace TBD with the assigned SDES identifier value.

This document adds the MID SDES item to the IANA "RTCP SDES item types"
registry as follows:

~~~~~~~~~~~~~~~

           Value:          TBD
           Abbrev.:        RID
           Name:           Restriction Identification
           Reference:      RFCXXXX

~~~~~~~~~~~~~~~

# Security Considerations

The actual identifiers used for RIDs are expected to be opaque. As such, they
are not expected to contain information that would be sensitive, were it
observed by third-parties.

#  Acknowledgements
Many thanks for review and input from Cullen Jennings, Magnus Westerlund,
Colin Perkins, Peter Thatcher, Jonathan Lennox, and Paul Kyzivat.
