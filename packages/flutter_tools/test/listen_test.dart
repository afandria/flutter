// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:mockito/mockito.dart';
import 'package:sky_tools/src/commands/listen.dart';
import 'package:test/test.dart';

import 'src/mocks.dart';

main() => defineTests();

defineTests() {
  group('listen', () {
    test('returns 0 when no device is connected', () {
      ListenCommand command = new ListenCommand(singleRun: true);
      applyMocksToCommand(command);
      MockDeviceStore mockDevices = command.devices;

      when(mockDevices.android.isConnected()).thenReturn(false);
      when(mockDevices.iOS.isConnected()).thenReturn(false);
      when(mockDevices.iOSSimulator.isConnected()).thenReturn(false);

      CommandRunner runner = new CommandRunner('test_flutter', '')
        ..addCommand(command);
      runner.run(['listen']).then((int code) => expect(code, equals(0)));
    });
  });
}
