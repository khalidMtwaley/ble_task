import 'dart:async';
import 'package:ble_task/core/theme/colors_manager.dart';
import 'package:ble_task/core/theme/styles.dart';
import 'package:ble_task/core/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'device_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late StreamSubscription<BluetoothAdapterState> adapterStateSubscription;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    checkBluetoothState();
    startScan();
  }

  void checkBluetoothState() {
    adapterStateSubscription = FlutterBluePlus.adapterState
        .listen((BluetoothAdapterState state) async {
      if (state == BluetoothAdapterState.off) {
        print("Bluetooth is OFF. Requesting user to enable Bluetooth...");
        await FlutterBluePlus.turnOn();
      } else if (state == BluetoothAdapterState.on) {
        print("Bluetooth is ON.");
        startScan();
      } else if (state == BluetoothAdapterState.unauthorized) {
        print("Bluetooth permissions not granted.");
      }
    });
  }

  void startScan() async {
    if (isScanning) return;

    setState(() {
      isScanning = true;
    });

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      print("Error during scanning: $e");
    }

    setState(() {
      isScanning = false;
    });
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
    setState(() {
      isScanning = false;
    });
  }

  @override
  void dispose() {
    adapterStateSubscription.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLE Scanner'),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        backgroundColor: ColorsManager.primary,
        onPressed: () {
          if (isScanning) {
            stopScan();
          } else {
            startScan();
          }
        },
        child: Icon(
          isScanning ? Icons.stop : Icons.search,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: FlutterBluePlus.scanResults,
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final devices = snapshot.data ?? [];
          if (devices.isEmpty && !isScanning) {
            return const Center(
                child: Text("No devices found. Turn on Bluetooth and scan!"));
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                16.verticalSpace,
                Expanded(
                  child: ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index].device;

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 0),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DeviceScreen(device: device),
                              ),
                            );
                          },
                          title: Text(device.platformName.isEmpty
                              ? 'Unknown Device'
                              : device.platformName),
                          subtitle: Text(
                            device.id.toString(),
                            style: Styles.textStyle400(
                                fontSize: 12, color: ColorsManager.grey),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ).withSafeArea();
  }
}
