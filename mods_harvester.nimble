# Package

version       = "0.1.0"
author        = "Mark Baggett"
description   = "A simple binary to harvest all new MODS from an OAI provider."
license       = "GPL-3.0"
srcDir        = "src"
bin           = @["mods_harvester"]


# Dependencies

requires "nim >= 1.0.4"
requires "oaitools >=  0.2.2"
requires "argparse >= 0.10.0"
requires "progress >=  1.1.1"
