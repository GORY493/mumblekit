// Copyright 2009-2012 The MumbleKit Developers. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

@interface MKAudioOutputUser () {
@protected
    NSString    *name;
    NSUInteger  bufferSize;
    float       *buffer;
    float       *volume;
    float       pos[3];
}
@end