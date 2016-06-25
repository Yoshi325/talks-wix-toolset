===========
WiX Toolset
===========

-------------------------------
The bees knees of MSI authoring
-------------------------------

:Author: Charles L. Yost
:Date: 2016-06


Description
===========
A 20 minute crash course on the basics of: Using the WiX Toolset to create your own MSIs. Debugging your MSIs. Creating a UI for your MSIs. Making MSI creation flexible enough for automation.


Speaker Bio
===========
Charles Yost is currently a Security Developer at Binary Defense Systems. He has worked in the IT industry for over 10 years in a wide variety of roles including: Printer Technician, VoIP  Systems Administrator, .Net Developer, and Web Developer. Throughout life his number one passion has been learning new skills. He can often be found researching a topic, attempting to keep up with the quickly evolving field of technology. Charles enjoys teaching and talking to others about technology. He is a member of NEOISF, and attends as many InfoSec conferences as he can justify with his wife.


Binary Defense Systems
======================
We are an MSSP providing 24/7/365 Monitoring & Detection, Threat Intelligence, SIEM Management, Incident Response and Consulting Services.

Contact
=======

Twitter: @CHARLESLYOST

GitHub & YouTube: Yoshi325

| This Talk:
| https://github.com/Yoshi325/talks-wix-toolset

Showtime!
=========

Why?
====

Repackage a product that isn't distributed as one.

. . .

Create a pre-configured or pre-seeded install.

. . .

Package an exploit or payload disguised as a valid installer.

How?
====
WiX Toolset @ http://wixtoolset.org/

WiX Toolset
===========
What is it?

----

The WiX toolset lets developers create installers for Windows Installer, the Windows installation engine.

Tools in the Set
================

Candle
======
Preprocesses and compiles WiX source files into object files (.wixobj).

Light
=====
Links and binds one or more .wixobj files and creates a Windows Installer database (.msi or .msm).

And Many More!
==============
* Lit
* Dark
* Heat
* Insignia
* Melt
* Torch
* Smoke
* Pyro
* WixCop
* WixUnit
* Lux & Nit

How?
====
It all starts with a wxs file.

. . .

A wxs file is basically a specially constructed xml file.

The Rules
=========
`WiX Schema Reference <http://wixtoolset.org/documentation/manual/v3/xsd/>`_

Lets Build One!
===============

Starting Out
============
Xml Declaration

. . .

.. code-block:: xml

  <?xml version="1.0"?>


Wix Element
===========
This is the top-level container element for every wxs file.

. . .

.. code-block:: xml

  <?xml version="1.0"?>
  <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
  ...
  </Wix>

.. class:: notes
`Wix Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/wix.html>`_


Product Element
===============
The Product element is analogous to the main function in a C program.

. . .

When linking, only one Product section can be given to the linker to produce a successful result.

. . .

Using this element creates an msi file.

----

.. code-block:: xml

  <?xml version="1.0"?>
  <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
    <Product
      Id='*'
      Language='1033'
      Manufacturer='Wash N Go'
      Name='Window Cleaner'
      UpgradeCode='$(var.ProductUpgradeCodeGuid)'
      Version='1.0.0.0'
    >
    </Product>
  </Wix>

.. class:: notes
  `Product Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/product.html>`_

Product Attributes
==================
Id
  The product code GUID for the product.

Language
  1033 is English/US

Manufacturer
  The manufacturer of the product.

Name
  The descriptive name of the product.

UpgradeCode
  The upgrade code GUID for the product.

Version
  The product's version string.

Product Attr. Tips
==================
Id
  You can use * to have this auto generated.

UpgradeCode
  How you tie different versions together

Package Element
===============
| Properties about the package,
| which can be seen on the package in Explorer.

----

.. code-block:: xml

  <?xml version="1.0"?>
  <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
    <Product
      [...]
    >
      <Package
        Compressed='yes'
        Description='For Cleaning Windows'
        InstallerVersion='200'
        InstallScope='perMachine'
        Platform='x86'
      />
    </Product>
  </Wix>

.. class:: notes
  `Package Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/package.html>`_

Package Attributes
==================
Compressed
  Set to 'yes' to have compressed files in the source.

Description
  The product full name or description.

InstallerVersion
  The minimum version of the Windows Installer required to install this package.

InstallScope
  Use this attribute to specify the installation scope of this package: per-machine or per-user.

Platform
  The platform supported by the package.

Package Attr. Tips
==================
InstallerVersion
  Unless you know you need something else: 200.

Platform
  Probably x86, maybe x64.

Directory Element
=================
Directory layout for the product.

----

.. code-block:: xml

  <?xml version="1.0"?>
  <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
    <Product [...]>
      <Package [...]/>
      <Directory Id='ProgramFilesFolder'>
        <Directory Id='COMPANYDIRECTORY' Name='WashNGo'>
          <Directory Id='INSTALLDIRECTORY' Name='WindowCleaner'>
          </Directory>
        </Directory>
      </Directory>
    </Product>
  </Wix>

.. class:: notes
  `Directory Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/directory.html>`_

Directory Attributes
====================
Id
  This value is the unique identifier of the directory entry.

Directory Attr. Tips
====================
Id
  | Might be a special one like ProgramFilesFolder.
  | Might be a generic one like COMPANYDIRECTORY or INSTALLDIRECTORY.

Name
  If Id is a generic one, Name sets the name.

Component Element
=================

Component for parent Directory. Required to group files.

----

.. code-block:: xml

  <?xml version="1.0"?>
  <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
    <Product [...]>
      <Package [...]/>
      <Directory Id='ProgramFilesFolder'>
        <Directory Id='COMPANYDIRECTORY' Name='WashNGo'>
          <Directory Id='INSTALLDIRECTORY' Name='WindowCleaner'>
            <Component
              Id='WINDOWCLEANERCOMPONENT'
              Win64='no'>
            </Component>
          </Directory>
        </Directory>
      </Directory>
    </Product>
  </Wix>

.. class:: notes
  `Component Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/component.html>`_

Component Attributes
====================
Id
  Component identifier; this is the primary key for identifying components.

Win64
  Set this attribute to 'yes' to mark this as a 64-bit component.

File Element
============

How to add files to your installer.

----

.. code-block:: xml

  <?xml version="1.0"?>
  <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
    <Product [...]>
      <Package [...]/>
      <Directory Id='ProgramFilesFolder'>
        <Directory Id='COMPANYDIRECTORY' Name='WashNGo'>
          <Directory Id='INSTALLDIRECTORY' Name='WindowCleaner'>
            <Component [...]>
            <File
                Name='window-cleaner.exe'
                Source='from\window-cleaner.exe'
            />
            </Component>
          </Directory>
        </Directory>
      </Directory>
    </Product>
  </Wix>

.. class:: notes
  `File Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/file.html>`_


File Attributes
===============
Name
  What the file will be installed as.

Source
  Where to get the file when packaging.

Feature & ComponentRef Elements
===============================
Feature
  Minimum to install something.

ComponentRef
  Create a reference to a Component element for install.

----

.. code-block:: xml

  <?xml version="1.0"?>
  <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
    <Product [...]>
      <Package [...]/>
      <Directory [...]/>
      <Feature Id='Complete' Level='1'>
        <ComponentRef Id='WINDOWCLEANERCOMPONENT'/>
      </Feature>
    </Product>
  </Wix>

.. class:: notes
  `Feature Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/feature.html>`_
  `ComponentRef Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/componentref.html>`_


Media Element
=============
Media element describes a disk that makes up the source media for the installation.

----

.. code-block:: xml

  <?xml version="1.0"?>
  <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
    <Product [...]>
      <Package [...]/>
      <Directory [...]/>
      <Feature [...]/>
      <Media
        Id='1'
        Cabinet='DiskOne.cab'
        EmbedCab='yes'
      />
    </Product>
  </Wix>

.. class:: notes
  `Media Element <http://wixtoolset.org/documentation/manual/v3/xsd/wix/media.html>`_

Media Attributes
================
Id
  Disk identifier.

Cabinet
  Cabnet file for the compressed files.

EmbedCab
  Instructs the binder to embed the cabinet in the product if 'yes'.

Media Attr. Tips
================
Id
  This number must be equal to or greater than 1.

Now to Compile
==============

Run candle against the wxs file:

.. code-block:: shell

  candle.exe window-cleaner.wxs

. . .

This will output errors, or a wixobj file.

Next to Link & Bind
===================

Run light against the wixobj file:

.. code-block:: shell

  light.exe -out window-cleaner-1.0.msi window-cleaner.wixobj

. . .

This will output errors, or a msi file.

What about UI?
==============
WiX Toolset isn't just tools. It comes with some useful dialog sets.

- WixUI_Advanced
- WixUI_FeatureTree
- WixUI_InstallDir
- WixUI_Minimal
- WixUI_Mondo

.. class:: notes

  `Using Built-in WixUI Dialog Sets <http://wixtoolset.org/documentation/manual/v3/wixui/wixui_dialog_library.html>`_

Debugging Tips
==============
Enable Windows Installer logging:

.. code-block:: shell

  HKLM:\\Software\\Policies\\Microsoft\\Windows\\Installer

.. class:: notes

  `How to enable Windows Installer logging <https://support.microsoft.com/en-us/kb/223300>`_

Debugging Tips
==============
Call the MSI with the logging flags:

.. code-block:: shell

  msiexec /i window-cleaner-1.0.msi /l*v window-cleaner.log

.. class:: notes

  `How To: Get a Log of Your Installation for Debugging <http://wixtoolset.org/documentation/manual/v3/howtos/general/get_a_log.html>`_

Debugging Tips
==============
Under the covers:

Orca from the Windows SDK

.. class:: notes

  `How To: Look Inside Your MSI With Orca <http://wixtoolset.org/documentation/manual/v3/howtos/general/look_inside_msi.html>`_


The End
=======

Enjoy the rest of BSidesCLE 2016!!
