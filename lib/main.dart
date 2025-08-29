import 'package:flutter/material.dart';
import 'package:wifi_assistant_client_flutter/wifi_assistant_client_flutter.dart';
import 'package:wifi_assistant_client_flutter/wifi_network.dart' as wifi_network;
import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:convert';
// import 'dart:math';
// import 'package:wifi_iot/wifi_iot.dart' as wifi_iot;
// import 'package:wifi_iot/wifi_iot.dart';

/*
 * WiFi Assistant Demo App
 * 
 * This demo app includes:
 * 1. WiFi Assistant plugin functionality testing
 * 2. SSH connection testing for optical fiber power checking
 * 3. Mock SSH implementation for demonstration purposes
 * 
 * Note: The SSH functionality uses mock implementations for demo purposes.
 * In a real app, you would use actual SSH libraries like ssh2 or similar.
 */

// Helper classes for SSH functionality
// class Endpoints {
//   static const String HOSTNAME = '172.16.2.1';
//   static const String PRIVATEKEYFORGXROUTER = '-----BEGIN OPENSSH PRIVATE KEY-----\n...\n-----END OPENSSH PRIVATE KEY-----';
//   static const String PRIVATEKEYFORTPROUTER = '-----BEGIN OPENSSH PRIVATE KEY-----\n...\n-----END OPENSSH PRIVATE KEY-----';
// }

// class Status {
//   static const String success = 'success';
//   static const String error = 'error';
//   static const String warning = 'warning';
// }

// class Utilities {
//   static void showSnackBar(BuildContext context, String message, String status) {
//     Color backgroundColor;
//     switch (status) {
//       case Status.success:
//         backgroundColor = Colors.green;
//         break;
//       case Status.error:
//         backgroundColor = Colors.red;
//         break;
//       case Status.warning:
//         backgroundColor = Colors.orange;
//         break;
//       default:
//         backgroundColor = Colors.grey;
//     }
    
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: backgroundColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
// }

// class SentryService {
//   static void captureException(Exception exception, StackTrace stackTrace) {
//     print('Sentry Exception: $exception');
//     print('StackTrace: $stackTrace');
//   }
// }

// class SSHSocket {
//   static Future<SSHSocket> connect(String hostname, int port, {Duration? timeout}) async {
//     // Mock implementation for demo purposes
//     // In a real implementation, this would establish an actual SSH connection
//     await Future.delayed(const Duration(seconds: 1));
//     return SSHSocket();
//   }
// }

// class SSHClient {
//   final SSHSocket socket;
//   final String username;
//   final List<SSHKeyPair>? identities;
//   final Function()? onPasswordRequest;
//   final Function(String)? printDebug;

//   SSHClient(this.socket, {
//     required this.username,
//     this.identities,
//     this.onPasswordRequest,
//     this.printDebug,
//   });

//   Future<Map<String, dynamic>> run(String command) async {
//     // Mock implementation for demo purposes
//     await Future.delayed(const Duration(seconds: 2));
    
//     if (command.contains('gx')) {
//       return {'result': [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]}; // "Hello World!" in bytes
//     } else if (command.contains('sy')) {
//       return {'result': [49, 48, 48, 48, 48]}; // "10000" in bytes
//     } else {
//       return {'result': [45, 50, 48, 46, 53]}; // "-20.5" in bytes
//     }
//   }

//   Future<dynamic> shell() async {
//     // Mock implementation
//     return null;
//   }

//   void close() {
//     // Mock implementation
//   }
// }

// class SSHKeyPair {
//   SSHKeyPair.fromPem(String privateKey, String passphrase) {
//     // Mock implementation
//   }
// }

// void printLogs(BuildContext context, String message) {
//   print('SSH Debug: $message');
// }

// Optical Fiber Check Function
//   Future<String> checkOpticalFiber(String deviceId, BuildContext context) async {
//   String response = '';
//   String command = deviceId.toString().toLowerCase().contains("gx")
//       ? "/bin/diag pon get transceiver rx-power"
//       : "/userfs/bin/tcapi get Info_PonPhy RxPower";
  
//   SSHSocket socket;
//   try {
//     socket = await SSHSocket.connect(
//       Endpoints.HOSTNAME,
//       22,
//       timeout: const Duration(seconds: 30),
//     );
//   } catch (e) {
//     Utilities.showSnackBar(context, "Socket Error $e", Status.error);
//     SentryService.captureException(
//         Exception("Installation - Socket Error at Optical power - $e"),
//         StackTrace.current);
//     return "Error: $e";
//   }

//   final SSHClient? client;
//   if (deviceId.toString().toLowerCase().contains("gx")) {
//     client = SSHClient(socket, username: 'wiom', identities: [
//       SSHKeyPair.fromPem(Endpoints.PRIVATEKEYFORGXROUTER, 'smortsecurity')
//     ]);
//   } else if (deviceId.toString().toLowerCase().contains("sy")) {
//     client = SSHClient(
//       socket,
//       username: 'wiom',
//       onPasswordRequest: () => 'wiom@SY2023*',
//       printDebug: (p0) => printLogs(context, p0),
//     );
//   } else {
//     client = SSHClient(socket, username: 'root', identities: [
//       SSHKeyPair.fromPem(Endpoints.PRIVATEKEYFORTPROUTER, 'avengers')
//     ]);
//   }

//   String result = '';
//   final shell = await client.shell();

//   print("Connecting to SSH$result");
//   print("Sending commands");

//   try {
//     Map<String, dynamic> sshResult = await client.run(command);
//     response = const Utf8Decoder().convert(sshResult["result"]);
//     response = response
//         .replaceAll("pon get transceiver rx-power \nRx Power: ", "")
//         .replaceAll("dBm\nRTK.0> command:", "")
//         .replaceAll("\n", "")
//         .trim();
//     if (deviceId.toString().toLowerCase().contains("sy")) {
//       response = (log(double.parse(response) / 10000) / log(10) * 100 / 10)
//           .toString();
//     }
//     client.close();
//     print("Disconnected");
//   } catch (e) {
//     Utilities.showSnackBar(context, "Operation failed $e", Status.error);
//     SentryService.captureException(
//         Exception("Installation - Socket Error at Optical power - $e"),
//         StackTrace.current);
//     response = 'Error: $e';
//   }
//   print("Final Response: $response");
//   return response;
// }

void main() {
  runApp(const WifiAssistantDemoApp());
}

class WifiAssistantDemoApp extends StatelessWidget {
  const WifiAssistantDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WiFi Assistant Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WifiAssistantHomePage(),
    );
  }
}

class WifiAssistantHomePage extends StatefulWidget {
  const WifiAssistantHomePage({Key? key}) : super(key: key);

  @override
  State<WifiAssistantHomePage> createState() => _WifiAssistantHomePageState();
}

class _WifiAssistantHomePageState extends State<WifiAssistantHomePage> {
  String _output = '';
  bool _isSSHTesting = false;

  // Remember last inputs
  String? _lastSsid;
  String? _lastBssid;
  String? _lastPassword;
  String? _lastSecurity = 'NONE';
  bool _lastJoinOnce = true;
  bool _lastWithInternet = false;

  // Remember last auto-login inputs
  String? _lastUrl;
  String? _lastDeviceId;

  Future<String?> _prompt(BuildContext context, String label, {String? initialValue}) async {
    final controller = TextEditingController(text: initialValue ?? '');
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter $label'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('OK')),
        ],
      ),
    );
  }

  void _showResult(dynamic result) {
    setState(() {
      _output = result.toString();
    });
  }

  // ---- Plugin tests ----

  Future<void> _loadWifiList() async {
    final List<wifi_network.WifiNetwork> result = await WifiAssistant.loadWifiList();
    final List<Map<String, dynamic>> listMap = result
        .whereType<wifi_network.WifiNetwork>()
        .map((wifi) => {
              "ssid": wifi.ssid?.trim() ?? "Unknown SSID",
              "bssid": wifi.bssid?.trim() ?? "Unknown BSSID",
              "level": wifi.level
            })
        .toList();
    final resultText = listMap
        .map((network) => "SSID: ${network['ssid']}, BSSID: ${network['bssid']}, Level: ${network['level']}")
        .join('\n');
    _showResult("Found ${listMap.length} networks:\n$resultText");
  }

  Future<void> _connect() async {
    final ssid = await _prompt(context, 'SSID', initialValue: _lastSsid);
    if (ssid == null || ssid.isEmpty) return;

    final bssid = await _prompt(context, 'BSSID (optional)', initialValue: _lastBssid);
    final password = await _prompt(context, 'Password (optional)', initialValue: _lastPassword);
    final securityStr = await _prompt(context, 'Security (WPA/WEP/NONE)', initialValue: _lastSecurity ?? 'NONE');
    final joinOnceStr = await _prompt(context, 'Join Once (true/false)', initialValue: _lastJoinOnce ? 'true' : 'false');
    final withInternetStr = await _prompt(context, 'With Internet (true/false)', initialValue: _lastWithInternet ? 'true' : 'false');

    final joinOnce = joinOnceStr?.toLowerCase() == 'true';
    final withInternet = withInternetStr?.toLowerCase() == 'true';

    _lastSsid = ssid;
    _lastBssid = bssid;
    _lastPassword = password;
    _lastSecurity = securityStr;
    _lastJoinOnce = joinOnce;
    _lastWithInternet = withInternet;

    try {
      bool result = await WifiAssistant.connect(
        ssid,
        bssid: bssid,
        password: password,
        security: NetworkSecurity.NONE,
        joinOnce: joinOnce,
        withInternet: withInternet,
        isHidden: false,
        timeoutInSeconds: 30,
      );
      _showResult("Connection result: $result");
    } catch (e) {
      _showResult("Connection error: $e");
    }
  }

  Future<void> _isEnabled() async {
    final result = await WifiAssistant.isEnabled();
    _showResult(result);
  }

  Future<void> _setEnabled() async {
    final enabledStr = await _prompt(context, 'Enable WiFi? (true/false)');
    if (enabledStr == null) return;
    final enabled = enabledStr.toLowerCase() == 'true';
    final result = await WifiAssistant.setEnabled(enabled);
    _showResult(result);
  }

  Future<void> _isConnected() async {
    final result = await WifiAssistant.isConnected();
    _showResult(result);
  }

  Future<void> _getLocalBSSID() async {
    final result = await WifiAssistant.getLocalBSSID();
    _showResult(result);
  }

  Future<void> _getLocalSSID() async {
    final result = await WifiAssistant.getLocalSSID();
    _showResult(result);
  }

  Future<void> _disconnect() async {
    final result = await WifiAssistant.disconnect();
    _showResult(result);
  }

  Future<void> _forceWifiUsage() async {
    final useWifiStr = await _prompt(context, 'Force WiFi Usage? (true/false)');
    if (useWifiStr == null) return;
    final useWifi = useWifiStr.toLowerCase() == 'true';
    final result = await WifiAssistant.forceWifiUsage(useWifi);
    _showResult(result);
  }

  Future<void> _removeWifiNetwork() async {
    final ssid = await _prompt(context, 'SSID');
    if (ssid == null) return;
    final result = await WifiAssistant.removeWifiNetwork(ssid);
    _showResult(result);
  }

  // ---- NEW: Auto-login test functions ----

  Future<void> _testCheckOpticalFiber() async {
    final deviceId = await _prompt(context, 'Device ID for Optical Fiber Check (e.g. GX..., SY..., TP...)', initialValue: _lastDeviceId);
    if (deviceId == null || deviceId.trim().isEmpty) return;

    _lastDeviceId = deviceId.trim();

    setState(() {
      _isSSHTesting = true;
      _output = "🔍 Testing SSH connection for optical fiber...\n";
      _output += "Device ID: $_lastDeviceId\n";
      _output += "Command: ${_lastDeviceId!.toLowerCase().contains("gx") ? "/bin/diag pon get transceiver rx-power" : "/userfs/bin/tcapi get Info_PonPhy RxPower"}\n";
      _output += "Connecting to router...\n";
    });

    try {
      // Use the plugin's checkOpticalFiber method instead of local implementation
      final result = await WifiAssistant.checkOpticalFiber(_lastDeviceId!);
      print("🔍 Debug - Result: $result");
      
      setState(() {
        _output += "\n✅ SSH Connection Successful!\n";
        _output += "📊 Optical Power Result:\n";
        
        // Parse and display the result nicely
        if (result.startsWith("Error:")) {
          _output += "❌ $result\n";
        } else {
          // Try to extract numeric value and display it nicely
          final numericValue = double.tryParse(result);
          if (numericValue != null) {
            _output += "📡 Optical Power: ${numericValue.toStringAsFixed(2)} dBm\n";
            
            // Add interpretation
            if (numericValue > -20) {
              _output += "⚠️  Warning: Power level is very high (> -20 dBm)\n";
            } else if (numericValue > -25) {
              _output += "✅ Good: Power level is within normal range (-25 to -20 dBm)\n";
            } else if (numericValue > -30) {
              _output += "⚠️  Low: Power level is getting low (-30 to -25 dBm)\n";
            } else {
              _output += "❌ Critical: Power level is very low (< -30 dBm)\n";
            }
          } else {
            _output += "📡 Raw Result: $result\n";
          }
        }
        
        _output += "\n🔍 Full Response: $result\n";
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Optical fiber check completed"))
      );
    } catch (e) {
      setState(() {
        _output += "\n❌ SSH Connection Failed!\n";
        _output += "Error: $e\n";
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Optical fiber check failed: $e"))
      );
    } finally {
      setState(() {
        _isSSHTesting = false;
      });
    }
  }

  Future<void> _testSSHConnection() async {
    final deviceId = await _prompt(context, 'Device ID for SSH Test (e.g. GX..., SY..., TP...)', initialValue: _lastDeviceId);
    if (deviceId == null || deviceId.trim().isEmpty) return;

    _lastDeviceId = deviceId.trim();

    try {
      setState(() {
        _isSSHTesting = true;
        _output = "Testing SSH connection...\n";
      });

      // Use the plugin's checkOpticalFiber method
      final result = await WifiAssistant.checkOpticalFiber(_lastDeviceId!);
      
      setState(() {
        _output += "SSH Connection Result:\n$result\n";
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("SSH test completed"))
      );
    } catch (e) {
      setState(() {
        _output += "Error: $e\n";
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("SSH test failed: $e"))
      );
    } finally {
      setState(() {
        _isSSHTesting = false;
      });
    }
  }

  // Future<void> _getFirmwareVersion() async {
  //   final deviceId = await _prompt(context, 'Device ID for Firmware Check (e.g. GX..., SY..., TP...)', initialValue: _lastDeviceId);
  //   if (deviceId == null || deviceId.trim().isEmpty) return;

  //   _lastDeviceId = deviceId.trim();

  //   try {
  //     setState(() {
  //       _isSSHTesting = true;
  //       _output = "Getting firmware version for device: $_lastDeviceId\nConnecting to ${Endpoints.HOSTNAME}...";
  //     });

  //   final result = await WifiAssistant.getFirmwareVersion(deviceId: _lastDeviceId!);
      
  //     setState(() {
  //       _isSSHTesting = false;
  //       _output = "Firmware Version Check Results:\n"
  //           "Device ID: $_lastDeviceId\n"
  //           "Host: ${Endpoints.HOSTNAME}\n"
  //           "Port: 22\n"
  //           "Result: $result\n\n"
  //           "Firmware version check completed!";
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _isSSHTesting = false;
  //       _output = "Firmware Version Check Failed:\n"
  //           "Device ID: $_lastDeviceId\n"
  //           "Host: ${Endpoints.HOSTNAME}\n"
  //           "Port: 22\n"
  //           "Error: $e\n\n"
  //           "Please check your network connection and device configuration.";
  //     });
  //   }
  // }

  Future<void> _testGetLoginPrefillScript() async {
    final deviceId = await _prompt(context, 'Device ID (e.g. GX..., SY..., TP...)', initialValue: _lastDeviceId);
    if (deviceId == null || deviceId.trim().isEmpty) return;

    _lastDeviceId = deviceId.trim();

    try {
      final result = await WifiAssistant.getLoginPrefillScript(deviceId: _lastDeviceId!);
      _showResult("Login Prefill Script:\n$result");
    } catch (e) {
      _showResult("Login Prefill Script Error: $e");
    }
  }

  void _navigateToWebLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WebLoginScreen()),
    );
  }

  // ---- UI ----

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WiFi Assistant Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: _loadWifiList, child: const Text('Load WiFi List')),
            ElevatedButton(onPressed: _connect, child: const Text('Connect (SSID, Password)')),
            ElevatedButton(onPressed: _isEnabled, child: const Text('Is WiFi Enabled?')),
            // ElevatedButton(onPressed: _setEnabled, child: const Text('Set WiFi Enabled')),
            ElevatedButton(onPressed: _isConnected, child: const Text('Is Connected?')),
            // ElevatedButton(onPressed: _connectToWifiSignal, child: const Text('Connect to WiFi Signal')),
            // ElevatedButton(onPressed: _connectToWifiAutomatically, child: const Text('Connect to WiFi Automatically')),
            // ElevatedButton(onPressed: _validateMac, child: const Text('Validate MAC')),
            // ElevatedButton(onPressed: _setRouterPPOEONT, child: const Text('Set Router PPOEONT')),
            // ElevatedButton(onPressed: _authorizeRouter, child: const Text('Authorize Router')),

            ElevatedButton(onPressed: _getLocalBSSID, child: const Text('Get Local BSSID')),
            ElevatedButton(onPressed: _getLocalSSID, child: const Text('Get Local SSID')),
            ElevatedButton(onPressed: _disconnect, child: const Text('Disconnect')),
            ElevatedButton(onPressed: _forceWifiUsage, child: const Text('Force WiFi Usage')),
            ElevatedButton(onPressed: _removeWifiNetwork, child: const Text('Remove WiFi Network')),

            const SizedBox(height: 12),
            // NEW buttons for testing Auto-Login features
            ElevatedButton(
              onPressed: _testCheckOpticalFiber,
              child: const Text('Test Check Optical Fiber'),
            ),
            ElevatedButton(
              onPressed: _testGetLoginPrefillScript,
              child: const Text('Test Get Login Prefill Script'),
            ),
            ElevatedButton(
              onPressed: _testSSHConnection,
              child: const Text('Test SSH Connection'),
            ),
            // ElevatedButton(
            //   onPressed: _getFirmwareVersion,
            //   child: const Text('Test Get Firmware Version'),
            // ),
            ElevatedButton(
              onPressed: _navigateToWebLogin,
              child: const Text('Web Login'),
            ),
            
            const SizedBox(height: 12),
            
            // SSH Test Description
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.all(color: Colors.orange[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🔌 SSH Connection Tests:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'These tests will attempt to connect to your router via SSH for:\n'
                    '• Optical fiber power level checking\n'
                    '• Firmware version detection\n'
                    'Supported device types: GX (GX routers), SY (SyroTech routers), TP (TP-Link routers).',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
            
            // SSH Connection Test Button
            ElevatedButton(
              onPressed: _isSSHTesting ? null : _testSSHConnection,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isSSHTesting ? Colors.grey : Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: _isSSHTesting 
                ? const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('Testing SSH...'),
                    ],
                  )
                : const Text('🔌 Test SSH Connection (Optical Fiber)'),
            ),
            
            const SizedBox(height: 8),
            
            // Firmware Version Check Button
            // ElevatedButton(
            //   onPressed: _isSSHTesting ? null : _getFirmwareVersion,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: _isSSHTesting ? Colors.grey : Colors.green,
            //     foregroundColor: Colors.white,
            //   ),
            //   child: _isSSHTesting 
            //     ? const Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           SizedBox(
            //             width: 16,
            //             height: 16,
            //             child: CircularProgressIndicator(
            //               strokeWidth: 2,
            //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //             ),
            //           ),
            //           SizedBox(width: 8),
            //           Text('Checking Firmware...'),
            //         ],
            //       )
            //     : const Text('📱 Get Firmware Version'),
            // ),

            const SizedBox(height: 24),
            
            // SSH Test Results Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🔌 SSH Connection Test Results:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _output.isEmpty ? 'No test results yet. Use the buttons above to test SSH connections and firmware versions.' : _output,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- NEW: WebView Screen for Auto-Login Testing ----

class WebLoginScreen extends StatefulWidget {
  const WebLoginScreen({Key? key}) : super(key: key);

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  late WebViewController _controller;
  String? _selectedUrl;
  String? _deviceId;
  bool _isLoading = false;
  String _status = 'Select a URL to start';

  final List<Map<String, String>> _urlOptions = [
    {'name': 'GX Router (Port 50080)', 'url': 'http://172.16.2.1:50080/'},
    {'name': 'TP-Link Router (Port 8080)', 'url': 'http://172.16.2.1:8080/'},
    {'name': 'SyroTech Router (Port 80)', 'url': 'http://172.16.2.1/'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _status = 'Loading page...';
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _status = 'Page loaded. Ready for auto-fill.';
            });
            _attemptAutoFill();
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _status = 'Error: ${error.description}';
            });
          },
        ),
      );
  }

  Future<void> _attemptAutoFill() async {
    if (_deviceId == null || _deviceId!.isEmpty) {
      setState(() {
        _status = 'Please enter a Device ID first';
      });
      return;
    }

    try {
      setState(() {
        _status = 'Getting auto-fill script...';
      });

      final script = await WifiAssistant.getLoginPrefillScript(deviceId: _deviceId!);
      
      if (script.startsWith('Error:')) {
        setState(() {
          _status = 'Failed to get auto-fill script: $script';
        });
        return;
      }

      setState(() {
        _status = 'Injecting auto-fill script...';
      });

      await _controller.runJavaScript(script);
      
      setState(() {
        _status = 'Auto-fill script injected successfully!';
      });
    } catch (e) {
      setState(() {
        _status = 'Auto-fill error: $e';
      });
    }
  }

  void _loadUrl(String url) {
    setState(() {
      _selectedUrl = url;
      _status = 'Loading $url...';
    });
    _controller.loadRequest(Uri.parse(url));
  }

  Future<void> _promptDeviceId() async {
    final controller = TextEditingController(text: _deviceId ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Device ID'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Device ID',
            hintText: 'e.g. GX..., SY..., TP...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        _deviceId = result.trim();
        _status = 'Device ID set: $_deviceId';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Login - Auto Fill Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (_selectedUrl != null) {
                _controller.reload();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // URL Selection Section
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Router URL:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: _urlOptions.map((option) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ElevatedButton(
                          onPressed: () => _loadUrl(option['url']!),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedUrl == option['url'] 
                                ? Colors.blue 
                                : Colors.grey[300],
                            foregroundColor: _selectedUrl == option['url'] 
                                ? Colors.white 
                                : Colors.black87,
                          ),
                          child: Text(
                            option['name']!,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _promptDeviceId,
                        child: Text(_deviceId ?? 'Set Device ID'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _deviceId != null ? _attemptAutoFill : null,
                      child: const Text('Manual Auto-Fill'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _status,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          
          // WebView Section
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    WebViewWidget(controller: _controller),
                    if (_isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}