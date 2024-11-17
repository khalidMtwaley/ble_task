import 'dart:async';
import 'dart:convert';
import 'package:ble_task/core/theme/colors_manager.dart';
import 'package:ble_task/core/theme/styles.dart';
import 'package:ble_task/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  late StreamSubscription<BluetoothConnectionState> connectionStateSubscription;
  BluetoothCharacteristic? dataCharacteristic;
  bool isConnected = false;
  bool isConnecting = false;

  @override
  void initState() {
    super.initState();
    listenToConnectionState();
    connectToDevice();
  }

  Future<void> connectToDevice() async {
    setState(() {
      isConnecting = true;
    });

    try {
      await widget.device.connect();
      await discoverServices();
      setState(() {
        isConnected = true;
        isConnecting = false;
      });
    } catch (e) {
      print("Error connecting to device: $e");
      setState(() {
        isConnecting = false;
      });
    }
  }

  Future<void> disconnectFromDevice() async {
    try {
      await widget.device.disconnect();
      setState(() {
        isConnected = false;
        isConnecting = false; 
      });
    } catch (e) {
      print("Error disconnecting: $e");
    }
  }

  void listenToConnectionState() {
    connectionStateSubscription = widget.device.connectionState.listen((state) {
      setState(() {
        isConnected = state == BluetoothConnectionState.connected;
        if (state == BluetoothConnectionState.disconnected) {
          isConnecting = false;
        }
      });
    });
  }

  Future<void> discoverServices() async {
    try {
      var services = await widget.device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.write &&
              characteristic.properties.read) {
            dataCharacteristic = characteristic;
          }
        }
      }
    } catch (e) {
      print("Error discovering services: $e");
    }
  }

  Future<void> sendData(BluetoothCharacteristic characteristic) async {
    try {
      var jsonData = jsonEncode({"command": "start", "value": 42});
      if (characteristic.properties.writeWithoutResponse) {
        await characteristic.write(jsonData.codeUnits, withoutResponse: true);
        print("Sent with WRITE_NO_RESPONSE: $jsonData");
      } else if (characteristic.properties.write) {
        await characteristic.write(jsonData.codeUnits, withoutResponse: false);
        print("Sent with WRITE: $jsonData");
      }
      showSentDataAlert(jsonData);
    } catch (e) {
      print("Error sending data: $e");
    }
  }

  Future<void> readData() async {
    if (dataCharacteristic == null) return;

    try {
      var data = await dataCharacteristic!.read();
      print("Received: ${String.fromCharCodes(data)}");
    } catch (e) {
      print("Error reading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottomOpacity: 0.0,
        title: Text(widget.device.platformName.isEmpty
            ? 'Unknown Device'
            : widget.device.platformName),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            20.verticalSpace,
            Container(
              decoration: BoxDecoration(
                color: isConnected
                    ? ColorsManager.green
                    : (isConnecting
                        ? ColorsManager.yellow2
                        : ColorsManager.errorColor),
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                isConnected
                    ? "Connected"
                    : (isConnecting ? "Connecting..." : "Disconnected"),
                style: Styles.textStyle500(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
           const Spacer(),
            Column(
              children: [
                CustomButton(
                    buttoncolor: ColorsManager.primary,
                    onPressed: () {
                      if (isConnected) {
                        sendData(dataCharacteristic!);
                      } else {
                        print("Device is not connected");
                      }
                    },
                    label: "Send Data"),
                25.verticalSpace,
                CustomButton(
                    buttoncolor: ColorsManager.primary,
                    onPressed: readData,
                    label: "Read Data"),
                25.verticalSpace,
                CustomButton(
                    buttoncolor: ColorsManager.primary,
                    onPressed: connectToDevice,
                    label: "Connect"),
                25.verticalSpace,
                CustomButton(
                    buttoncolor: ColorsManager.errorColor,
                    onPressed: disconnectFromDevice,
                    label: "Disconnect"),
                25.verticalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }
    void showSentDataAlert(String data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Data Sent"),
        content: Text(data),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
   @override
  void dispose() {
    connectionStateSubscription.cancel();
    widget.device.disconnect();
    super.dispose();
  }
}
