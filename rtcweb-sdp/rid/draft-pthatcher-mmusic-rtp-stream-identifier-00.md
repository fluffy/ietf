---
title: "Framework for configuring and identifying Source RTP Streams in a codec agnostic way"
abbrev: i3c
docname:  draft-pthatcher-mmusic-rtp-stream-identifier-00
date: 2015-09-28
category: std
ipr: trust200902

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
-
    ins: P. Thatcher
    name: Peter Thatcher
    org: Google
    email: ppthatcher@webrtc.org
-
    ins: M. Zanaty
    name: Mo Zanaty
    org: Cisco Systems
    email: mzanaty@cisco.com
-
    ins: S. Nandakumar
    name: Suhas Nandakumar
    org: Cisco Systems
    email: snandaku@cisco.com  
-
    ins: A.B. Roach
    name: Adam Roach
    org: Mozilla
    email: adam@nostrum.com      

-
    ins: B. Burman
    name: Bo Burman
    org: Ericsson
    email: bo.burman@ericsson.com

-
    ins: B. Campen
    name: Byron Campen
    org: Mozilla
    email: bcampen@mozilla.com 



normative:
  RFC2119:
  RFC3264:
  RFC3550:
  RFC4566:
  RFC5234:
  RFC5285:
  I-D.ietf-avtext-rtp-grouping-taxonomy:

informative:
  RFC5888:
  I-D.ietf-mmusic-sdp-bundle-negotiation:
  I-D.ietf-mmusic-sdp-simulcast:


--- abstract

In this specification, we define a framework for configuring and identifying
Source RTP Streams in the Session Description Protocol. This framework uses "rid" SDP attribute to: a) effectively identify the Source RTP Streams within a RTP Session, b) describe or constrain their payload format parameters in a codec agnostic way beyond what is provided with the regular Payload Types and c) enable unambiguous mapping between the Source RTP Streams to their
media format specification in the SDP

Note-1: The name 'rid' is not yet finalized. Please refer to Section "Open Issues" for more details on the naming.

--- middle

# Introduction {#sec-intro}

Payload Type (PT) in RTP provides mapping between the format of the RTP payload to the media format description specified in the signaling. For applications that use SDP for signaling, the constructs rtpmap and/or fmtp describe the characteristics of the media that is carried in the RTP payload, mapped to a given PT.

Recents advances in standards such as RTCWeb, Netvc have given rise to
rich multimedia applications requiring support for multiple RTP Streams with in a RTP session {{I-D.ietf-mmusic-sdp-bundle-negotiation}}, {{I-D.ietf-mmusic-sdp-simulcast}} or having to support multiple codecs, for 
example. These demands have unearthed challenges inherent with the,

* Restricted RTP PT space in specifying the various payload configurations,

* Codec specific constructs for the payload formats in SDP,

* Missing or underspecied payload format parameters,

* Ambiguity in mapping between the individual Source RTP Streams and their equivalent format specification in the SDP.

This specification defines a new SDP framework for configuring and identifying
Source RTP Streams (Section 2.1.10 {{I-D.ietf-avtext-rtp-grouping-taxonomy}}) called " RTP Source Stream Identifier (rid) " along with the SDP attributes to configure the individual Source RTP Streams in a codec agnostic way. The "rid" framework can be thought as complementary extension to the way the media format parameters are specified in SDP today, via the "a=fmtp" attribute.
This specification also proposes a new RTP header extension to carry the
"rid" value for provding the correlation between the RTP Packets to their
format specification in the SDP.

# Key Words for Requirements

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
document are to be interpreted as described in {{RFC2119}}

# Terminology

The terms Source RTP Stream, Endpoint, RTP Session, and
RTP Stream are used as defined in {{I-D.ietf-avtext-rtp-grouping-taxonomy}}.

{{RFC4566}} and {{RFC3264}} terminology are also used wherever appropriate.

# Motivation {#sec-motivation}

This section summarizes several motivations for proposing the "rid" 
framework.

1. RTP PT Space Exhaustion: 
{{RFC3550}} defines payload type (PT) that identifies the format of the RTP payload and determine its interpretation by the application. {{RFC3550}} assigns 7 bits for the PT in the RTP header. However the assignment of static mapping of payload codes to payload formats, multiplexing of RTP with other protocols (such as RTCP) could result in limited number of payload type numbers available for the application usage. In scenarios where the number of possible RTP payload configurations exceed the available PT space within a RTP Session, there is need a way to represent the additional payload configurations
and also to effectively map an Source RTP Stream to its configuration in the signaling.
  

2. Codec Specific Media Format Specification in SDP: RTP Payload configuration is typically specified using rtpmap and fmtp SDP attributes. rtpmap provides the media format to RTP PT mapping and the ftmp attribute describes the media format specific parameters. The syntax for the fmtp attribute is tightly coupled to a specific media format (such as H.264, H.265, VP8). This has resulted in a myriad ways for defining the attributes that are common across different media formats. Additionally with the advent of new standards efforts such as netvc, one can expect more media formats to be standardized in the 
future. Thus there is a need to define common media characteristics 
in a codec-agnostic way in order to reduce the duplicated efforts and to simplify the syntactic representation across the different codec standards.

3. Multisource and Multistream Usecases: Recently, there is a rising trend with Realtime multimedia applications supporting multiple sources per EndPoint with various temporal resolutions (Scalable Video Codec) and spatial resolutions (Simulcast) per source. These applications are being challenged 
by the limited RTP PT space and/or by the underspecified SDP contructs for 
exercising granular control on configuring the indivual Source RTP Streams.


# Applicability Statement

The 'rid' SDP framework provides a set of codec agnostic media format configurations and constraints with a specific identifier in SDP. Further, 
procedures for applying a particular configuration and constraints set 
to an Source RTP stream and the SDP Offer/Answer specific syntax for the same
are defined.


# SDP 'rid' Media Level Attribute {#sec-rid_attribute}

This section defines new SDP media-level attribute [RFC4566], "a=rid".

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> <direction> pt=<fmt-list> <rid-attribute>:<value> ... 

~~~~~~~~~~~~~~~

A given "a=rid" SDP media attribute specifies constraints defining 
an unique RTP payload configuration identified via the "rid-identifier".
A set of codec agnostic "rid-level" attributes are defined ({sec-rid_level_atributes}) that describe the media format specification 
applicable to one or more Payload Types speicified by the "a=rid" line.


The 'rid' framework MAY be used in combination with the 'a=fmtp' SDP 
attribute for describing the media format parameters for a given 
RTP Payload Type. However in such scenarios, the 'rid-level' attributes
({{sec-rid_level_attributes}}) further constrains the equivalent 'fmtp' attributes. The 'rid' framework MAY also be used to fully describe the RTP payload encoding, thus completely skipping the 'a=fmtp' SDP attribute for the Payload Types identified in the "a=rid" line. In either case, the 'a=rtpmap' attribute MUST be defined to identify the media encoding format and the RTP Payload Type.

The 'direction' identifies the either 'send', 'recv' directionality
of the Source RTP Stream. 

A given SDP media description MAY have zero or more "a=rid" lines
capturing various possible RTP payload configurations. A given
'rid-identifier' MUST not be repeated in a given media description.

The 'rid' media attribute MAY be used for any RTP-based media transport.
It is not defined for other transports.

Though the 'rid-level' attributes specified by the 'rid' property
follow the syntax similar to session-level and media-level attributes,
they are defined independently.  All 'rid-level' attributes MUST be
registered with IANA, using the registry defined in {{sec-iana}}

{{sec-abnf}} gives a formal Augmented Backus-Naur Form(ABNF) 
{{RFC5234}} grammar for the "rid" attribute.

The "a=rid" media attribute is not dependent on charset.

# "rid-level' attributes {#sec-rid_level_attributes}

This section defines individual 'rid-level' attributes that can be used 
to describe RTP payload encoding format in a codec-agnostic way.

All the attributes are optional and are subjected to negotiation 
based on the SDP Offer/Answer rules described in {{sec-sdp_o_a}}

{{sec-abnf}} provides formal Augmented Backus-Naur Form(ABNF) {{RFC5234}} grammar for each of the "rid-level" attributes defined in this section.


## The "max-width" Attribute

The "max-width" rid-level attribute specifies the maximum width in pixels for spatial resolution. 

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> <direction> pt=<fmt-list> max-width=<width-val> ...

Example:
a=rid:1 send pt=96 max-width=1280 

~~~~~~~~~~~~~~~


## The "max-height" Attribute

The "max-height" rid-level attribute specifies the maximum height in pixels for spatial resolution. 


~~~~~~~~~~~~~~~

a=rid:<rid-identifier> <direction> pt=<fmt-list> max-height=<height-val> ...

Example:
a=rid:1 send pt=96 max-height=1080 

~~~~~~~~~~~~~~~



## The "max-fps" Attribute

The "max-fps" rid-level attribute specifies the maximum video framerate in frames per second.


~~~~~~~~~~~~~~~

a=rid:<rid-identifier> <direction> pt=<fmt-list> max-fps=<fps-val> ...

Example:
a=rid:1 recv pt=* max-fps=60

~~~~~~~~~~~~~~~


## The "max-fs" Attribute

The "max-fs" rid-level attribute specifies the maximum framesize (maximum width * max height) in pixels per frame.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> <direction> pt=<fmt-list> max-fs=<fs-val> ...

Example:
a=rid:1 send pt=96 max-fs=1382400

~~~~~~~~~~~~~~~


## The "max-br" Attribute

The "max-br" rid-level attribute specifies the bitrate in bits
per second.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> <direction> pt=<fmt-list> max-br=<br-val> ...

Example:
a=rid:1 recv pt=96 max-fs=2000000

~~~~~~~~~~~~~~~


## The "max-pps" Attribute

The "max-br" rid-level attribute specifies maximum video pixelrate in pixels
per second.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> <direction> pt=<fmt-list> max-pps=<pps-val> ...

Example:
a=rid:1 recv pt=96 max-pps=2000000

~~~~~~~~~~~~~~~


## The "depend” attribute

The 'depend' attribute can be used to establish relationship
between several 'rid-identifiers'. Such relationship exists when
signaling layer dependencies for Scalable Video Coding (SVC)  or
relating a primary RTP Stream to a Secondary RTP Stream (FEC/RTX),
for example.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> <direction> pt=<fmt-list> depend=<rid-identifier>, ...

Example to show rid '2' depending on '1'
a=rid:1  send pt=100
a=rid:2  send pt=101 depend=1

~~~~~~~~~~~~~~~

The list of 'rid-identifiers' specified as part of the depend attribute 
MUST be defined elsewhere in the SDP. If not, such definition MUST be 
considered as error and the entire 'rid' line MUST be rejected.

# SDP Offer/Answer Procedures {#sec-sdp_o_a}

This section describes the SDP Offer/Answer {{RFC3264}} procedures when
using the 'rid' framework.

## Generating the Initial SDP Offer

For each media description in the offer, the offerer MAY choose to
include one or more "a=rid" lines to specify a configuration profile for 
the given set of RTP Payload Types. 

In order to construct a given "a=rid" line, the offerer must follow 
the below steps: 

1. It MUST generate a unique 'rid-identifier'. The chosen identifier
  MUST be unique across all the media descriptions in the Offer.

2. It MUST include the direction for the 'rid-identifier' to one of
   the 'send', 'recv'

3. A listing of SDP format tokens (usually corresponding to RTP payload
   types) MUST be included to which the constraints expressed by the
   'rid-level' attributes apply. The Payload Types chosen MUST either be defined as part of "a=rtpmap" or "a=fmtp" attributes.

4. The Offerer then chooses the 'rid-level' attributes 
   ({{sec-rid_level_attributes}}) to be applied for the SDP format tokens listed. 

5. If 'a=fmtp' attribute is also used to provide media format specific
  parameters, then the 'rid-level' attributes will further constrain the equivalent 'fmtp' parameters for the given Payload Type.

It is RECOMMENDED that the Offerer includes both the "a=fmtp" and the "a=rid" attributes in the offer for describing the media encoding formats in the SDP. This is done to ensure interoperability between the EndPoints that donot understand/support the 'rid' framework proposed in this specification.  

## Answerer processing the SDP Offer

For each media description in the offer, and for each "a=rid" attribute
in the media description, the receiver of the offer will perform the
following steps:

### 'rid' unaware Answerer

If the receiver doesn't support/understand the 'rid' framework proposed in this specification, the entire "a=rid" line is ignored following the standard
{{RFC3264}} Offer/Answer rules. Furthermore, if the offer lacked 'a=fmtp' attributes for the Payload Types included, the answerer MAY either reject the entire media description or prefer to apply default media format parameters, 
as appropriate for media encoding.

### 'rid' aware Answerer

If the answerer supports 'rid' framework, below steps are executed, in 
order, for each "a=rid" line in a given media description:

1. Extract the rid-identifier from the "a=rid" line and verify its uniqueness.
   In the case of duplicate, the entire "a=rid" line is rejected and MUST not be included in the SDP Answer.

2. As a next step, the list of payload types are verified against the list 
  obtained from "a=rtpmap" and/or "a=fmtp" attributes. If there is no match 
  for the Payload Type listed in the "a=rid" line, then remove the "a=rid" line. The exception being when '*' is used for identifying the media format,
  where in the "a=rid" line applies to all the formats in a given media description.

3. On verifying the Payload Type(s) matches, the answerer shall ensure that 
  "rid-level" attributes listed are supported and syntactically well formed.
  In the case of error the "a=rid" line is removed.

4. If the 'depend' rid-level attribute is included, the answerer MUST make 
  sure that the rid-identifiers listed unambiguously match the rid-identifiers in the SDP offer. 

5. If the media description contains "a=fmtp" attribute, the answerer proceeds 
   to examine that the attribute values provided in the "rid-level" attributes are within the scope of their fmtp equivalents for a given media format.

## Generating the SDP Answer

Having performed the verification of the SDP offer as described, the answerer shall perform the following steps to generate the SDP answer.

For each "a=rid" line: 

1. The answerer MAY choose to modify specific 'rid-level' attribute value in
   the answer SDP. In such a case, the modified value MUST be lower than the ones specified in the offer.

2. The answerer MUST NOT modify the 'rid-identifier' present in the offer.

3. The answerer is allowed to remove one or more media formats from a
   given 'a=rid' line. If the answerer chooses to remove all the 
   media format tokens from an "a=rid" line, the answerer MUST remove the entire "a=rid" line.

4. In cases where the answerer is unable to support the payload configuration 
   specified in a given "a=rid" line in the offer, the answerer MUST remove the corresponding "a=rid" line.

## Offering Processing of the SDP Answer

The offerer shall follow the steps similar to answerer's offer processing with the following exceptions

1. The offerer MUST ensure that the 'rid-identifiers' aren't changed between
   the offer and the answer. If so, the offerer MUST consider the corresponding
   'a=rid' line as rejected.

2. If there exists changes in the 'rid-level' attribute values, the offerer 
   MUST ensure that the modifications can be supported or else consider the "a=rid" line as rejected.

3. If the SDP answer contains any "rid-identifier" that doesn't match with 
   the offer, the offerer MUST ignore the corresponding "a=rid" line. 


## Modifying the Session

TODO

# Usage of 'rid' in RTP 

The RTP fixed header includes the payload type number and the SSRC
values of the RTP stream.  RTP defines how you de-multiplex streams
within an RTP session, but in some use cases applications need
further identifiers in order to effectively map the individual 
RTP Streams to their equivalent payload configurations in the SDP.

This specification defines a new RTP header extension to include the 'rid-identifier'. This makes it possible for a receiver to associate received RTP packets (identifying the Source RTP Stream) with a specific media description, 
in which the receiver has assigned the 'rid-identifier' identifying a particular payload configuration, even if those "m=" lines are part of the same RTP session.

## RTP 'rid' Header Extension

The payload, containing the identification-tag, of the RTP 'rid-identifier' header extension element can be encoded using either the one-byte or two-byte header {{RFC5285}}. The identification-tag payload is UTF-8 encoded, as in SDP.

As the identification-tag is included in an RTP header extension, there should be some consideration about the packet expansion caused by the identification-tag. To avoid Maximum Transmission Unit (MTU) issues for the RTP packets, the
header extension's size needs to be taken into account when the encoding media.
Note, that set of header extensions included in the packet needs to be padded to the next 32-bit boundary using zero bytes {{RFC5285}}

It is recommended that the identification-tag is kept short. Due to the properties of the RTP header extension mechanism, when using the one-byte header, a tag that is 1-3 bytes will result in that a minimal number of 32-bit words are used for the RTP header extension, in case no other header extensions are included at the same time. 


# Formal Grammar {#sec-abnf}

This section gives a formal Augmented Backus-Naur Form (ABNF)
{{RFC5234}} grammar for each of the new media and rid-level attributes
defined in this document. 

~~~~~~~~~~~~~~~~~~
rid-syntax = "a=rid:" rid-identifier SP rid-dir SP rid-fmt-list SP rid-attr-list

rid-identifier = 1*(alpha-numeric / "-" / "_")

rid-dir              = "send" / "recv"

rid-fmt-list   = "pt=" rid-fmt *( ";" rid-fmt )

rid-fmt        = "*" ; wildcard: applies to all formats
               / fmt

rid-attr-list  = rid-width-param
               / rid-height-param
               / rid-fps-param
               / rid-fs-param
               / rid-br-param
               / rid-pps-param
               / rid-depend-param

rid-width-param = "max-width=" param-val
              
rid-height-param = "max-height=" param-val
              
rid-fps-param   = "max-fps=" param-val
              
rid-fs-param    = "max-fs=" param-val

rid-br-param    = "max-br=" param-val

rid-pps-param    = "max-pps=" param-val

rid-depend-param = "depend=" rid-list

rid-list = rid-identifier *( "," rid-identifier )

param-val  = byte-string

; WSP defined in {{RFC5234}}
; fmt defined in {{RFC4566}}
; byte-string in {{RFC4566}}

~~~~~~~~~~~~~~~~~~



# SDP Examples

## Single Stream Scenarios
 TODO

## Many Bundled Streams using Many Codecs

In the scenario, the offerer supports adio codecs Opus, G.722, G.711 and DTMF
VP8, VP9, H.264 (CBP/CHP, mode 0/1), H.264-SVC (SCBP/SCHP) and H.265 (MP/M10P) for video. An 8-way video call (to a mixer) is supported (send 1 and receive 7 video streams) by offering 7 video media sections (1 sendrecv at max resolution and 6 recvonly at smaller resolutions), all bundled on the same port, using 3 different resolutions.
The resolutions include, 1 receive stream of 720p resolution is offered for the active speaker. 2 receive streams of 360p resolution are offered for the prior 2 active speakers. 4 receive streams of 180p resolution are offered for others in the call. 

Expressing all these codecs and resolutions using 32 dynamic PTs (2 audio + 10x3 video) would exhaust the primary dynamic space (96-127). RIDs are used to avoid PT exhaustion and express the resolution constraints.


NOTE: The SDP given below skips few lines to keep the example short and
focussed, as indicated by either the "..." or the comments inserted.

~~~~~~~~~~~~~~~~~~
Offer:
...
m=audio 10000 RTP/SAVPF 96 9 8 0 123
a=rtpmap:96 OPUS/48000
a=rtpmap:9 G722/8000
a=rtpmap:8 PCMA/8000
a=rtpmap:0 PCMU/8000
a=rtpmap:123 telephone-event/8000
a=mid:a1
...
m=video 10000 RTP/SAVPF 98 99 100 101 102 103 104 105 106 107
a=rtpmap:98 VP8/90000
a=fmtp:98 max-fs=3600; max-fr=30
a=rtpmap:99 VP9/90000
a=fmtp:99 max-fs=3600; max-fr=30
a=rtpmap:100 H264/90000
a=fmtp:100 profile-level-id=42401f; packetization-mode=0
a=rtpmap:101 H264/90000
a=fmtp:101 profile-level-id=42401f; packetization-mode=1
a=rtpmap:102 H264/90000
a=fmtp:102 profile-level-id=640c1f; packetization-mode=0
a=rtpmap:103 H264/90000
a=fmtp:103 profile-level-id=640c1f; packetization-mode=1
a=rtpmap:104 H264-SVC/90000
a=fmtp:104 profile-level-id=530c1f
a=rtpmap:105 H264-SVC/90000
a=fmtp:105 profile-level-id=560c1f
a=rtpmap:106 H265/90000
a=fmtp:106 profile-id=1; level-id=93
a=rtpmap:107 H265/90000
a=fmtp:107 profile-id=2; level-id=93
a=sendrecv
a=mid:v1 (max resolution)
a=rid:1 send pt=*; max-width=1280; max-height=720; max-fps=30
a=rid:2 recv pt=*; max-width=1280; max-height=720; max-fps=30
...
m=video 10000 RTP/SAVPF 98 99 100 101 102 103 104 105 106 107
...same rtpmap/fmtp as above...
a=recvonly
a=mid:v2 (medium resolution)
a=rid:3 recv pt=*; max-width=640; max-height=360; max-fps=15
...
m=video 10000 RTP/SAVPF 98 99 100 101 102 103 104 105 106 107
...same rtpmap/fmtp as above...
a=recvonly
a=mid:v3 (medium resolution)
a=rid:3 recv pt=*; max-width=640; max-height=360; max-fps=15
...
m=video 10000 RTP/SAVPF 98 99 100 101 102 103 104 105 106 107
...same rtpmap/fmtp as above...
a=recvonly
a=mid:v4 (small resolution)
a=rid:4 recv pt=*; max-width=320; max-height=180; max-fps=15
...
m=video 10000 RTP/SAVPF 98 99 100 101 102 103 104 105 106 107
...same rtpmap/fmtp as above...
...same rid:4 as above for mid:v5,v6,v7 (small resolution)...
...


Answer:
...same as offer but swap send/recv...

~~~~~~~~~~~~~~~~~~

## Simulcast

Adding simulcast to the above example allows the mixer to selectively forward streams like an SFU rather than transcode high resolutions to lower ones. Simulcast encodings can be expressed using PTs or RIDs. Using PTs can exhaust the primary dynamic space even faster in simulcast scenarios. So RIDs are used to avoid PT exhaustion and express the encoding constraints. In the example below, 3 resolutions are offered to be sent as simulcast to a mixer/SFU.

~~~~~~~~~~~~~~~~~~

Offer:
...
m=audio ... same as from prior example
...
m=video ...same as above...
...same rtpmap/fmtp as above...
a=sendrecv
a=mid:v1 (max resolution)
a=rid:1 send pt=*; max-width=1280; max-height=720; max-fps=30
a=rid:2 recv pt=*; max-width=1280; max-height=720; max-fps=30
a=rid:5 send pt=*; max-width=640; max-height=360; max-fps=15
a=rid:6 send pt=*; max-width=320; max-height=180; max-fps=15
a=simulcast: send rid=1;5;6 recv rid=2
...
...same m=video sections as prior example for mid:v2-v7...
...

Answer:
...same as offer but swap send/recv...

~~~~~~~~~~~~~~~~~~

## Scalable Layers

Adding scalable layers to the above simulcast example allows the SFU further flexibility to selectively forward packets from a source that best match the bandwidth and capabilities of diverse receivers. Scalable encodings have dependencies between layers, unlike independent simulcast streams. RIDs can be used to express these dependencies using the "depend" parameter. In the example below, the highest resolution is offered to be sent as 2 scalable temporal layers (using MRST).

~~~~~~~~~~~~~~~~~~

Offer:
...
m=audio ...same as above...
...
m=video ...same as above...
...same rtpmap/fmtp as above...
a=sendrecv
a=mid:v1 (max resolution)
a=rid:0 send pt=*; max-width=1280; max-height=720; max-fps=15
a=rid:1 send pt=*; max-width=1280; max-height=720; max-fps=30; depend=0
a=rid:2 recv pt=*; max-width=1280; max-height=720; max-fps=30
a=rid:5 send pt=*; max-width=640; max-height=360; max-fps=15
a=rid:6 send pt=*; max-width=320; max-height=180; max-fps=15
a=simulcast: send rid=0;1;5;6 recv rid=2
...
...same m=video sections as prior example for mid:v2-v7...
...

Answer:
...same as offer but swap send/recv...

~~~~~~~~~~~~~~~~~~

# Open Issues

## Name of the identifier

The name 'rid' is provisionally used and is open for further discussion.

Here are the few options that were considered while writing this draft

* ESID: Encoded Stream ID, does not align well with taxonomy which defines Encoded Stream as before RTP packetization.

* RSID or RID: RTP Stream ID, aligns better with taxonomy but very vague.

* LID: Layer ID, aligns well for SVC with each layer in a separate stream, but not for other SVC layerings or independent simulcast which is awkward to view as layers.

* EPT or XPT: EXtended Payload Type, conveys XPT.PT usage well, but may be confused with PT, for example people may mistakenly think they can use it in other places where PT would normally be used. 

# IANA Considerations {#sec-iana}

## New RTP Header Extension URI

This document defines a new extension URI in the RTP Compact Header Extensions subregistry of the Real-Time Transport Protocol (RTP) Parameters registry, according to the following data:

~~~~~~~~~~~~~~~

    Extension URI: urn:ietf:params:rtp-hdrext:rid
    Description:   RTP Stream Identifier
    Contact:       <name@email.com>
    Reference:     RFCXXXX

~~~~~~~~~~~~~~~


## New SDP Media-Level attribute

This document defines "rid" as SDP media-level attribute. This attribute must be registered by IANA under "Session Description Protocol (SDP) Parameters" under "att-field (media level only)".

The "rid" attribute is used to identify characteristics of RTP stream
with in a RTP Session. Its format is defined in Section XXXX.

## Registry for RID-Level Attributes

This specification creates a new IANA registry named "att-field (rid level)" within the SDP parameters registry.  The rid-level attributes MUST be registered with IANA and documented under the same rules as for SDP session-level and media-level attributes as specified in [RFC4566].

New attribute registrations are accepted according to the "Specification Required" policy of [RFC5226], provided that the specification includes the following information:

   o  contact name, email address, and telephone number

   o  attribute name (as it will appear in SDP)

   o  long-form attribute name in English

   o  whether the attribute value is subject to the charset attribute

   o  a one-paragraph explanation of the purpose of the attribute

   o  a specification of appropriate attribute values for this attribute

The initial set of rid-level attribute names, with definitions in Section XXXX of this document, is given below

~~~~~~~~~~~~~~~~~~~~~~~
   Type            SDP Name                     Reference
   ----            ------------------           ---------
   att-field       (rid level)
                   max-width                     [RFCXXXX]
                   max-height                    [RFCXXXX]
                   max-fps                       [RFCXXXX]
                   max-fs                        [RFCXXXX]
                   max-br                        [RFCXXXX]
                   max-pps                       [RFCXXXX]
                   depend                        [RFCXXXX]

~~~~~~~~~~~~~~~~~~~~~~~




# Security Considerations

TODO

#  Acknowledgements
Many thanks to review from TODO.
