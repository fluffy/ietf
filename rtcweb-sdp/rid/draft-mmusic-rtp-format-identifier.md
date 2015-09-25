---
title: "Framework for configuring and identifying RTP Streams in a codec agnostic way"
abbrev: i3c
docname:  draft-mmusic-rtp-config-00
date: 2015-09-24
category: std
ipr: trust200902

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
 -
    ins: F. Last Name
    name: First  Last Name
    org: Company Name
    email: name@domain.com

normative:

informative:

--- abstract

In this specification, we define a framework for configuring and identifying
RTP streams in the Session Description Protocol. This framework uses "rid"
SDP attribute to effectively extend RTP PT space, describe media format
specification in a codec agnostic way and provide a way to unambiguously
map RTP Streams to a specific media format specification in the SDP.

Note: The name 'rid' is not yet finalized. Please refer to Section "Open Issues" for more details on the naming.

--- middle

# Introduction

Payload Type (PT) in RTP provides mapping between the format of the RTP payload to the media format description specified in the signaling. For applications that use SDP for signaling, the constructs rtpmap and/or fmtp describe the characteristics of the media that is carried in the RTP payload, mapped to a given PT.

Recents advances in standards such as RTCWeb, NetVC have given rise to
rich multimedia applications requiring support for multiple RTP Streams in a given session [[BUNDLE, Simulcast ]] or having to support multiple codecs, for 
example. These demands have unearthed challenges inherent with the 

* Restricted RTP PT space in specifying the various payload configurations,

* Codec specific constructs for the payload formats in SDP,

* Ambiguity in mapping  between the RTP payload format and the equivalent signaling constructs in SDP.

This specification defines a new SDP framework for configuring and identifying
RTP Streams called "RTP Stream Identifier (rid)" along with the SDP attributes to configure the individual RTP Streams in a codec agnostic way. This specification also proposes a new RTP header extension to provide correlation to associate RTP packet to the payload format specification in the SDP.

# Key Words for Requirements

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
document are to be interpreted as described in RFCXXXX

# Terminology

The terms Encoded Stream, Endpoint, Media Source, RTP Session, and
RTP Stream are used as defined in [I-D.ietf-avtext-rtp-grouping-taxonomy].

[RFC4566] and [RFC3264] terminology are used wherever appropriate.

# Motivation

This section summarizes several motivations for proposing the 'rid' 
framework.


1. RTP PT Space Exhaustion: 
RFC3550 defines payload type (PT) that identifies the format of the RTP payload and determine its interpretation by the application. RFC3550 assigns 7 bits for the PT in the RTP header. However due to the assignment of static mapping of payload codes to payload formats, multiplexing of RTP with other protocols (such as RTCP) could result in limited number of payload type numbers available for application usage. In scenarios where the number of possible RTP payload configurations exceed the available PT space, there is a need for mechanisms to extend the PT space in the RTP and also effectively map an RTP Stream to its configuration in the signaling.
  

2. Codec Specific Media Format Specification in SDP: RTP Payload configuration is typically specified using rtpmap and fmtp SDP attributes. rtpmap provides the media format to RTP PT mapping and the ftmp attribute describes the media format specific parameters. The syntax for the fmtp attribute is tightly coupled to a specific media format (such as H.264, H.265, VP8). This has resulted in a myriad ways for defining the attributes that are common across different media formats. Additionally with the advent of new standards efforts such as netvc, one can expect more media formats to be standardized in the 
future. Thus there is a need to define common media characteristics 
in a codec-agnostic way in order to reduce the duplicated efforts and simply the syntactic representation across the different codec standards.



# Applicability Statement

The mechanism in this specification only applies to the Session Description Protocol (SDP) [RFC4566], when used together with the SDP Offer/Answer mechanism [RFC3264]. Declarative usage of SDP is out of scope of this document, and is thus undefined.

# SDP 'rid' Media Level Attribute

The section defines new SDP media-level attribute [RFC4566], 'rid'.

~~~~~~~~~~~~~~~
Name: rid

Value: 

Usage Level: media

Charset Dependent: no

Example:
a=rid:<rid-identifier> pt=<fmt-list> <rid-attribute>:<value> ... 

~~~~~~~~~~~~~~~

The 'a=rid' SDP media attribute describes payload media format 
(defined via rid-level attributes Section XXX) for one or more 
Payload Types. 

'rid-identifier' identifies the RTP Stream to which 
the payload configuration as defined by the 'rid-level' attributes 
applies. 

The 'rid' framework MAY be used in combination with the 'a=fmtp' SDP 
attribute for describing the media format parameters for a given 
RTP Payload Type. However in such scenarios, the 'rid-level' attributes
[Section XXXX] further constrains the equivalent 'fmtp' attributes. 
The 'rid' framework MAY also be used to fully describe RTP payload encoding, thus completely removing the 'a=fmtp' SDP attribute. In either case, the 'a=rtpmap' attribute MUST be used to identify the media encoding format and the RTP Payload Type.

A given SDP media description MAY have zero or more "a=rid" lines
capturing various possible RTP payload configurations.
The 'rid-identifier' MUST be unique across all the media 
descriptions. Also, the combination of RTP Payload Type (a.k.a fmt in SDP) 
and a 'rid-identifier' MUST be unique across all the RTP Streams in
a given RTP Session.

The 'rid' media attribute MAY be used for any RTP-based media transport.
It is not defined for other transports.

Though the 'rid-level' attributes specified by the 'rid' property
follow the syntax similar to session-level and media-level attributes,
they are defined independently.  All 'rid-level' attributes MUST be
registered with IANA, using the registry defined in Section XXXX

Section XXXX gives a formal Augmented Backus-Naur Form(ABNF) 
[RFC5234] grammar for the "rid" attribute.

# "rid-level' attributes

This section defines individual 'rid-level' attributes that can be used 
to describe RTP payload encoding formats in a codec-agnostic way and to specify relationships between individual RTP Streams identified by the 
combination of RTP Payload Type and the 'rid-identifier'.

All the attributes are optional and are subjected to negotiation 
based on the Offer/Answer rules described in Section XXXX.

The 'rid' framework defines two kinds of 'rid-level' attrbutes:

* Non-Directional : These attributes are used when symmetrical 
values for a given attribute suffices.

~~~~~~~~~~~~~

Ex: max-br for specifying a given media bitrate as applied to
both the send and receive directions.

~~~~~~~~~~~~~

* Directional: These attributes are used for specific control of 
the attribute value per given direction.

~~~~~~~~~~~~~~~

Ex: max-send-br and max-recv-br for specifying media bitrate 
for send and receive directions individually.

~~~~~~~~~~~~~~~

Section XXXX provides formal Augmented Backus-Naur Form(ABNF) [RFC5234] grammar for each of the "rid-level" attributes defined in this section.


## The "max-width", "max-recv-width", "max-send-width" Attributes

This set of parameters specify the maximum width in pixels for spatial 
resolution. The 'max-send-width' and 'max-recv-width' attributes together provide granular control for setting the video width resolution for send and receive directions respectively. The 'max-width' attribute MUST be used when asymmetrical resolution setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-width=<send-width-val> \
max-recv-width=<recv-width-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-width=<width-val> ...

Example:
1) Directional video width resolution in pixels
a=rid:1 pt=96 max-send-width=1280 max-recv-width=320

2) Non-Directional video width resolution in pixels
a=rid:1 pt=96 max-width=1280 

~~~~~~~~~~~~~~~


## The "max-height", "max-recv-height", "max-send-height" Attributes

This set of parameters specify the maximum height in pixels for spatial 
resolution.The 'max-send-height' and 'max-recv-height' together provide granular control for setting the video width resolution for send and receive directions respectively. The 'max-height' attribute MUST be used when asymmetrical resolution setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-height=<send-height-val> \
max-recv-height=<recv-height-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-height=<height-val> ...

Example:
1) Directional video height resolution in pixels
a=rid:1 pt=96 max-send-height=720 max-recv-height=180

2) Non-Directional video height resolution in pixels
a=rid:1 pt=96 max-height=720

~~~~~~~~~~~~~~~


## The "max-fps", "max-recv-fps", "max-send-fps" Attributes

This set of parameters specify the maximum video framerate in frames
per second. The 'max-send-fps' and 'max-recv-fps' attributes together 
provide granular control for setting the video framerate for send and receive directions respectively. The 'max-fps' attribute MUST be used when asymmetrical framerate setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-fps=<send-fps-val> \
max-recv-fps=<recv-fps-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-fps=<v-val> ...

Example:
1) Directional video framerate resolution in pixels
a=rid:1 pt=96 max-send-width=60 max-recv-width=30

2) Non-Directional video framerate resolution in pixels
a=rid:1 pt=96 max-fps=30

~~~~~~~~~~~~~~~



## The "max-fs", "max-recv-fs", "max-send-fs" Attributes

This set of parameters specify the maximum video framesize in pixels
per frame. The 'max-send-fs' and 'max-recv-fs' attributes together 
provide granular control for setting the video framesize for send and 
receive directions respectively. The 'max-fs' attribute MUST be used when asymmetrical framesize setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-fs=<send-fs-val> \
max-recv-fs=<recv-fs-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-fs=<fs-val> ...

Examples
1) Directional video framesize
a=rid:1 pt=96 max-send-fs=1382400 max-recv-fs=57600

2) Non-Directional video framesize
a=rid:1 pt=96 max-fs=1382400
~~~~~~~~~~~~~~~


## The "max-br", "max-recv-br", "max-send-br" Attributes

This set of parameters specify the maximum video bitrate in bits
per second. The 'max-send-br' and 'max-recv-br' attributes together 
provide granular control for setting the video bitrate for send and receive directions respectively. The 'max-br' attribute MUST be used when asymmetrical video bitrate setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-br=<send-br-val> \
max-recv-width=<recv-br-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-br=<br-val> ...

Example:
1) Directional video bitrate
a=rid:1 pt=96 max-br-width=2000000 max-recv-width=1000000

2) Non-Directional video bitrate
a=rid:1 pt=96 max-br=2000000

~~~~~~~~~~~~~~~


## The "max-pps", "max-recv-pps", "max-send-pps" Attributes

This set of parameters specify the maximum video pixelrate in pixels
per second. The 'max-send-pps' and 'max-recv-pps' attributes together 
provide granular control for setting the video pixelrate for send and receive directions respectively. The 'max-pps' attribute MUST be used when asymmetrical video pixelrate setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-pps=<send-pps-val> \
max-recv-width=<recv-pps-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-pps=<pps-val> ...

Example:
1) Directional video pixelrate
a=rid:1 pt=96 max-pps-width=1280 max-pps-width=320

2) Non-Directional video pixelrate
a=rid:1 pt=96 max-pps=1280

~~~~~~~~~~~~~~~


## The "depend” attribute

The 'depend' attribute can be used to establish relationship
between several 'rid-identifiers'. Such relationship exists when
signaling layer dependencies for Scalable Video Coding (SVC)  or
relating a primary RTP Stream to a Secondary RTP Stream (FEC/RTX),
for example.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> depend=<rid-identifier>, ...

Example to show rid '2' depending on '1'
a=rid:1 pt=100
a=rid:2 pt=101 depend=1

~~~~~~~~~~~~~~~

The list of 'rid-identifiers' specified as part of the depend attribute MUST 
be defined elsewhere in the SDP. If not, such definition MUST be 
considered as error and the entire 'rid' line MUST be rejected.


# SDP Offer/Answer Procedures

This section describes the SDP Offer/Answer [RFC3264] procedures for dealing
with the 'rid' framework.

## Generating the Initial SDP Offer

For each media description in the offer, the offerer MAY choose to
include one or more "a=rid" lines to specify a configuration profile for the given set of RTP Payload Types. 

In order to construct a given "a=rid" line, the offerer must follow 
the below steps: 

* It MUST generate a unique 'rid-identifier'. The chosen identifier
  MUST be unique across all the media descriptions in the SDP Offer.

* It MUST list one or more Payload Types that will be impacted by the
  given 'a=rid' definition. The Payload Types chosen MUST either be defined as 
  part of "a=rtpmap" or "a=fmtp" attributes. If not, the Offer MUST not generate the "a=rid:" line.

* The Offerer then chooses the 'rid-level' attributes to be applied
  for the Payload Types listed. If 'a=fmtp' attribute is also used to provide media format specific parameters, then the 'rid-level' attributes will further constrain the equivalent 'fmtp' parameters for the given Payload Type.

* If the offerer chooses to use 'rid-level' directional attributes, it MUST not
  include their non directional equivalents. For example, if "max-send-width" and "max-recv-width" for specifying the spatial resolution are included, then its non directional equivalent, the "max-width" attribute, MUST not be included. Also, when including the directional 'rid-level' attributes, the offerer MUST specify attribute values for both the send and receive directions.

It is RECOMMENDED that the Offerers include both "a=fmtp" and "a=rid" attributes in the offer for describing the media encoding formats in the SDP. This is done to ensure interoperability between the EndPoints that donot understand/support the 'rid' framework proposed in this specification.  

## Answerer processing the SDP Offer

For each media description in the offer, and for each "a=rid" attribute
in the media description, the receiver of the offer will perform the
following steps:

### Non 'rid' aware Answerer

If the receiver doesn't support/understand the 'rid' framework proposed in this specification, the entire "a=rid" line is ignored following the standard
RFC3264 Offer/Answer rules. Furthermore, if the offer lacked 'a=fmtp' attributes for the Payload Types included, the answerer MAY either reject the entire media description or decide to assume default media format parameters for the given RTP Payload Type.

### 'rid' aware Answerer

If the answerer supports 'rid' framework, below steps are executed, in 
order, for each "a=rid" line in a given media description:

* Extract the rid-identifier from the "a=rid" line and verify its uniqueness. In the case of duplicate, the entire "a=rid" line is rejected and MUST not be included in the SDP Answer.

* As a next step, the list of payload types are verified against the list obtained from "a=rtpmap" and/or "a=fmtp" attributes. If there is no exact match for all the Payload Type listed in the "a=rid" line, then remove the "a=rid" line.

* On verifying the Payload Type(s) matches, the answerer shall ensure the "rid-level" attributes listed are supported and syntactically well formed. In the case of error the "a=rid" line is removed.

* If the 'depend' rid-level attribute is included, the answerer MUST make sure the rid-identifiers listed unambiguously match the rid-identifiers in the SDP offer. 

* If the media description contains "a=fmtp" attribute, the answerer proceeds to examine that the attribute values provided in the "rid-level" attributes are within the scope of their fmtp equivalents for a given Payload Type.
[[TODO : Add example for this]]


## Generating the SDP Answer

Having performed the verification of the SDP offer as described in the Section XXXX, the answerer shall perform the following steps when generating the SDP
answer.

For each "a=rid" line: 

* If the offer has non-directional 'rid' attributes, the answerer MAY choose
to specify their directional equivalents. For example, given max-width 
'rid-level' attribute in the offer, the answer MAY choose to replace it with
their directional equivalents, i.e, the 'max-send-width' and 'max-recv-width' attributes.

* The answerer MAY choose to modify specific 'rid-level' attribute value in the
answer SDP. In such a case, the modified value MUST be lower than the ones 
specified in the offer

* The answerer MUST NOT modify the 'rid-identifier' present in the offer.

* The answerer is allowed to remove one or more Payload Types from a
given 'a=rid' line. If the answerer chooses to remove all the Payload Types
from an "a=rid" line, the answerer MUST remove the entire "a=rid" line.

* In cases where the answerer is unable to support the payload configuration
specified in a given "a=rid" line in the offer, the answerer MUST remove the
corresponding "a=rid" line

## Offering Processing of the SDP Answer

The offerer shall follow the steps similar to answerer's offer processing with the following exceptions

* The offerer MUST ensure that the 'rid-identifiers' aren't changed between the offer and the answer. If so, the offerer MUST consider the corresponding
'a=rid' line as rejected.

* If there exists changes in the 'rid-level' attribute values, the offerer MUST
ensure that the modifications can be supported or else consider the "a=rid" line as rejected.

* If the answer includes directional 'rid-level' attributes in the place of their non-directional equivalents, the offer MUST check to verify the attribute values are supportable or else MUST consider the "a=rid" line as rejected.

* If the SDP answer contains any "rid-identifier" that doesn't match with 
the offer, the offerer MUST ignore the corresponding "a=rid" line. 


## Modifying the Session

TODO

# Usage of 'rid' in RTP 

The RTP fixed header includes the payload type number and the SSRC
values of the RTP stream.  RTP defines how you de-multiplex streams
within an RTP session, but in some use cases applications need
further identifiers in order to effectively map the individual 
RTP Streams to their equivalent payload configurations in the SDP.

Approaches like [[BUNDLE]] allows Payload Type to be re-used across 
media descriptions in a RTP Session and provides a way to associate 
the received RTP Packet to a given media description via 
the Media Identifier (RFC5888) 'mid' RTP header extension. 

However, there lacks a mechanism to map the individual RTP Packets to 
a given media format specification within a media description in SDP 
when the Payload Types are reused in an RTP Session.

Also there exists no mechanism to extend the Payload Type space in 
the RTP packet in the cases where the number of payload configurations possible exceed the available Payload Types in an RTP Session.

To enable such mapping, this specification defines a new RTP header 
extension to include the 'rid-identifier'. This makes it possible for a receiver to associate received RTP packets with a specific media description, 
in which the receiver has assigned the 'rid-identifier' identifying a particular payload configuration, even if those "m=" lines are part of the same RTP session.

## RTP 'rid' Header Extension

The payload, containing the identification-tag, of the RTP 'rid-identifier' header extension element can be encoded using either the one-byte or two-byte header [RFC5285]. The identification-tag payload is UTF-8 encoded, as in SDP.

As the identification-tag is included in an RTP header extension, there should be some consideration about the packet expansion caused by the identification-tag. To avoid Maximum Transmission Unit (MTU) issues for the RTP packets, the
header extension's size needs to be taken into account when the encoding media.
Note, that set of header extensions included in the packet needs to be padded to the next 32-bit boundary using zero bytes [RFC5285].

It is recommended that the identification-tag is kept short. Due to the properties of the RTP header extension mechanism, when using the one-byte header, a tag that is 1-3 bytes will result in that a minimal number of 32-bit words are used for the RTP header extension, in case no other header extensions are included at the same time. 


# Formal Grammar

This section gives a formal Augmented Backus-Naur Form (ABNF)
[RFC5234] grammar for each of the new media and rid-level attributes
defined in this document. 

~~~~~~~~~~~~~~~~~~
rid-syntax = "a=rid:" rid-identifier SP rid-fmt-list SP rid-attr-list

rid-identifier = 1*(alpha-numeric / "-" / "_")

rid-fmt-list   = "pt=" rid-fmt *( ";" rid-fmt )

rid-fmt        = fmt

rid-attr-list  = rid-width-param
               / rid-height-param
               / rid-fps-param
               / rid-fs-param
               / rid-br-param
               / rid-pps-param
               / rid-depend-param

rid-width-param = "max-width=" param-val
                / "max-recv-width="param-val "max-send-width="param-val

rid-height-param = "max-height=" param-val
                 / "max-recv-height="param-val "max-send-height="param-val

rid-fps-param   = "max-fps=" param-val
                / "max-recv-fps="param-val "max-send-fps="param-val

rid-fs-param    = "max-fs=" param-val
                / "max-recv-fs="param-val "max-send-fs="param-val

rid-br-param    = "max-br=" param-val
                / "max-recv-br="param-val "max-send-br="param-val

rid-pps-param    = "max-pps=" param-val
                / "max-recv-pps="param-val "max-send-pps="param-val

rid-depend-param = "depend=" rid-list

rid-list = rid-identifier *( "," rid-identifier )

param-val  = byte-string

; WSP defined in [RFC5234]
; fmt defined in [RFC4566]
; byte-string in [RFC4566]

~~~~~~~~~~~~~~~~~~



# SDP Examples

## Single Stream Scenarios
 TODO

## Multistream Scenarios

### Two simulcast streams with PT reuse

This example shows and offer answer exchange where the offer propose to sendonly of two simulcast streams at 720P30 and 180P15. The answer accepts both of them.


# Open Issues

## Name of the identifier

The name 'rid' is provisionally used and is open for further discussion.

Here are the few options that were considered while writing this draft

* ESID: Encoded Stream ID, does not align well with taxonomy which defines Encoded Stream as before RTP packetization.

* RSID or RID: RTP Stream ID, aligns better with taxonomy but very vague.

* LID: Layer ID, aligns well for SVC with each layer in a separate stream, but not for other SVC layerings or independent simulcast which is awkward to view as layers.

* EPT or XPT: EXtended Payload Type, conveys XPT.PT usage well, but may be confused with PT, for example people may mistakenly think they can use it in other places where PT would normally be used. 

# IANA Considerations

## New RTP Header Extension URI

This document defines a new extension URI in the RTP Compact Header Extensions subregistry of the Real-Time Transport Protocol (RTP) Parameters registry, according to the following data:

~~~~~~~~~~~~~~~

    Extension URI: urn:ietf:params:rtp-hdrext:rid
    Description:   RTP Stream Identifier
    Contact:       <name@email.com>
    Reference:     RFCXXXX

~~~~~~~~~~~~~~~


## New SDP Media-Level attribute

This document defines "rid" as SDP media-level attribute. This attribute must be registered by IANA under
"Session Description Protocol (SDP) Parameters" under "att-field (media level only)".

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
                   max-recv-width                [RFCXXXX]
                   max-send-width                [RFCXXXX]
                   max-height                    [RFCXXXX]
                   max-recv-height               [RFCXXXX]
                   max-send-hright               [RFCXXXX]
                   max-fps                       [RFCXXXX]
                   max-recv-fps                  [RFCXXXX]
                   max-send-fps                  [RFCXXXX]
                   max-fs                        [RFCXXXX]
                   max-recv-fs                   [RFCXXXX]
                   max-send-fs                   [RFCXXXX]
                   max-br                        [RFCXXXX]
                   max-recv-br                   [RFCXXXX]
                   max-send-br                   [RFCXXXX]
                   max-pps                       [RFCXXXX]
                   max-recv-pps                  [RFCXXXX]
                   max-send-pps                  [RFCXXXX]
                   depend                        [RFCXXXX]

~~~~~~~~~~~~~~~~~~~~~~~




# Security Considerations

TODO

#  Acknowledgements
Many thanks to review from  TODO
