---
title: "WebRTC Dependencies"
abbrev: WebRTC Dependencies
docname: draft-jennings-rtcweb-deps-08
date: 2016-02-25
category: info
ipr: trust200902

coding: us-ascii

pi:
  toc: no
  sortrefs: yes
  symrefs: yes

author:
 -
    ins: C. Jennings
    name: Cullen Jennings
    email: fluffy@iii.ca
    org: Cisco 


normative:
  I-D.ietf-avtcore-6222bis:
  I-D.ietf-avtcore-avp-codecs:
  I-D.ietf-avtcore-multi-media-rtp-session:
  I-D.ietf-avtcore-rtp-circuit-breakers:
  I-D.ietf-avtcore-rtp-multi-stream-optimisation:
  I-D.ietf-avtcore-rtp-multi-stream:
  I-D.ietf-avtcore-srtp-encrypted-header-ext:
  I-D.ietf-avtext-multiple-clock-rates:
  I-D.ietf-httpbis-tunnel-protocol:
  I-D.ietf-ice-dualstack-fairness:
  I-D.ietf-jose-json-web-algorithms:
  I-D.ietf-mmusic-msid:
  I-D.ietf-mmusic-proto-iana-registration:
  I-D.ietf-mmusic-sctp-sdp:
  I-D.ietf-mmusic-sdp-bundle-negotiation:
  I-D.ietf-mmusic-sdp-mux-attributes:
  I-D.ietf-mmusic-trickle-ice:
  I-D.ietf-mmusic-trickle-ice:
  I-D.ietf-payload-flexible-fec-scheme:
  I-D.ietf-payload-rtp-opus:
  I-D.ietf-payload-vp8:
  I-D.ietf-rtcweb-alpn:
  I-D.ietf-rtcweb-audio:
  I-D.ietf-rtcweb-data-channel:
  I-D.ietf-rtcweb-data-protocol:
  I-D.ietf-rtcweb-data-protocol:
  I-D.ietf-rtcweb-fec:
  I-D.ietf-rtcweb-gateways:
  I-D.ietf-rtcweb-jsep:
  I-D.ietf-rtcweb-overview :
  I-D.ietf-rtcweb-overview:
  I-D.ietf-rtcweb-rtp-usage:
  I-D.ietf-rtcweb-security-arch:
  I-D.ietf-rtcweb-security:
  I-D.ietf-rtcweb-security:
  I-D.ietf-rtcweb-stun-consent-freshness:
  I-D.ietf-rtcweb-transports:
  I-D.ietf-rtcweb-video:
  I-D.ietf-tls-applayerprotoneg:
  I-D.ietf-tram-alpn:
  I-D.ietf-tram-stun-dtls:
  I-D.ietf-tram-turn-third-party-authz:
  I-D.ietf-tsvwg-rtcweb-qos:
  I-D.ietf-tsvwg-sctp-dtls-encaps:
  I-D.ietf-tsvwg-sctp-ndata:
  I-D.ietf-tsvwg-sctp-prpolicies:
  I-D.nandakumar-rtcweb-stun-uri:
  I-D.petithuguenin-behave-turn-uris:
  I-D.shieh-rtcweb-ip-handling:
  RFC2119:
  RFC3264:
  RFC4566:
  RFC5245:
  RFC5389:
  RFC5888:
  RFC6236:
  RFC6464:
  RFC6465:
  RFC6544:
  RFC6904:
  RFC7007:
  RFC7022:
  RFC7064:
  RFC7064:
  RFC7065:
  RFC7065:
  RFC7160:
  RFC7301:
  RFC7350:
  RFC7443:
  RFC7496:
  RFC7518:
  RFC7587:
  RFC7635:
  RFC7639:
  RFC7675:
  

informative:
  I-D.alvestrand-rtcweb-gateways:
  I-D.hutton-rtcweb-nat-firewall-considerations:
  I-D.ietf-avtcore-multiplex-guidelines:
  I-D.ietf-avtcore-rtp-topologies-update:
  I-D.ietf-avtcore-srtp-ekt:
  I-D.ietf-avtext-rtp-grouping-taxonomy:
  I-D.ietf-dart-dscp-rtp:
  I-D.ietf-rmcat-cc-requirements:
  I-D.ietf-rtcweb-audio-codecs-for-interop:
  I-D.ietf-rtcweb-use-cases-and-requirements:
  I-D.kaufman-rtcweb-security-ui:
  I-D.lennox-payload-ulp-ssrc-mux:
  I-D.ietf-rtcweb-sdp:
  I-D.roach-mmusic-unified-plan:
  I-D.westerlund-avtcore-multiplex-architecture:


--- abstract

This draft will never be published as an RFC and is meant purely to help track the
IETF dependencies from the W3C WebRTC documents.

--- middle

Dependencies
============

The key IETF specifications that the W3C GetUserMedia specification normatively depends on is:
{{I-D.ietf-rtcweb-security-arch}} and 
{{RFC2119}}.

The key IETF specifications that the W3C WebRTC specification normatively
depended on are:
{{I-D.ietf-rtcweb-alpn}},
{{I-D.ietf-rtcweb-audio}},
{{I-D.ietf-rtcweb-data-channel}},
{{I-D.ietf-rtcweb-data-protocol}},
{{I-D.ietf-rtcweb-jsep}},
{{I-D.ietf-rtcweb-rtp-usage}},
{{I-D.ietf-rtcweb-security-arch}},
{{I-D.ietf-rtcweb-transports}},
{{I-D.ietf-rtcweb-video}},
{{I-D.ietf-tram-turn-third-party-authz}},
{{I-D.ietf-tsvwg-rtcweb-qos}},
{{RFC2119}},
{{RFC4566}},
{{RFC5389}},
{{RFC5888}},
{{RFC6236}},
{{RFC6464}},
{{RFC6465}},
{{RFC6544}},
{{RFC7064}},
{{RFC7065}}
{{RFC3264}},
{{RFC5245}}, 
and informatively depends on 
{{I-D.ietf-rtcweb-overview}}, 
{{I-D.ietf-rtcweb-security}},
{{I-D.shieh-rtcweb-ip-handling}},
and 
{{I-D.ietf-mmusic-trickle-ice}}.

In addition 3GPP work normatively depends on {{I-D.ietf-rtcweb-gateways}}.

These IETF drafts in turn normatively depend on the following drafts:
(Note this list is out of date)
{{I-D.ietf-avtcore-multi-media-rtp-session}}, 
{{I-D.ietf-avtcore-rtp-circuit-breakers}}, 
{{I-D.ietf-avtcore-rtp-multi-stream-optimisation}}, 
{{I-D.ietf-avtcore-rtp-multi-stream}}, 
{{I-D.ietf-ice-dualstack-fairness}}, 
{{I-D.ietf-jose-json-web-algorithms}}.
{{I-D.ietf-mmusic-msid}}, 
{{I-D.ietf-mmusic-proto-iana-registration}},
{{I-D.ietf-mmusic-sctp-sdp}}, 
{{I-D.ietf-mmusic-sdp-bundle-negotiation}}, 
{{I-D.ietf-mmusic-sdp-mux-attributes}}, 
{{I-D.ietf-mmusic-trickle-ice}},
{{I-D.ietf-payload-flexible-fec-scheme}},
{{I-D.ietf-payload-rtp-opus}}, 
{{I-D.ietf-payload-vp8}},
{{I-D.ietf-rtcweb-alpn}}, 
{{I-D.ietf-rtcweb-data-protocol}}, 
{{I-D.ietf-rtcweb-fec}},
{{I-D.ietf-rtcweb-security}}, 
{{I-D.ietf-rtcweb-stun-consent-freshness}}, 
{{I-D.ietf-tls-applayerprotoneg}},
{{I-D.ietf-tram-alpn}}, 
{{I-D.ietf-tsvwg-rtcweb-qos}}, 
{{I-D.ietf-tsvwg-sctp-dtls-encaps}}, 
{{I-D.ietf-tsvwg-sctp-ndata}}, and 
{{I-D.ietf-tsvwg-sctp-prpolicies}}.

Right now security normatively depends on
{{I-D.ietf-rtcweb-overview }}.

The drafts webrtc currently normatively depends on that are not WG drafts are:
{{I-D.shieh-rtcweb-ip-handling}}

A few key drafts that the work informatively depends on:
{{I-D.alvestrand-rtcweb-gateways}}, 
{{I-D.hutton-rtcweb-nat-firewall-considerations}}, 
{{I-D.ietf-avtcore-multiplex-guidelines}}, 
{{I-D.ietf-avtcore-rtp-topologies-update}}, 
{{I-D.ietf-avtcore-srtp-ekt}}, 
{{I-D.ietf-avtext-rtp-grouping-taxonomy}}, 
{{I-D.ietf-dart-dscp-rtp}}, 
{{I-D.ietf-mmusic-trickle-ice}}, 
{{I-D.ietf-rmcat-cc-requirements}}, 
{{I-D.ietf-rtcweb-use-cases-and-requirements}}, 
{{I-D.kaufman-rtcweb-security-ui}}, 
{{I-D.lennox-payload-ulp-ssrc-mux}}, 
{{I-D.ietf-rtcweb-sdp}}, 
{{I-D.roach-mmusic-unified-plan}}, 
{{I-D.ietf-rtcweb-audio-codecs-for-interop}},
{{I-D.westerlund-avtcore-multiplex-architecture}}.


Time Estimates
-

The following table has some very rough estimates of when the draft will become an
RFC. Historically these dates have often taken much longer than the estimates
so take this with a large dose of salt.

Last updated Feb 25, 2016.

| ETA            | Draft Name  |
| {{RFC6904}}    | {{I-D.ietf-avtcore-srtp-encrypted-header-ext}}  |
| {{RFC7007}}    | {{I-D.ietf-avtcore-avp-codecs}}  |
| {{RFC7022}}    | {{I-D.ietf-avtcore-6222bis}}  |
| {{RFC7064}}    | {{I-D.nandakumar-rtcweb-stun-uri}}  |
| {{RFC7065}}    | {{I-D.petithuguenin-behave-turn-uris}}  |
| {{RFC7160}}    | {{I-D.ietf-avtext-multiple-clock-rates}}  |
| {{RFC7301}}    | {{I-D.ietf-tls-applayerprotoneg}}  |
| {{RFC7350}}    | {{I-D.ietf-tram-stun-dtls}}  |
| {{RFC7443}}    | {{I-D.ietf-tram-alpn}}  |
| {{RFC7496}}    | {{I-D.ietf-tsvwg-sctp-prpolicies}}  |
| {{RFC7518}}    | {{I-D.ietf-jose-json-web-algorithms}} |
| {{RFC7587}}    | {{I-D.ietf-payload-rtp-opus}}  |
| {{RFC7635}}    | {{I-D.ietf-tram-turn-third-party-authz}} |
| {{RFC7639}}    | {{I-D.ietf-httpbis-tunnel-protocol}} |
| {{RFC7675}}    | {{I-D.ietf-rtcweb-stun-consent-freshness}}  |
| Auth 48         | {{I-D.ietf-payload-vp8}}  |
| Auth 48         | {{I-D.ietf-rtcweb-video}}  |
| Miss Ref        | {{I-D.ietf-rtcweb-rtp-usage}}  |
| Miss Ref        | {{I-D.ietf-tsvwg-sctp-dtls-encaps}}  |
| RFC Ed          | {{I-D.ietf-rtcweb-data-channel}}  |
| RFC Ed          | {{I-D.ietf-rtcweb-data-protocol}}  |
| RFC Ed          | {{I-D.ietf-avtcore-multi-media-rtp-session}}  |
| RFC Ed          | {{I-D.ietf-avtcore-rtp-multi-stream-optimisation}}  |
| RFC Ed          | {{I-D.ietf-avtcore-rtp-multi-stream}}  |
| IETF LC          | {{I-D.ietf-rtcweb-audio}}  |
| IETF LC          | {{I-D.ietf-avtcore-rtp-circuit-breakers}}  |
| IETF LC          | {{I-D.ietf-mmusic-proto-iana-registration}} |
| AD Eval         | {{I-D.ietf-mmusic-sdp-mux-attributes}}  |
| PubReq         | {{I-D.ietf-rtcweb-security-arch}}  |
| PubReq         | {{I-D.ietf-rtcweb-security}}  |
| Write Up        | {{I-D.ietf-mmusic-sdp-bundle-negotiation}}  |
| Write Up      | {{I-D.ietf-rtcweb-alpn}}  |
| WGLC            | {{I-D.ietf-rtcweb-overview}}  |
| WGLC            | {{I-D.ietf-tsvwg-rtcweb-qos}}  |
|                  | {{I-D.ietf-tsvwg-sctp-ndata}}  |
|                  | {{I-D.ietf-rtcweb-transports}}  |
|                 | {{I-D.ietf-mmusic-msid}}  |
|                 | {{I-D.ietf-mmusic-sctp-sdp}}  |
|                 | {{I-D.ietf-rtcweb-jsep}}  |
|                | {{I-D.ietf-rtcweb-fec}} |
|                | {{I-D.ietf-payload-flexible-fec-scheme}} | 
|                | {{I-D.ietf-mmusic-trickle-ice}}  |
|                | {{I-D.ietf-ice-dualstack-fairness}} |
|               | {{I-D.shieh-rtcweb-ip-handling}} |
