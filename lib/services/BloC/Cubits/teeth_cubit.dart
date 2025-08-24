import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/services/BloC/Cubits/States/teeth_state.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';

// Assuming these data models and ToothBorder are defined in separate files
// or included here for completeness.

// Data Models
class ToothChartData {
  final Size size;
  final Map<int, Tooth> teeth;
  final Map<int, ToothConnection> connections;

  const ToothChartData({
    required this.size,
    required this.teeth,
    required this.connections,
  });

  // Helper to get selected teeth
  Set<Tooth> get selectedTeeth =>
      teeth.values.where((tooth) => tooth.selected).toSet();

  // Helper to get selected connections
  Set<ToothConnection> get selectedConnections =>
      connections.values.where((connection) => connection.selected).toSet();
}

class Tooth {
  final int id;
  final Path path; // Made final and initialized in constructor
  final Rect rect; // Made final and initialized in constructor
  bool selected = false;
  String? treatment;
  String? material;

  Tooth(this.id, Path originalPath)
      : rect = originalPath
            .getBounds(), // Initialize rect directly from originalPath
        path = originalPath.shift(-originalPath
            .getBounds()
            .topLeft); // Shift path based on its own bounds

  Color get color {
    switch (treatment) {
      case 'تاج' || 'حشوة ضوئية': // Updated to Arabic
        return Colors.lime.shade200;
      case 'دمية' || 'تحضير تاج/فينير': // Updated to Arabic
        return Colors.lightBlue.shade200;
      case 'زرعة' || 'قلع': // Updated to Arabic
        return Colors.green.shade200;
      case 'فينير' || 'سحب عصب': // Updated to Arabic
        return Colors.pink.shade200;
      case 'حشوة' || 'زرع': // Updated to Arabic
        return Colors.purple.shade200;
      case 'بدلة': // Updated to Arabic
        return Colors.red.shade200;
      default:
        return const Color(0xFFF8F5ED); // Default unselected color
    }
  }
}

class ToothConnection {
  final int id;
  final int tooth1Id;
  final int tooth2Id;
  final Path path; // Made final and initialized in constructor
  final Rect rect; // Made final and initialized in constructor
  bool selected = false;

  ToothConnection(this.id, this.tooth1Id, this.tooth2Id, Path originalPath)
      : rect = originalPath
            .getBounds(), // Initialize rect directly from originalPath
        path = originalPath.shift(-originalPath
            .getBounds()
            .topLeft); // Shift path based on its own bounds
}

class ToothBorder extends ShapeBorder {
  const ToothBorder(this.path);

  final Path path;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // Ensure the path is shifted correctly relative to the provided rect
    return rect.topLeft == Offset.zero ? path : path.shift(rect.topLeft);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .9
      ..color = const Color(0xFFABA9A3); // Border color

    canvas.drawPath(getOuterPath(rect), paint);
  }

  @override
  ShapeBorder scale(double t) => this;
}

// Cubit
typedef Data = ({
  Size size,
  Map<int, Tooth> teeth,
  Map<int, ToothConnection> connections
});

class TeethCubit extends Cubit<TeethState> {
  TeethCubit() : super(TeethInitial());

  Data _data = (size: Size.zero, teeth: {}, connections: {});
  bool _isCopyModeActive = false;
  String? _copiedTreatment;
  String? _copiedMaterial;
  bool _showConnections = true; // New: State for connections visibility

  bool get isCopyModeActive => _isCopyModeActive;
  String? get copiedTreatment => _copiedTreatment;
  String? get copiedMaterial => _copiedMaterial;
  bool get showConnections =>
      _showConnections; // New: Getter for connections visibility

  Future<void> loadTeeth(String asset) async {
    emit(TeethLoading());
    try {
      _data = await _loadTeethData(asset);
      emit(TeethLoaded(_data));
    } catch (e) {
      emit(TeethError(e.toString()));
    }
  }

  Set<Tooth> getSelectedTeeth() {
    return _data.teeth.values.where((tooth) => tooth.selected).toSet();
  }

  Set<ToothConnection> getSelectedConnections() {
    return _data.connections.values
        .where((connection) => connection.selected)
        .toSet();
  }

  // Method to get formatted teeth data for API
  Map<String, List<String>> getFormattedTeethData() {
    Map<String, List<String>> formattedData = {
      'teeth_crown': [],
      'teeth_pontic': [],
      'teeth_implant': [],
      'teeth_veneer': [],
      'teeth_inlay': [],
      'teeth_denture': [],
      'bridges_crown': [],
      'bridges_pontic': [],
      'bridges_implant': [],
      'bridges_veneer': [],
      'bridges_inlay': [],
      'bridges_denture': [],
    };

    // Process selected teeth
    for (Tooth tooth in getSelectedTeeth()) {
      if (tooth.treatment != null && tooth.material != null) {
        String category = _getTeethCategory(tooth.treatment!);
        String formattedTooth = '${tooth.id},${tooth.material}';
        formattedData[category]!.add(formattedTooth);
      }
    }

    // Process selected connections (bridges)
    for (ToothConnection connection in getSelectedConnections()) {
      // For bridges, we need to get the connected teeth and their material
      Tooth? tooth1 = _data.teeth.values.firstWhere(
        (tooth) => tooth.id == connection.tooth1Id,
        orElse: () => Tooth(0, Path()),
      );
      Tooth? tooth2 = _data.teeth.values.firstWhere(
        (tooth) => tooth.id == connection.tooth2Id,
        orElse: () => Tooth(0, Path()),
      );

      if (tooth1.id != 0 &&
          tooth2.id != 0 &&
          tooth1.treatment != null &&
          tooth1.material != null &&
          tooth2.treatment != null &&
          tooth2.material != null) {
        String category = _getBridgesCategory(tooth1.treatment!);
        // For bridges, include both connected teeth
        String formattedBridge = '${tooth1.id},${tooth2.id},${tooth1.material}';
        formattedData[category]!.add(formattedBridge);
      }
    }

    return formattedData;
  }

  // Helper method to map treatment to teeth category
  String _getTeethCategory(String treatment) {
    switch (treatment) {
      case 'تاج':
        return 'teeth_crown';
      case 'دمية':
        return 'teeth_pontic';
      case 'زراعة':
        return 'teeth_implant';
      case 'فينير':
        return 'teeth_veneer';
      case 'حشوة':
        return 'teeth_inlay';
      case 'طقم':
        return 'teeth_denture';
      default:
        return 'teeth_crown'; // Default fallback
    }
  }

  // Helper method to map treatment to bridges category
  String _getBridgesCategory(String treatment) {
    switch (treatment) {
      case 'تاج':
        return 'bridges_crown';
      case 'دمية':
        return 'bridges_pontic';
      case 'زراعة':
        return 'bridges_implant';
      case 'فينير':
        return 'bridges_veneer';
      case 'حشوة':
        return 'bridges_inlay';
      case 'طقم':
        return 'bridges_denture';
      default:
        return 'bridges_crown'; // Default fallback
    }
  }

  bool canEstablishConnection(ToothConnection connection) {
    final tooth1 = _data.teeth.values
        .firstWhere((tooth) => tooth.id == connection.tooth1Id);
    final tooth2 = _data.teeth.values
        .firstWhere((tooth) => tooth.id == connection.tooth2Id);
    return tooth1.selected &&
        tooth2.selected &&
        tooth1.material == tooth2.material;
  }

  // --- Copy Mode Logic ---

  void toggleCopyMode(bool isActive) {
    _isCopyModeActive = isActive;
    // Emit state to rebuild UI and update chip appearance
    if (state is TeethLoaded) {
      emit(TeethLoaded(_data));
    }
  }

  void setCopiedInfo(String treatment, String material) {
    _copiedTreatment = treatment;
    _copiedMaterial = material;
    // No emit here, emit happens when copy mode is toggled or tooth is selected
  }

  void applyCopiedInfoToTooth(Tooth tooth) {
    if (_isCopyModeActive &&
        _copiedTreatment != null &&
        _copiedMaterial != null) {
      // Clear existing selection and info if any
      clearTooth(tooth);

      // Apply copied info
      tooth.treatment = _copiedTreatment;
      tooth.material = _copiedMaterial;
      tooth.selected = true; // Select the tooth after applying info

      // Keep copy mode active - REMOVED deactivation logic here

      // Emit state to update the UI
      emit(TeethLoaded(_data));
    }
  }

  // --- Existing Logic Modified ---

  void toggleToothSelection(Tooth tooth) {
    // This method is now only called in normal mode via the dialogs
    if (tooth.treatment != null) {
      tooth.selected = !tooth.selected;
      // Update copied info when a tooth is selected in normal mode
      if (tooth.selected) {
        setCopiedInfo(tooth.treatment!, tooth.material ?? '');
      } else {
        // If a tooth is deselected in normal mode, clear copied info
        _copiedTreatment = null;
        _copiedMaterial = null;
      }
      emit(TeethLoaded(_data));
    } else {
      // print('Select treatment and material before selecting the tooth.');
    }
  }

  void setToothTreatment(Tooth tooth, String treatment) {
    tooth.treatment = treatment;
    // Don't emit here, wait for material selection
  }

  void setToothMaterial(Tooth tooth, String material) {
    tooth.material = material;
    // Don't emit here, toggleToothSelection will emit after material is set
  }

  void toggleConnectionSelection(ToothConnection connection) {
    // Connections can only be selected in normal mode
    if (!_isCopyModeActive && canEstablishConnection(connection)) {
      connection.selected = !connection.selected;
      emit(TeethLoaded(_data));
    } else if (_isCopyModeActive) {
      // print('Cannot select connections in copy mode.');
    }
  }

  void clearTooth(Tooth tooth) {
    tooth.selected = false;
    tooth.treatment = null;
    tooth.material = null;
    // Also clear copied info if the cleared tooth was the source
    // Keep copy mode active even if the source is cleared - MODIFIED logic here
    if (_copiedTreatment == tooth.treatment &&
        _copiedMaterial == tooth.material) {
      _copiedTreatment = null;
      _copiedMaterial = null;
      // _isCopyModeActive = false; // REMOVED this line
    }

    for (final connection in _data.connections.values) {
      if (connection.tooth1Id == tooth.id || connection.tooth2Id == tooth.id) {
        connection.selected = false;
      }
    }
    emit(TeethLoaded(_data));
  }

  // --- New Method to Clear All Teeth ---
  void clearAllTeeth() {
    for (final tooth in _data.teeth.values) {
      tooth.selected = false;
      tooth.treatment = null;
      tooth.material = null;
    }
    for (final connection in _data.connections.values) {
      connection.selected = false;
    }
    _copiedTreatment = null;
    _copiedMaterial = null;
    _isCopyModeActive = false; // Deactivate copy mode when clearing all

    emit(TeethLoaded(_data)); // Emit state to update the UI
  }

  // New: Method to toggle connections visibility
  void toggleConnectionsVisibility(bool value) {
    _showConnections = value;
    if (state is TeethLoaded) {
      emit(TeethLoaded(_data)); // Emit state to update the UI
    }
  }

  // --- SVG Loading and ID Generation (Keep as is) ---

  Future<Data> _loadTeethData(String asset) async {
    final xml = await rootBundle.loadString(asset);
    final doc = XmlDocument.parse(xml);
    final viewBox = doc.rootElement.getAttribute('viewBox')!.split(' ');
    final w = double.parse(viewBox[2]);
    final h = double.parse(viewBox[3]);

    final teethElements = doc.rootElement.findAllElements('path');
    final connections = <int, ToothConnection>{};
    final loadedTeeth = <int, Tooth>{};

    for (final element in teethElements) {
      final id = int.parse(element.getAttribute('id')!);
      final pathData = element.getAttribute('d')!;
      final originalPath = parseSvgPathData(pathData);
      final bounds = originalPath.getBounds();

      // Check for invalid bounds manually
      if (bounds.width.isNaN ||
          bounds.height.isNaN ||
          bounds.width <= 0 ||
          bounds.height <= 0) {
        // Warning: SVG path for ID $id has invalid or empty bounds (width: ${bounds.width}, height: ${bounds.height}). Skipping this element.
        continue; // Skip to the next element
      }

      if (id >= 100) {
        connections[id] = ToothConnection(
          id,
          _generateConnectionIds(id).$1,
          _generateConnectionIds(id).$2,
          originalPath,
        );
      } else {
        loadedTeeth[id] = Tooth(
          _generateToothId(id),
          originalPath,
        );
      }
    }

    return (
      size: Size(w, h),
      teeth: loadedTeeth,
      connections: connections,
    );
  }

  int _generateToothId(int id) {
    int number = switch (id) {
      < 8 => 8 - id + 10,
      < 16 => id - 8 + 1 + 20,
      < 24 => 24 - id + 30,
      < 32 => id - 24 + 1 + 40,
      _ => id
    };
    return number;
  }

  (int, int) _generateConnectionIds(int id) {
    int id1 = switch (id) {
      < 107 => (18 - (id - 100)),
      == 107 => 11,
      <= 114 => (21 + (id - 108)),
      < 122 => (37 - (id - 115)),
      == 122 => 31,
      < 130 => (41 + (id - 123)),
      _ => id,
    };
    int id2 = switch (id) {
      < 107 => (17 - (id - 100)),
      == 107 => 21,
      <= 114 => (22 + (id - 108)),
      < 122 => (38 - (id - 115)),
      == 122 => 41,
      < 130 => (42 + (id - 123)),
      _ => id,
    };
    return (id1, id2);
  }
}
