#!/usr/bin/env python3

import os
import re
import subprocess

# import this function from other modules
def get_zones():
    """
    Returns 2 sets: The active zones and the inactive zones.
    """
    global _zones
    active_zones = set()
    inactive_zones = set()
    for z in _zones:
        if z():
            active_zones.add(z.__name__)
        else:
            inactive_zones.add(z.__name__)
    return active_zones, inactive_zones

# a list containing all zone functions
_zones = set()

# decorator for zone functions
def zone(func):
    # add the function to the zones set
    _zones.add(func)


# helper functions for zones

# helper function for environment variables
def env(varname):
    """
    Return the value of an environment variable or an empty string.
    This function can be called from within zone definitions to
    easily check the value of an environment variable.
    """
    if varname in os.environ:
        return os.environ[varname]
    else:
        return ""

def nm_option(name, value = None):
    """
    If only name is given, return a set containing all values from nmcli whose
    key matches name.
    If value is given, return if value is contained in the set.
    """
    global _nm_options
    if not nm_option.parsed:
        _parse_nm_options()
    if value:
        if name not in _nm_options:
            return False
        return (value in _nm_options[name])
    else:
        if name not in _nm_options:
            return set()
        else:
            return _nm_options[name]

nm_option.parsed = False
_nm_options = {}

def _parse_nm_options():
    global _nm_options
    # get nmcli output
    nm_output = subprocess.check_output(["nmcli", "-t", "-f", "all", "d", "show"])
    # process each line
    for line in nm_output.splitlines():
        # skip empty lines
        line = line.decode().strip()
        if not line:
            continue
        key, _, value = line.partition(":")
        key = _parse_nm_options.keyre.sub("", key)
        if key not in _nm_options:
            _nm_options[key] = set()
        _nm_options[key].add(value)
_parse_nm_options.keyre = re.compile(r'\[\d+\]$')

from ssh_autoconfig.zones_user import *
