%%%
    title = "Solution Requirements - Secure Firmware Upgrade (SEFU)"
    abbrev = "SEFU"
    category = "std"
    docName = "draft-nandakumar-suit-sefu-requirements"
    ipr = "trust200902"

    [pi]
    symrefs = "yes"
    sortrefs = "yes"
    toc = "yes"

    [[author]]
    initials = "S."
    surname = "Nandakumar"
    fullname = "Suhas Nandakumar"
    organization = "Cisco"
      [author.address]
      email = "snandaku@cisco.com"
    
    [[author]]
    initials = "C."
    surname = "Jennings"
    fullname = "Cullen Jennings"
    organization = "Cisco"
      [author.address]
      email = "fluffy@iii.ca"

    [[author]]
    initials = "S."
    surname = "Cooley"
    fullname = "Shaun Cooley"
    organization = "Cisco"
      [author.address]
      email = "scooley@cisco.com"


%%%

.# Abstract

The IETF SUIT effort has been forming to define a secure firmware 
upgrade solution for Internet of Things (IOT). Recent vulnerabilities
and need to upgrade firmware on the IoT devices for security updates in
a standradized, secure , automated fashion has been the driving 
force behind this work. 

This specification is a requirements document to aid in developing 
a solution for Secure Firmware upgrade of the IoT devices.

{mainmatter}

# Introduction

Come back to this 

# Terminology

In this document, the key words "MUST", "MUST NOT", "SHOULD", "SHOULD
NOT", "MAY", and "OPTIONAL" are to be interpreted as described in RFC
2119 [@!RFC2119] and indicate requirement levels for compliant
implementations.

# Solution Requirements
Informally, a secure firmware upgrade solution might need to address
following components:

* Secure firmware description container format, in the form of Manifest
* Locating server to download the firmware from
* Downloading the manifest and the firmware image
* Cryptographycally validate the manifest and signed code images
* Complete the installation

Given above tasks, this specification breaks down the secure firmware
upgrade solution into following requirements.

* Solution must allow devices that delete the old firmware before installing
the new firmware. Thus implying a solution that can easily be implementable
on a minimal bootloader

* Solution must enable devices that have enough memory to have the new firmware 
image of the firmware simulateneoulsy with the existing image.

* The manifest format should be self describing.

* The charter must enable manifest in different formats such as JSON, 
CBOR, ASN.1

* Manifest must allow metadata about the firmware sourced by a single
manufactuter

* Optinally, the solution may allow the manifest to describe metadata
about firmwares from different providers

* The solution should enable firmware as a single image.

* Optionally, the solution may enable firmware to be split into multiple images.

* The charter should recommend a solution agnostic to the format of the firmware image and inter dependencies. Dependency management is complicated & is by nature proprietery and should not be in the initial scope.


* The proposed solution must provide mechanism to discover where to download the 
firmware from.

* The proposed solution should allow flexibility to choose the underlying transport 
protocol as defined by the deployment scenarios. The WG should define a MTI set of protocols that firmware serves need to implement and clients can choose which one to use.
 
* The proposed solution must enable device to validate signature on the manifest
and signed firmware image(s).

* Optionally, the solution might want to support encrypted manifest and firmware.

* The proposed solution should enable crypto agility and prevent roll-back attacks.

* Solution should allow for secure transition between the generations of the keying material.

* Charter shouldnot invent new crypto or transports and use existing techniques.



# IANA Consideration 

TODO 


# Security Considerations 

TODO

# Acknowledgements 

Thanks IOTSU workship.

# Appendix - Charter Updates
TBD