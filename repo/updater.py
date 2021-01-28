#!/usr/bin/env python3.9

"""
Update the contents of this repository
AUTHOR: Jared Dyreson
"""

import gnupg  # external
import os
import re
import shutil
from natsort import natsorted, ns

email = "jareddyreson@csu.fullerton.edu"
username = "JaredDyreson"

# gpg = gnupg.GPG(gnupghome='/home/jared/')
# gpg.encoding = 'utf-8'
# ascii_armored_public_keys = gpg.export_keys(keyids)

home_dir = os.getcwd()
build_dir = f'{home_dir}/amd64/builds'
_re = re.compile("ubuntu", re.IGNORECASE)
_match = _re.match(os.uname().release)
# if not(_match):
    # raise ValueError("[ERROR] Please run on Ubuntu based systems")

test_dir = "/tmp/tuffix"

if(os.path.exists(test_dir)):
    shutil.rmtree(test_dir)
    os.mkdir(test_dir)
else:
    os.mkdir(test_dir)

_git_url = "https://github.com/mshafae/tuffix.git"

# os.system(f'git clone {_git_url} {test_dir}')
# os.chdir(test_dir)
# os.system('git checkout releasebuild')

pkg_base = "TuffixInstaller"
pkg_name = "Tuffix"
pkg_arch = os.uname().machine

# if(not os.path.exists(pkg_base)):
    # raise ValueError('[ERROR] Installer directory is not present, cowardly refusing')

deb_files = []
for dirpath, dirnames, files in os.walk(os.path.abspath("amd64")):
    if(files):
        deb_files.append(*files)

deb_files = natsorted(deb_files, alg=ns.IC)
current_pkg = deb_files[0]

_pkg_regex = re.compile("(?P<version>[0-9]+\.[0-9]+)\_(?P<revision>[0-9])")
_pkg_match = _pkg_regex.search(current_pkg)
version, revision = None, None

if(_pkg_match):
    version, revision = _pkg_match.group("version"),_pkg_match.group("revision")

_pkg_version_regex = re.compile("Version:\s+(?P<version>[0-9]+\.[0-9]+)\-(?P<revision>[0-9]+)")
_git_pkg_version, _git_pkg_revision = None, None

control_contents = []
with open(f'{test_dir}/{pkg_base}/DEBIAN/control') as fp:
    for line in fp.readlines():
        control_contents.append(line)
        _pkg_version_match = _pkg_version_regex.match(line)
        if(_pkg_version_match):
            _git_pkg_version, _git_pkg_revision = _pkg_version_match.group("version"), _pkg_version_match.group("revision")

if(_git_pkg_revision == revision):
    print(f"[INFO] No need to proceed further, git version renders {_git_pkg_revision} and database provides {revision}. Please update git version if you intended to update PPA")
    quit()

deb_output = f'{build_dir}/{pkg_name}_{_git_pkg_version}_{_git_pkg_revision}_{pkg_arch}'

os.system(f'dpkg-deb --build {pkg_base} {deb_output}')
os.system(f'reprepro --ask-passphrase -Vb . includedeb focal {deb_output}')

print(f'[INFO] Updating TuffixInstaller from revision {revision} to {_git_pkg_revision}')
