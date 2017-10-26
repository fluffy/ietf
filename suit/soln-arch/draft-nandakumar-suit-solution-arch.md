%%%
    title = "Solution Architecture - Secure Firmware Upgrade (SEFU)"
    abbrev = "SEFU"
    category = "std"
    docName = "draft-nandakumar-suit-solution-arch"
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

This specification defines a solution architecture for performing
secure firmware upgrade for Internet of Things (IOT). The ulterior
motive is to have a framework that is simple, secure and that uses 
most common formats and standards in the industry and 
that works over Internet.

{mainmatter}

# Introduction

Internet of Things (IOT) represents a plethora of devices that come in
varying flavors of constrained sizes, computing power and operating 
considerations. These devices either need minimal or no manangement for their operation. 

Vulnerabilites with IOT devices have raised serious concerns offlate and
has called for a way to install or update the firmware on these devices
in an automated and secure fashion. A common challenge with the 
existing firmware update mechanism is they become too heavy or 
complicated to be useful with the constrained devices. Hence, there 
is a need to define an firmware update solution that is light weight, 
secure can operate in variety of deployment environments and 
is built on well established standards. 


# Terminology

In this document, the key words "MUST", "MUST NOT", "SHOULD", "SHOULD
NOT", "MAY", and "OPTIONAL" are to be interpreted as described in RFC
2119 [@!RFC2119] and indicate requirement levels for compliant
implementations.

# Device Considerations

For purpoeses of this draft, the category of devices with very 
small memory (< 32kb), limited flash (<256kb) are termed as IoT 
devices.

There are certain types of devices that delete the firmware image
except for the bootloader before proceeding with the upgrade. The
proposed solution should enable firmware updates with a bootloader
as small as 10K in size and should be implementable within the
constrains of the bootloader.

Alternatively, the scenarios where the devices are large enough to
completely downloade a new firmware image before updating, the solution
should be naturally applicable.

# Solution Overview

The draft-requirements-00 captures various requirements that drives 
the solution defined in this specification.

Below is a high-level solution flow for a successful firmware
update on a IoT device.

~~~
           Successful Firmware Update Flow
                  
                 on-ready to update
                      firmware
                         |
                         |
              Can access firmware sever  
                in the local domain ?
                         | 
                         |
                 ------------------
            Yes  |                | No
                 |                |       
        Download signed        Download signed
        manifest from           manifest from
        local server           manufacturer's 
        well-known URL         per-configured URL
                 |                 |
                 |                 |
                Validate manifest via
                pre-installed public key
                          |
                          |
              Download the firmware image
              from the location in manifest
                          |
                          |
                 verify commit hashes
                 on the fimware image
                          |
                          |         
                 complete installation
~~~


# Solution Components
Following serveral sub-sections define various components
that makes up the proposed solution architecture

## Manifest
A firmware manifest serves as cryptographic representation 
for metadata about the firmware. A manifest file identies
information about the actual firmware image, its location,
applicable device(s) and so on. It is cryptographically signed
by the provider (usually the manufacturer) of the firmware.


~~~
                Minimal Manifest in JSON format

{
  "manifestVersion" : "1.0",
  "timestamp": "2017-12-10T15:12:15Z",
  "manufacturer": "manufacturer.com",
  "model": "c7960",
  "firmwareVersion": "10.4.12",
  "firmwareLocation”: "well-known location",
  "firmwareCryptoInfo": {
    {
      "commitHash": [
        {
          "digestAlgo": "sha256",
          "hash": "..................."
        },
        {
          "digestAlgo": "sha512",
          "hash": "..................."
        }
      ]
    }
  }
  “key-info”: <most recent public key info> 
}

~~~

Above shows example of a minimally defined manifest that identifies
the mandatory attributes as explained below

* manifestVersion: Version of the manifest
* timestamp:  Time when the manifest was created.
* manufacturer: An identifier of the manufacturer providing
                the firmware image, represented as String
* model:        Device Model, a String
* firmwareVersion: Firmware Version in the format "major.minor.revision"
* firmwareLocation: Location of the firmware images
* firmwareCryptoInfo: Commit Hash information

## Manifest Format
   JSON representation is recommneded as the default format for describing the manifest. Optionally, formats such as CBOR (see example section) can be 
   used for the same. If more than one format is used, the IoT device can
   pick one based on its implementation. The firmware download protocol 
   identifies the right format supported by the IoT device.

## Manifest Security 
  The Manifest file MUST be cryptographically signed by the private key of the
  manufacturer or the provider of the firmware. This is to ensure source authenticity
  and to protect integrity of the manifest and the firmware itself.

  JWS is the format recommended to store the signed manifest.
  
  ~~~
  signed_manifest := JWS(manifest.json)
  ~~~
  
  If CBOR is used for describing the manifest, COSE is recommended for signing.

 Optionally , the proposed solution also recommends hash based signatures (hash-sigs) to sign the manifest.

  ~~~
  signed_manifest := hash-sigs(manifest.json, private-key)
  ~~~

## Manifest Optional Extensions

  There may be scenarios where the minimalistic manifest defined above may not
  capture all the requirements for a given deployment setting. In those 
  circumstances, the manifest can be optionally extended to meet the 
  requirements in a extensional specifications.

  
## Firmware Server Discovery

When it is time for an IoT device to perform a firmware upgrade, the device performs couple of steps to decide the location to download the needed firmware.
A device might need to download the new firmware when it is either booting for the first time after deployment or there is a need to upgrade to a newer upgraded firmware available. 
 
The server discovery procedure starts with the boot-loader attempting to access a server that is local to the domain in which the device operates. The URL to look for a local server is automatically generated using the DHCP domain name.

~~~

For example, if the domain name was example.com, 
the HTTP URL might be https://_firmware.example.com/.wellknown/

~~~

In situations where the IoT device cannot access the Internet (factory/enterprise
settings, for example), the aforementioned approach might be the only way for the device to perform any kind of firmware or security updates.

However, if the local server cannot be reached or not deployed (say home environments), the device proceeds to download the manifest and firmware from the firmware server URL pre-configured in the bootloaded by the manufacturer of the device.

If either of the procedures doesn’t work, the IoT device is either unusable or might end up running an old version of the firmware.

## Firmware Download protocol
One can envision two possibilities while downloading the firmware:

* Scenarios where the IoT device downloads firmware directly. This is done 
in order to minimize number of connections.

* Scenarios where a manifest is retrieved and followed by downloading the
actual firmware image.

### Manifiest Download
Firmware download protocol enables choosing the approach 
apporpriate to the IoT device, for example.

On performing the "Firmware Server Discovery", if a local server is chosen, 
the device forms a query URL by constructing an endpoint at
".well-known/manifest/device/<model-no>/manifest.json"

Then a HTTPS GET request is sent to that URL

~~~
https://firmware.example.com/.wellknown/manifest/device/<model-no>/manifest.json
~~~

The response would be a JSON result of the manifest file. Similarly, the
end-point supporting CBOR parsing can request for the CBOR version of the 
mannifest.

### Firmware Download

Once the manifest is downloaded and validated, the device proceeds to download the firmware image from the location identified in the firmware manifest. There might be situations where a firmware image is split into multiple files to imply a functional division of the components. This type of firmware can be used because devices that are very low in memory and thus loading the complete image might not be possible. The manifest file may contain the information to indicate the same.


Above example shows use of HTTP as the communication protocol to talk to the 
firmware server. If the end-point is capable of doing COAP or other propreitary
protocols, a similar process as above can be applied to retrieve the manifest
and the firmware from a well-known place on the local server

Alternatively the device might proceed to reachout to pre-configured URL from
the manufacturer if local server discovery fails. 


## Validation Procedures
The downloaded manifest and firmware is validated before being used..

* Manifest file signature is validated for source and integrity verification. If encrypted, the manifest is decrypted before proceeding as defined in “Manifest” procedures.

* On successful validation of the manifest, the device verifies the commit hashes
for component of the firmware downloaded against the ones provided in the 
"firmwareCryptoIndo" section of the manifest. 



# IANA Consideration 

TODO 


# Security Considerations 

TODO - explain importance of HTTPS
TODO - Talk about roaming IoT Device

# Acknowledgements 

Thanks IOTSU workship.

