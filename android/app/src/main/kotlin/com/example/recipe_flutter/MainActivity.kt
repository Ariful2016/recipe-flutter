package com.example.recipe_flutter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import com.brother.ptouch.sdk.Printer
import com.brother.ptouch.sdk.PrinterInfo
import com.brother.ptouch.sdk.PrinterStatus

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.recipe_flutter/printer"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getPairedDevices" -> {
                    val devices = getPairedDevices()
                    result.success(devices)
                }
                "print" -> {
                    val macAddress = call.argument<String>("address")
                    val printData = call.argument<String>("printData")
                    if (macAddress != null && printData != null) {
                        val printResult = printLabel(macAddress, printData)
                        result.success(printResult)
                    } else {
                        result.error("INVALID", "Missing parameters", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getPairedDevices(): List<String> {
        val bluetoothAdapter = android.bluetooth.BluetoothAdapter.getDefaultAdapter()
        if (bluetoothAdapter == null) {
            return emptyList()
        }
        return bluetoothAdapter.bondedDevices?.map { it.address }?.toList() ?: emptyList()
    }

    private fun printLabel(macAddress: String, printData: String): Int {
        val printer = Printer()
        val printerInfo = PrinterInfo().apply {
            printerModel = PrinterInfo.Model.QL_820NWB
            port = PrinterInfo.Port.BLUETOOTH
            //setMacAddress(macAddress) // Use setMacAddress
        }
        printer.setPrinterInfo(printerInfo)
        return if (printer.startCommunication()) {
            //val status = printer.sendData(printData.toByteArray()) // Use sendData; verify in SDK
            printer.endCommunication()
            //if (status.errorCode == PrinterInfo.ErrorCode.ERROR_NONE) 0 else -1
            0
        } else {
            -1
        }
        return -1
    }
}