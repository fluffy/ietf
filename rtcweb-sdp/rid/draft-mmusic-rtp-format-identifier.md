---
title: "Framework for configuring and enumerating RTP Streams in a codec agnostic way"
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

In this specification, we define a framework for configuring and enumerating
RTP streams in the Session Description Protocol. This framework uses "rid"
SDP attribute to effectively extend RTP PT space, define media format
specification in a codec agnostic way and provide a way to unambiguously
map RTP Streams to a media description ("m=" line) in a given RTP Session in
the cases where such a mapping might not be possible.

Note: The name 'rid' is not yet finalalied. Please refer to "Open Issues" for
more details on the naming.

--- middle

# Introduction

Payload Type (PT) in RTP provides mapping between the format of the RTP payload to the media format description specified in the signaling. For applications that use SDP for signaling, the constructs rtpmap/fmtp describe the characteristics for the media that is carried as RTP payload mapped to
a given PT.

Recents advances in standards such as RTCWeb, Netvc has given rise to
rich multimedia applications requiring support for multiple RTP Streams in a given session [[BUNDLE, Simulcast]] or having to support multiple codecs, for 
example. These demands have unearthed challenges inherent with the 

* Restricted RTP PT space in specifying the various payoad configurtions,

* Codec specific constructs for the payload formats in SDP,

* Ambiguity in mapping  between the RTP payload format and the equivalent signaling constructs in SDP,for example.

This specification defines a new SDP framework for configuring and enumerating 
RTP Streams called "RTP Stream Format Identifier (rid)" along with the SDP attributes to configure the individual RTP Streams in a codec agnostic way. This specification also proposes a new RTP header extension and SDES item to provide correlation to associate RTP packet to the payload format specification in the SDP.


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


## RTP PT Space Exhaustion 

RFC3550 defines payload type (PT) that identifies the format of the RTP payload and determine its interpretation by the application. RFC3550 assigns
7 bits for the PT in the RTP header. However due to the assignment of
static mapping of payload codes to payload formats, multiplexing of
RTP with other protocols (such as RTCP) can result in limited number of
payload type numbers available for application usage. 

## Codec Specific Media Format Specification in SDP

RTP Paylaod configuration is typically performed using rtpmap
and fmtp SDP attributes. rtpmap provides media format mapping to
RTP PT and ftmp described media codec specific parameters carried
in the RTP payload type. 

The syntax for fmtp SDP attribute is tightly coupled to a specific 
media codec standard (such as H.264, H.265, VP8). This has resulted in 
myraid ways of defining common attributes across different codecs.  Additionally with the advent of new standards efforts such as netvc,
one can expect more media codecs and format to be standardized in the 
future. Thus there is a need to define common media charactersitics 
in a codec-agnostic  in order to reduce the duplicated efforts across
different codec standards.


# Applicabilty Statement

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

The 'rid' SDP media attribute describes payload media format 
(defined via rid-level attributes Section XXX) for one or more 
Payload Types. 

'rid-identifier' identifies the RTP Stream to which 
the payload configuration corresponding to the 'rid-level' attributes 
applies. 

The 'rid' framework MAY be used in combination with the 'fmtp' SDP 
attribute for describing the media format parameters for a given 
RTP Payload Type. However in such scenarios the 'rid' attributes
[Section XXXX] further constrains to the equivalent 'fmtp' attributes. 
The 'rid' framework MAY also be used to fully describe RTP payload encoding
in place of 'fmtp' SDP attrbute. In either case, the rtpmap MUST be
used to identify the media encoding format and the RTP Payload Type.

A given media description "m=" MAY have zero or more "a=rid:" lines
capturing various possible media encoding configurations.
The 'rid-identfier' MUST be unique across all the media 
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

This section defines specific 'rid-level' attributes that can be used 
to describe RTP payload encoding formats in a codec-agnostic way and to specify relationships between individual RTP Streams identified by the 
combination of RTP Payload Type and the 'rid-identifier'.

All the attributes are optional and are subjected to negotiation 
based on the Offer/Answer rules described in Section XXXX.

Section XXXX provides formal Augmented Backus-Naur Form(ABNF) [RFC5234] grammar for each of the "rid-level" attributes defined in this section.


## The "max-width", "max-recv-width", "max-send-width" Attributes

This set of paramters specificy maximum width in pixels for spatial 
resolution. 'max-send-width' and 'max-recv-width' provides granular
control for setting the video width resolution for send and receive 
directions  respectively. 'max-width' MUST be used when asymmetrical 
resolution setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-width=<send-width-val> \
max-recv-width=<recv-width-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-width=<width-val> ...

Example:
1) Asymmetric video width resolution in pixels
a=rid:1 pt=96 max-send-width=1280 max-recv-width=320

2) Symmetric video width resolution in pixels
a=rid:1 PT=96 max-width=1280 
~~~~~~~~~~~~~~~


## The "max-height", "max-recv-height", "max-send-height" Attributes

This set of paramters specificy maximum height in pixels for spatial 
resolution. 'max-send-height' and 'max-recv-height' provides granular
control for setting the video width for send and receive directions 
respectively. 'max-height' MUST be used when asymmetrical resolution
setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-height=<send-height-val> \
max-recv-height=<recv-height-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-height=<height-val> ...

Example:
1) Asymmetric video width resolution in pixels
a=rid:1 pt=96 max-send-height=720 max-recv-height=180

2) Symmetric video height resolution in pixels
a=rid:1 PT=96 max-height=720
~~~~~~~~~~~~~~~


## The "max-fps", "max-recv-fps", "max-send-fps" Attributes

This set of paramters specificy maximum video framerate in frames
per second. 'max-send-fps' and 'max-recv-fps' provides granular
control for setting the video framerate for send and receive directions 
respectively. 'max-fps' MUST be used when asymmetrical framerate
setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-fps=<send-fps-val> \
max-recv-fps=<recv-fps-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-fps=<v-val> ...

Example:
1) Asymmetric video framerate resolution in pixels
a=rid:1 pt=96 max-send-width=60 max-recv-width=30

2) Symmetric video framerate resolution in pixels
a=rid:1 PT=96 max-fps=30
~~~~~~~~~~~~~~~



## The "max-fs", "max-recv-fs", "max-send-fs" Attributes

This set of paramters specificy maximum video framesize in pixels
per frame. 'max-send-fs' and 'max-recv-fs' provides granular
control for setting the video framesize for send and receive directions 
respectively. 'max-fs' MUST be used when asymmetrical framesize
setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-fs=<send-fs-val> \
max-recv-fs=<recv-fs-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-fs=<fs-val> ...

Examples
1) Asymmetric video framesize
a=rid:1 pt=96 max-send-fs=1382400 max-recv-fs=57600

2) Symmetric video framesize
a=rid:1 PT=96 max-fs=1382400
~~~~~~~~~~~~~~~


## The "max-br", "max-recv-br", "max-send-br" Attributes

This set of paramters specificy maximum video bitrate in bits
per second. 'max-send-br' and 'max-recv-br' provides granular
control for setting the video bitrate for send and receive directions 
respectively. 'max-br' MUST be used when asymmetrical video bitrate
setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-br=<send-br-val> \
max-recv-width=<recv-br-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-br=<br-val> ...

Example:
1) Asymmetric video bitrate
a=rid:1 pt=96 max-br-width=2000000 max-recv-width=1000000

2) Symmetric video bitrate
a=rid:1 PT=96 max-br=2000000
~~~~~~~~~~~~~~~


## The "max-pps", "max-recv-pps", "max-send-pps" Attributes

This set of paramters specificy maximum video pixelrate in pixels
per second. 'max-send-pps' and 'max-recv-pps' provides granular
control for setting the video pixelrate for send and receive directions 
respectively. 'max-pps' MUST be used when asymmetrical video pixelrate
setting per direction is not required.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> max-send-pps=<send-pps-val> \
max-recv-width=<recv-pps-val> ...

(OR)

a=rid:<rid-identifier> pt=<fmt-list> max-pps=<pps-val> ...

Example:
1) Asymmetric video pixelrate
a=rid:1 pt=96 max-pps-width=1280 max-pps-width=320

2) Symmetric video pixelrate
a=rid:1 PT=96 max-pps=1280 
~~~~~~~~~~~~~~~


## The "depend” attribute

The 'depend' attribute can be used to establish relationship
between 'rid-identifiers'. Such relationship exists when
signaling layer dependencies for Scalable Video Coding (SVC)  or
relating a primary RTP Stream to a Secondary RTP Stream (FEC/RTX),
for example.

~~~~~~~~~~~~~~~

a=rid:<rid-identifier> pt=<fmt-list> depend=<rid-identifier>, ...

Example to show rid '2' depending on '1'
a=rid:1 pt=100
a=rid:2 pt=101 depend=1

~~~~~~~~~~~~~~~

The list of 'rid-identifiers' as part of the depend attribute MUST 
be defined elsewhere in the SDP. If not, such definition MUST be 
considered as error and the entire 'rid' line MUST be rejected.


# SDP Offer/Answer Procedures

This section describes the SDP Offer/Answer [RFC3264] procedures.

## Generating the Initial SDP Offer

For each media description in the offer, the Offer MAY choose to
include one or more "a=rid:" lines to specify a profile for 
media encoding. 

In order to constructs a given "a=rid" line, the offerer must follow 
the below steps: 

* It MUST generate a unique 'rid-identifier'. The chosen identifer
  MUST be unique across all the media descriptions in the SDP Offer.

* It MUST MUST list one or more Payload Types that will be impacted by the
  'a=rid:' definition. The Payload Types chosen MUST either be defined as 
  part of rtpmap or fmtp specification. If not, the Offer MUST not generate
  the "a=rid:" line.

* The Offerer then chooses the specific 'rid-level' attributes to be applied
  for the Payload Types listed. If 'fmtp' is also used to specifify media
  specific paramterts, then the 'rid-level' attributes will further constrain
  the equivalent 'fmtp' parameters for the given Payload Type.

It is RECOMMENDED that the Offerer include both "a=fmtp" and "a=rid" attrbutes
in the offer for descrcibing the media encoding formats. This is done to 
ensure interoperability between the EndPoints that donot understand/support
the 'rid' framework proposed in this specification.  

## Answerer processsing the SDP Offer

For each media description in the offer, and for each "a=rid:" attribute
in the media descrption , the receiver of the offer will perform the
following steps:

### Non 'rid' aware Answerer

If the receiver doesn't support/understand the 'rid' framework proposed in this specification, the entire "a=rid" line is ignored following the standard
RFC3264 Offer/Answer rules. Furher, if the offer lacked 'a=fmtp' attributes
for the Payload Types included, the Answerer MAY either reject the entire 
media description or decide to assume default media format parameters 
specific to the media codec identified by the rtpmap.


### 'rid' aware Answerer

If the answerer supports 'rid' framework, below steps are executed, in 
order, for each "a=rid" line in a given media description:

* Extract the rid-identifier from the "a=rid" line and verifies its uniqueness. In the case of duplicate, the entire "a=rid" line is rejected and MUST not be included in the SDP Answer.

* As a next step, the list of payload types are verified against the list obtained from rtpmap and/or fmtp attributes. If there is no exact match for all the Payload Type listed in the "a=rid" line, then reject the "a=rid" line.

* On verifying the Payload type match, the answerer shall ensure the "rid-level" attributes listed are supported and syntactically well formed. In the case of error the "a=rid" line is rejected.

* If the 'depend' rid attribute is specified, the answerer MUST make sure the rid-identifiers listed unambguously match the rid-identifiers in the Offer. 

* If the media description contains "a=fmtp" attribute,the answerer proceeds to examine attribute values provided in the "rid-level" attributes are within the scope of their fmtp equivalents for a given Payload Type.
[[TODO : Add example for this]]

The answerer shall proceed to construct SDP Answer for the SDP Offer once all
the above steps are verified and result in success.

## Generating the SDP Answer

The answerer 

## Offering Processing of the SDP Answwr

## Modifying the Session

# SDP Examples


## Two simulcast streams with PT reuse

This example shows and offer answer exchange where the offer propose to sendonly of two simulcast streams at 720P30 and 180P15. The answer accepts both of them.


# Formal Grammar

This section gives a formal Augmented Backus-Naur Form (ABNF)
[RFC5234] grammar for each of the new media and rid-level attributes
defined in this document. 

~~~~~~~~~~~~~~~~~~
rid-syntax = "a=rid:" rid-identifier SP rid-fmt-list SP rid-attr-list

rid-identifier = 1*(alpha-numeric / "-" / "_")

rid-fmt-list   = "pt=" rid-fmt *( ";" rid-fmt )
               / ”rid=” rid-list 

rid-fmt        = fmt

rid-attr-list  = rid-width-param
               / rid-height-param
               / rid-fps-param
               / rid-fs-param
               / rid-br-param
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

rid-depend-param = "depend=" rid-list

param-val  = byte-string

rid-list = rid-identifier *( "," rid-identifier )

; WSP defined in [RFC5234]
; fmt defined in [RFC4566]
; byte-string in [RFC4566]

~~~~~~~~~~~~~~~~~~~~~

# RTP 'rid' Header Extension

The payload, containing the identification-tag, of the RTP 'rid' header extension element can be encoded using either the one-byte or two-byte header [RFC5285]. The identification-tag payload is UTF-8 encoded, as in SDP.

Note, that set of header extensions included in the packet needs to be padded to the next 32-bit boundary using zero bytes [RFC5285].

It is recommended that the identification-tag is kept short. Due to the properties of the RTP header extension mechanism, when using the one-byte header, a tag that is 1-3 bytes will result in that a minimal number of 32-bit words are used for the RTP header extension, in case no other header extensions are included at the same time. 

# Open Issues

## Name of the identifier
The name 'rid' has not yet been finalized and the authors believe taking
help from the list would be a right approach for deciding the name.

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
    Description:   RTP Stream Format Identifier
    Contact:       <name@email.com>
    Reference:     RFCXXXX

~~~~~~~~~~~~~~~


## New SDP Media-Level attribute

This document defines "rid" as SDP media-level attribute.
    This attribute must be registered by IANA under
    "Session Description Protocol (SDP) Parameters" under "att-field
   (media level only)".

The "rid" attribute is used to identify characteristics of RTP stream
   with in a RTP Session. Its format is defined in Section XXXX.

## Registry for RID-Level Attributes

   This specification creates a new IANA registry named "att-field
   (rid level)" within the SDP parameters registry.  rid-level
   attributes MUST be registered with IANA and documented under the same
   rules as for SDP session-level and media-level attributes as
   specified in [RFC4566].

   New attribute registrations are accepted according to the
   "Specification Required" policy of [RFC5226], provided that the
   specification includes the following information:

   o  contact name, email address, and telephone number

   o  attribute name (as it will appear in SDP)

   o  long-form attribute name in English

   o  whether the attribute value is subject to the charset attribute

   o  a one-paragraph explanation of the purpose of the attribute

   o  a specification of appropriate attribute values for this attribute

   The initial set of rid-level attribute names, with definitions in
   Section XXXX of this document, is given below

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
