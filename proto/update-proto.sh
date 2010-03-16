#!/bin/bash

#
# Grab the latest Mumble.proto file from desktop Mumble.
#
curl "http://mumble.git.sourceforge.net/git/gitweb.cgi?p=mumble/mumble;a=blob_plain;f=src/Mumble.proto;hb=HEAD" > Mumble.proto.clean
cat Mumble.proto.objc Mumble.proto.clean > Mumble.proto
../3rdparty/protobuf/src/protoc --objc_out=. \
	-I../3rdparty/protobuf/src/ \
	-I. \
	Mumble.proto \
	../3rdparty/protobuf/src/google/protobuf/descriptor.proto \
	../3rdparty/protobuf/src/google/protobuf/objectivec-descriptor.proto
rm Mumble.proto.clean

#
# Patch the generated Descriptor.pb.m if needed.
#
if [ "`grep ProtocolBuffers.h Descriptor.pb.m`" != "" ]; then exit; fi
cat >Descriptor.pb.m.patch <<EOF
--- ./Descriptor.pb.m
+++ ./Descriptor.pb.m
@@ -1,3 +1,4 @@
 // Generated by the protocol buffer compiler.  DO NOT EDIT!
 
+#include "ProtocolBuffers.h"
 #import "Descriptor.pb.h"
 
EOF
patch --no-backup-if-mismatch -p0 < Descriptor.pb.m.patch
rm Descriptor.pb.m.patch
