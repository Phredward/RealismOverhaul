SHELL=/bin/bash
PROJ_NAME = $(shell basename `pwd`)
CONFIG_DIR = configs
VERSION = $(shell git describe --tags)
BRANCH := $(shell git rev-parse --abbrev-ref HEAD 2>&1)

ZIPFILE := $(PROJ_NAME)-$(TRAVIS_TAG).zip

all: clean meta

release: zip

ifdef TRAVIS_TAG
meta:
	python makeMeta.py $(TRAVIS_TAG)
	cp RO.version RealismOverhaul/RO.version
else
meta:
endif

zip: meta
	zip -r $(ZIPFILE) RealismOverhaul EngineGroupController KAS ModuleRCSFX RemoteTech ThunderAerospace

clean:
	-rm *.zip
	-rm RealismOverhaul/*.version
	-rm *.version
