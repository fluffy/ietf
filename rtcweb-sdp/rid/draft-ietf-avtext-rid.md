---
title: "RTP Stream Identifier Source Description (SDES)"
abbrev: RtpStreamId SDES
docname:  draft-ietf-avtext-rid-05
date: 2016-07-06
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
  RFC3550:
  RFC5285:
  RFC7656:
  I-D.ietf-avtext-sdes-hdr-ext:

informative:
  I-D.ietf-mmusic-msid:


--- abstract

This document defines and registers two new RTCP SDES items.  One, named
RtpStreamId, is used for unique identification of RTP streams. The other,
RepairedRtpStreamId, can be used to identify which stream a redundancy RTP
stream is to be used to repair.


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

To address this situation, we define a new RTCP SDES identifier, RtpStreamId,
that uniquely identifies a single RTP stream. A key motivator for defining
this identifier is the ability to differentiate among different encodings of a
single Source Stream that are sent simultaneously (i.e., simulcast). This need
for unique identification extends to dependent streams (e.g., where layers
used by a layered codec are transmitted on separate streams).

At the same time, when redundancy RTP streams are in use, we also need an
identifier that connects such streams to the RTP stream for which they are
providing redundancy. For this purpose, we define an additional SDES identifier,
RepairedRtpStreamId. This identifier can appear only in packets associated
with a redundancy RTP stream. They carry the same value as the RtpStreamId
of the RTP stream that the redundant RTP stream is correcting.

# Terminology {#sec-term}

In this document, the terms "source stream", "encoded stream," "RTP stream",
"source RTP stream", "dependent stream", "received RTP stream", and
"redundancy RTP stream" are used as defined in {{RFC7656}}.

# Usage of RtpStreamId and RepairedRtpStreamId in RTP and RTCP

The RTP fixed header includes the payload type number and the SSRC values of
the RTP stream.  RTP defines how you de-multiplex streams within an RTP
session; however, in some use cases, applications need further identifiers in
order to effectively map the individual RTP Streams to their equivalent
payload configurations in the SDP.

This specification defines two new RTCP SDES items {{RFC3550}}.
The first item is 'RtpStreamId', which is
used to carry RTP stream identifiers within RTCP SDES packets.  This makes it
possible for a receiver to associate received RTP packets (identifying the
RTP stream) with a media description having the format constraint
specified. The second is 'RepairedRtpStreamId', which can be used in redundancy
RTP streams to indicate the RTP stream repaired by a redundancy RTP stream.

To be clear: the value carried in a RepairedRtpStreamId will always match the
RtpStreamId value from another RTP stream in the same session. For example,
if a source RTP stream is identified by RtpStreamId "A", then any
redundancy RTP stream that repairs that source RTP stream will contain
a RepairedRtpStreamId of "A" (if this mechanism is being used to perform
such correlation). These redundant RTP streams may also contain their own
unique RtpStreamId.

This specification also uses the RTP header extension for RTCP SDES items
{{I-D.ietf-avtext-sdes-hdr-ext}} to allow carrying RtpStreamId and
RepairedRtpStreamId values in RTP
packets. This allows correlation at stream startup, or after stream changes
where the use of RTCP may not be sufficiently responsive. This speed
of response is necessary since, in many cases, the stream cannot be properly
processed until it can be identified.

## RTCP 'RtpStreamId' SDES Extension

~~~~~~~

     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |RtpStreamId=TBD|     length    | RtpStreamId                 ...
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

~~~~~~~

The RtpStreamId payload is UTF-8 encoded and is not null-terminated.

>RFC EDITOR NOTE: Please replace TBD with the assigned SDES identifier value.

## RTCP 'RepairedRtpStreamId' SDES Extension

~~~~~~~

     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |Repaired...=TBD|     length    | RepairRtpStreamId           ...
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

~~~~~~~

The RepairedRtpStreamId payload is UTF-8 encoded and is not null-terminated.

>RFC EDITOR NOTE: Please replace TBD with the assigned SDES identifier value.


## RTP 'RtpStreamId' and 'RepairedRtpStreamId' Header Extensions

Because recipients of RTP packets will typically need to know which streams
they correspond to immediately upon receipt, this specification
also defines a means of carrying RtpStreamId and RepairedRtpStreamId
identifiers in RTP extension headers, using the technique described in
{{I-D.ietf-avtext-sdes-hdr-ext}}.

As described in that document, the header extension element can be encoded
using either the one-byte or two-byte header, and the
identification-tag payload is UTF-8 encoded, as in SDP.

As the identifier is included in an RTP header extension, there should
be some consideration given to the packet expansion caused by the
identifier. To avoid Maximum Transmission Unit (MTU) issues for the
RTP packets, the header extension's size needs to be taken into account when
the encoding media.  Note that set of header extensions included in the packet
needs to be padded to the next 32-bit boundary {{RFC5285}}.

In many cases, a one-byte identifier will be sufficient to distinguish streams
in a session; implementations are strongly encouraged to use
the shortest identifier that fits their purposes. Implementors are warned,
in particular, not to include any information in the identifier that is
derived from potentially user-identifying information, such as user ID
or IP address. To avoid identification of specific implementations based
on their pattern of tag generation, implementations are encouraged to use
a simple scheme that starts with the ASCII digit "1", and increments by one
for each subsequent identifier.

# IANA Considerations {#sec-iana}

## New RtpStreamId SDES item

>RFC EDITOR NOTE: Please replace RFCXXXX with the RFC number of this document.

>RFC EDITOR NOTE: Please replace TBD with the assigned SDES identifier value.

This document adds the RtpStreamId SDES item to the IANA "RTCP SDES item types"
registry as follows:

~~~~~~~~~~~~~~~

           Value:          TBD
           Abbrev.:        RtpStreamId
           Name:           RTP Stream Identifier
           Reference:      RFCXXXX

~~~~~~~~~~~~~~~

## New RepairRtpStreamId SDES item

>RFC EDITOR NOTE: Please replace RFCXXXX with the RFC number of this document.

>RFC EDITOR NOTE: Please replace TBD with the assigned SDES identifier value.

This document adds the RepairedRtpStreamId SDES item to the IANA "RTCP SDES item types"
registry as follows:

~~~~~~~~~~~~~~~

           Value:          TBD
           Abbrev.:        RepairedRtpStreamId
           Name:           Repaired RTP Stream Identifier
           Reference:      RFCXXXX

~~~~~~~~~~~~~~~

## New RtpStreamId Header Extension URI

>RFC EDITOR NOTE: Please replace RFCXXXX with the RFC number of this document.

This document defines a new extension URI in the RTP SDES Compact
Header Extensions sub-registry of the RTP Compact Header Extensions
registry sub-registry, as follows


  Extension URI: urn:ietf:params:rtp-hdrext:sdes:rtp-stream-id
  Description:   RTP Stream Identifier
  Contact:       adam@nostrum.com
  Reference:     RFCXXXX

The SDES item does not reveal privacy information about the user or
the session contents. It serves only to bind the identity of a stream
to corresponding data in a session description.

## New RepairRtpStreamId Header Extension URI

>RFC EDITOR NOTE: Please replace RFCXXXX with the RFC number of this document.

This document defines a new extension URI in the RTP SDES Compact
Header Extensions sub-registry of the RTP Compact Header Extensions
registry sub-registry, as follows


  Extension URI: urn:ietf:params:rtp-hdrext:sdes:repair-rtp-sream-id
  Description:   RTP Repaired Stream Identifier
  Contact:       adam@nostrum.com
  Reference:     RFCXXXX

The SDES item does not reveal privacy information about the user or
the session contents. It serves only to bind redundancy stream to the
streams they provide repair data for.

# Security Considerations

The actual identifiers used for RtpStreamIds (and therefore RepairedRtpStreamIds)
are expected to be opaque. As such, they are not expected to contain
information that would be sensitive, were it observed by third-parties.

#  Acknowledgements
Many thanks for review and input from Cullen Jennings, Magnus Westerlund,
Colin Perkins, Peter Thatcher, Jonathan Lennox, and Paul Kyzivat.
