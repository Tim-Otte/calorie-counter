import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'all.dart' show AddMealPage, AddProductPage;
import '../data/all.dart';
import '../extensions/all.dart';
import '../services/all.dart';
import '../components/all.dart';

class ScanBarcodePage extends StatefulWidget {
  const ScanBarcodePage({super.key});

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodePageState();
}

class _ScanBarcodePageState extends State<ScanBarcodePage>
    with WidgetsBindingObserver {
  StreamSubscription<Object?>? _subscription;

  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
    formats: [BarcodeFormat.all],
  );

  bool _hasCameraPermissions = false;
  bool _hasNeverCameraPermissions = false;
  bool _isLoading = false;

  Future _handleBarcode(BarcodeCapture capture) async {
    // If no barcodes are captured or the first barcode has no value, return early.
    if (capture.barcodes.isEmpty ||
        capture.barcodes.first.rawValue == null ||
        !mounted) {
      return;
    }

    setState(() => _isLoading = true);

    // Stop the scanner and provide haptic feedback.
    unawaited(_controller.stop());
    unawaited(HapticFeedback.mediumImpact());

    final localizations = AppLocalizations.of(context)!;
    final foodFactService =
        Provider.of<FoodFactService>(context, listen: false);
    final database = Provider.of<AppDatabase>(context, listen: false);
    final barcodeValue = capture.barcodes.first.rawValue!;

    // Try to get the product from the local database.
    var dbProduct = await database.getProduct(barcodeValue);
    ProductTemplate product;
    List<ServingSizeTemplate>? servingSizes;

    if (dbProduct == null) {
      // If the product is not in the local database, fetch it from the FoodFactService.
      final foodfacts = await foodFactService.getProduct(barcodeValue);
      final baseServingSizes =
          await database.select(database.servingSize).get();

      if (foodfacts.product != null) {
        // If the product is found in the FoodFactService, extract its data and serving sizes.
        product = foodFactService.getProductDataFromProduct(foodfacts.product!);
        servingSizes = foodFactService.getServingSizesFromProduct(
          foodfacts.product!,
          baseServingSizes,
          localizations.serving,
          localizations.container,
        );
      } else {
        // If the product is not found, create a new product template with the barcode value.
        product = ProductTemplate.fromValues(
          productCode: barcodeValue,
        );
      }

      // Navigate to the AddProductPage to add the new product.
      if (mounted && context.mounted) {
        dbProduct = await context.navigateTo(
          (_) => AddProductPage(
            product: product,
            servingSizes: servingSizes,
          ),
        );
      }
    }

    // If the product is found or added, navigate to the AddMealPage.
    if (dbProduct != null) {
      if (mounted && context.mounted) {
        context.navigateTo(
          (_) => AddMealPage(product: dbProduct),
          replace: true,
        );

        return;
      }
    }

    // Return to the previous page if something went wrong.
    if (mounted && context.mounted) {
      Navigator.pop(context);
    }

    setState(() => _isLoading = false);
  }

  void _startScanning() {
    _subscription = _controller.barcodes.listen(_handleBarcode);
    unawaited(_controller.start());
  }

  void _stopScanning() {
    unawaited(_subscription?.cancel());
    _subscription = null;
    unawaited(_controller.stop());
  }

  Future<void> _checkPermissions() async {
    var cameraPermissions = await Permission.camera.status;

    if (!mounted) return;
    setState(() {
      _hasCameraPermissions = cameraPermissions.isGranted;
      _hasNeverCameraPermissions = cameraPermissions.isPermanentlyDenied;
    });
  }

  Future<void> _requestPermissions() async {
    var permissions = await Permission.camera.request();

    if (!mounted) return;
    setState(() {
      _hasCameraPermissions = permissions.isGranted;
      _hasNeverCameraPermissions = permissions.isPermanentlyDenied;
    });

    await _controller.stop();
    await _controller.start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        if (!_hasCameraPermissions) {
          unawaited(_checkPermissions());
        }

        _startScanning();
      case AppLifecycleState.inactive:
        if (_controller.value.isInitialized) _stopScanning();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _startScanning();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    unawaited(_checkPermissions());

    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.scanBarcodePageTitle),
          forceMaterialTransparency: true,
          actions: [
            IconButton(
              onPressed: _hasCameraPermissions && _controller.value.isRunning
                  ? () => unawaited(_controller.toggleTorch())
                  : null,
              icon: Icon(_controller.torchEnabled
                  ? Symbols.flash_on
                  : Symbols.flash_off),
            ),
            IconButton(
              onPressed: _hasCameraPermissions && _controller.value.isRunning
                  ? () => unawaited(_controller.switchCamera())
                  : null,
              icon: const Icon(Symbols.cameraswitch),
            )
          ],
        ),
        body: _hasCameraPermissions
            ? (_isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : MobileScanner(
                    controller: _controller,
                    errorBuilder: (p0, p1, p2) => IconWithText.andButton(
                      context,
                      icon: Symbols.error,
                      text: localizations.errorWhileLoadingCamera,
                      buttonIcon: Symbols.loop,
                      buttonText: localizations.tryAgain,
                      onButtonPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScanBarcodePage(),
                          ),
                        );
                      },
                    ),
                  ))
            : ColumnWithRefreshIndicator(
                onRefresh: _requestPermissions,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconWithText.andButton(
                    context,
                    icon: Symbols.camera,
                    text: localizations.missingCameraPermissions,
                    buttonIcon: Symbols.settings_photo_camera,
                    buttonText: localizations.requestCameraPermissions,
                    onButtonPressed: () {
                      if (_hasNeverCameraPermissions) {
                        unawaited(openAppSettings());
                      } else {
                        unawaited(_requestPermissions());
                      }
                    },
                  ),
                ],
              ),
      ),
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) return;
        _stopScanning();
      },
    );
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await _controller.dispose();
  }
}
