import 'package:flutter/material.dart';
import 'package:wifi_assistant_client_flutter/wifi_assistant_client_flutter.dart';
import 'package:wifi_assistant_client_flutter/wifi_network.dart' as wifi_network;
// import 'package:wifi_iot/wifi_iot.dart' as wifi_iot;
// import 'package:wifi_iot/wifi_iot.dart';


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
  
  // Remember last inputs
  String? _lastSsid;
  String? _lastBssid;
  String? _lastPassword;
  String? _lastSecurity = 'NONE';
  bool _lastJoinOnce = true;
  bool _lastWithInternet = false;

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

  // Each function below corresponds to a plugin method

  // Future<void> _scanWifiList() async {
  //   final result = await WifiAssistant.scanWifiList();
  //   print("result: $result");
  //   _showResult(result);
  // }

  Future<void> _loadWifiList() async {
    final List<wifi_network.WifiNetwork> result = await WifiAssistant.loadWifiList();
    final List<Map<String, String>> listMap = result
              .whereType<wifi_network.WifiNetwork>()
              .map((wifi) => {
                    "ssid": wifi.ssid?.trim() ?? "Unknown SSID",
                    "bssid": wifi.bssid?.trim() ?? "Unknown BSSID",
                    "capabilities": wifi.capabilities?.trim() ?? "Unknown Capabilities",
                    "frequency": wifi.frequency?.toString() ?? "Unknown Frequency",
                    "level": wifi.level?.toString() ?? "Unknown Level",
                  })
              .toList() ??
          [];
    print("result: $listMap");
    final resultText = listMap.map((network) => 
      "SSID: ${network['ssid']}, BSSID: ${network['bssid']}, Capabilities: ${network['capabilities']}, Frequency: ${network['frequency']}, Level: ${network['level']}"
    ).join('\n');
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
    
    
    
    // Parse boolean values
    final joinOnce = joinOnceStr?.toLowerCase() == 'true';
    final withInternet = withInternetStr?.toLowerCase() == 'true';

    // Persist last inputs
    _lastSsid = ssid;
    _lastBssid = bssid;
    _lastPassword = password;
    _lastSecurity = securityStr;
    _lastJoinOnce = joinOnce;
    _lastWithInternet = withInternet;
    
    try {
      //NetworkSecurity security = NetworkSecurity.NONE;
      
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

  Future<void> _connectToWifiSignal() async {
    final deviceId = await _prompt(context, 'Device ID');
    if (deviceId == null) return;
    final deviceMac = await _prompt(context, 'Device MAC');
    if (deviceMac == null) return;
    final networkListStr = await _prompt(context, 'Network List (as JSON List of Maps)');
    if (networkListStr == null) return;
    try {
      final List<Map<String, String>> networkList = List<Map<String, String>>.from(
        (networkListStr as dynamic)
      );
     // final result = await WifiAssistant.connectToWifiSignal(deviceId, deviceMac, networkList);
    //  _showResult(result);
    } catch (e) {
      _showResult('Invalid network list: $e');
    }
  }

  // Future<void> _connectToWifiAutomatically() async {
  //   // If your method requires parameters, prompt for them here
  //   final result = await WifiAssistant.connectToWifiAutomatically();
  //   _showResult(result);
  // }

 

  // Future<void> _authorizeRouter() async {
  //   final deviceId = await _prompt(context, 'Device ID');
  //   if (deviceId == null) return;
  //   final deviceMac = await _prompt(context, 'Device MAC');
  //   if (deviceMac == null) return;
  //   final result = await WifiAssistant.authorizeRouter(deviceId, deviceMac);
  //   _showResult(result);
  // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WiFi Assistant Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ElevatedButton(onPressed: _scanWifiList, child: const Text('Scan WiFi List')),
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
            const SizedBox(height: 24),
            const Text('Output:', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.grey[200],
              child: Text(_output, style: const TextStyle(fontFamily: 'monospace')),
            ),
          ],
        ),
      ),
    );
  }
}