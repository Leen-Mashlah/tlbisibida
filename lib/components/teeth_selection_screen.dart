// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/teeth_dialogs.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/BloC/Cubits/States/teeth_state.dart';
import 'package:lambda_dent_dash/services/BloC/Cubits/teeth_cubit.dart';

class TeethSelectionScreen extends StatelessWidget {
  final String asset;
  final bool isDocSheet;
  final bool showConnections; // Made final and passed through constructor

  const TeethSelectionScreen({
    super.key,
    required this.asset,
    required this.isDocSheet,
    this.showConnections = true, // Default value, can be overridden
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeethCubit()..loadTeeth(asset),
      child: BlocBuilder<TeethCubit, TeethState>(
        builder: (context, state) {
          final cubit = context.read<TeethCubit>();

          if (state is TeethInitial || state is TeethLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TeethError) {
            return Center(child: Text(state.message));
          }

          if (state is TeethLoaded) {
            final data = state.data;

            // Extract unique selected treatments for the legend
            final selectedTreatments = data.teeth.values
                .where((tooth) => tooth.selected && tooth.treatment != null)
                .map((tooth) => tooth.treatment!)
                .toSet();

            // Find a tooth for each selected treatment to get its color
            final treatmentColors = {
              for (var treatment in selectedTreatments)
                treatment: data.teeth.values
                    .firstWhere((tooth) => tooth.treatment == treatment)
                    .color
            };

            // Determine if the copy chip should be enabled
            final bool isCopyChipEnabled =
                cubit.copiedTreatment != null && cubit.copiedMaterial != null;

            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                // Use Column to stack the chip and the chart
                children: [
                  // Copy Choice Chip and Clear All Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the row content
                      mainAxisSize: MainAxisSize.min, // Wrap content tightly
                      children: [
                        // Copy Choice Chip
                        ChoiceChip(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          label: Icon(
                            Icons.copy_rounded,
                            color: cubit.isCopyModeActive ? cyan500 : cyan400,
                          ),
                          showCheckmark: false,
                          selected: cubit.isCopyModeActive,
                          disabledColor: cyan50, // Color when disabled
                          selectedColor: cyan200, // Color when active
                          backgroundColor: cyan100, // Color when inactive
                          shape: RoundedRectangleBorder(
                            // Add a border
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                              color: cubit.isCopyModeActive ? cyan500 : cyan200,
                              width: cubit.isCopyModeActive ? 1 : .5,
                            ),
                          ),
                          chipAnimationStyle: ChipAnimationStyle(
                              enableAnimation:
                                  AnimationStyle(curve: Curves.easeInOut)),
                          elevation:
                              cubit.isCopyModeActive ? 4.0 : 2.0, // Add shadow
                          shadowColor:
                              cubit.isCopyModeActive ? cyan500 : Colors.black45,
                          onSelected: isCopyChipEnabled ||
                                  cubit
                                      .isCopyModeActive // Allow deactivating even if disabled
                              ? (bool selected) {
                                  if (selected) {
                                    // Activating copy mode
                                    cubit.toggleCopyMode(true);
                                  } else {
                                    // Deactivating copy mode
                                    cubit.toggleCopyMode(false);
                                  }
                                }
                              : null, // Disable the chip if no info is copied and not active
                        ),
                        const SizedBox(width: 8), // Space between chips
                        // Clear All Button
                        ElevatedButton(
                          onPressed: () {
                            cubit.clearAllTeeth();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: redbackground, // Background color
                            foregroundColor: redmain, // Text/icon color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                color: redmid,
                                width: 1.0,
                              ),
                            ),
                            elevation: 2.0, // Shadow
                            shadowColor: Colors.black45,
                            padding: const EdgeInsets.symmetric(
                                vertical: 7), // Padding
                          ),
                          child: const Icon(Icons.clear_all_rounded),
                        ),
                        // Removed the Toggle Connections Visibility Row
                      ],
                    ),
                  ),

                  // The Tooth Chart within a Stack
                  FittedBox(
                    child: SizedBox.fromSize(
                      size: data.size,
                      child: Stack(
                        children: [
                          // teeth
                          for (final MapEntry(key: key, value: tooth)
                              in data.teeth.entries)
                            if (tooth.rect.width.isNaN ||
                                tooth.rect.height.isNaN ||
                                tooth.rect.width <= 0 ||
                                tooth.rect.height <= 0)
                              const SizedBox
                                  .shrink() // Skip rendering invalid tooth
                            else
                              Positioned.fromRect(
                                rect: tooth.rect,
                                child: Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: tooth.selected
                                            ? tooth.color
                                            : const Color(0xFFF8F5ED),
                                        shadows: tooth.selected
                                            ? [
                                                const BoxShadow(
                                                    blurRadius: 4,
                                                    offset: Offset(0, 6))
                                              ]
                                            : null,
                                        shape: ToothBorder(tooth.path),
                                      ),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          splashColor: tooth.selected
                                              ? Colors.white
                                              : Colors.teal.shade100,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            if (cubit.isCopyModeActive) {
                                              cubit.applyCopiedInfoToTooth(
                                                  tooth);
                                            } else {
                                              if (!tooth.selected) {
                                                isDocSheet
                                                    ? showAlertDialogDoc(
                                                        context, tooth, cubit)
                                                    : showAlertDialog(
                                                        context, tooth, cubit);
                                              } else {
                                                showClearDialog(
                                                    context, tooth, cubit);
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: IgnorePointer(
                                        child: Center(
                                          child: Text(
                                            '${tooth.id}',
                                            style: const TextStyle(
                                              color: cyan600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          // connections - conditionally rendered based on constructor value
                          if (showConnections) // Now uses the final value from the constructor
                            for (final MapEntry(key: key, value: connection)
                                in data.connections.entries)
                              if (connection.rect.width.isNaN ||
                                  connection.rect.height.isNaN ||
                                  connection.rect.width <= 0 ||
                                  connection.rect.height <= 0)
                                const SizedBox
                                    .shrink() // Skip rendering invalid connection
                              else
                                Positioned.fromRect(
                                  rect: connection.rect,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: connection.selected
                                          ? cyan200
                                          : const Color(
                                              0xFFE0E0DB), // Unselected connection color
                                      shadows: connection.selected
                                          ? [
                                              const BoxShadow(
                                                  blurRadius: 4,
                                                  offset: Offset(0, 6))
                                            ]
                                          : null,
                                      shape: ToothBorder(connection.path),
                                    ),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        splashColor: connection.selected
                                            ? const Color(0xFFE0C99E)
                                            : Colors.teal.shade100,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          if (!cubit.isCopyModeActive) {
                                            cubit.toggleConnectionSelection(
                                                connection);
                                          } else {
                                            print(
                                                'Cannot select connections in copy mode.');
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                          // Legend (positioned on top of the chart, centered within the Stack)
                          if (selectedTreatments.isNotEmpty)
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                // Center the legend content
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize:
                                      MainAxisSize.min, // Use minimum space
                                  children: [
                                    // Removed the "Legend:" title
                                    ...treatmentColors.entries.map(
                                      (entry) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize
                                              .min, // Use minimum space
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: cyan500,
                                                      width: .3),
                                                  color: entry.value,
                                                  shape: BoxShape.circle,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black45,
                                                        blurRadius: 5,
                                                        offset: Offset(-1, 2))
                                                  ]),
                                              width: 16, // Smaller color box
                                              height: 16,

                                              margin: const EdgeInsets.only(
                                                  left: 15),
                                            ),
                                            Text(entry.key,
                                                style: const TextStyle(
                                                    color: cyan600,
                                                    fontSize:
                                                        15)), // Smaller text
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
