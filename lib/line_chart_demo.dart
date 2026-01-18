// Copyright (c) 2026 Ravikant Authors. All rights reserved.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class LineChartDemo extends StatefulWidget {
  const LineChartDemo({super.key});

  @override
  State<LineChartDemo> createState() => _LineChartDemoState();
}

class _LineChartDemoState extends State<LineChartDemo> {
  late List<FlSpot> chartData;

  Color lineColor = const Color(0xFF64FFDA);
  Color lineGradientColorStart = const Color(0xFF64FFDA);
  Color lineGradientColorEnd = const Color(0xFF00D4FF);
  double lineWidth = 2.0;
  bool isCurved = true;
  double curveSmoothness = 0.35;
  bool isStrokeCapRound = true;
  bool isStrokeJoinRound = true;
  bool preventCurveOverShooting = false;
  List<int> dashArray = [];

  bool showAreaFill = true;
  Color areaFillColor = const Color(0xFF64FFDA);
  bool useAreaGradient = true;
  double areaOpacityStart = 0.3;
  double areaOpacityEnd = 0.01;

  bool showAboveArea = false;
  Color aboveAreaColor = const Color(0xFFFF6B6B);
  double aboveAreaOpacity = 0.2;

  bool showDots = false;
  double dotRadius = 4.0;
  Color dotColor = const Color(0xFF64FFDA);
  double dotStrokeWidth = 2.0;
  Color dotStrokeColor = Colors.white;

  bool showGrid = true;
  bool showVerticalGrid = false;
  double gridHorizontalInterval = 10.0;
  Color gridColor = Colors.grey;
  double gridOpacity = 0.3;
  double gridStrokeWidth = 0.5;
  bool gridDashed = false;

  bool showBorder = false;
  double borderWidth = 2.0;
  Color borderColor = const Color(0xFF64FFDA);

  bool showBackground = false;
  Color backgroundColor = const Color(0xFF1a365d);
  double backgroundOpacity = 0.1;

  bool showLeftTitles = true;
  bool showRightTitles = false;
  bool showTopTitles = false;
  bool showBottomTitles = true;
  double leftTitlesReservedSize = 32.0;
  double bottomTitlesReservedSize = 32.0;
  Color titleColor = Colors.grey;
  double titleFontSize = 10.0;

  bool enableTouch = true;
  bool showTooltip = true;
  double tooltipPaddingHorizontal = 12.0;
  double tooltipPaddingVertical = 8.0;
  double tooltipMargin = 12.0;
  Color tooltipBackgroundColor = const Color(0xFF1a365d);
  double tooltipBorderRadius = 8.0;
  bool tooltipFitHorizontally = true;
  bool tooltipFitVertically = true;
  bool tooltipShowOnTop = false;

  bool autoMinMax = true;
  double minXValue = 0;
  double maxXValue = 19;
  double minYValue = 0;
  double maxYValue = 100;

  int animationDurationMs = 200;

  final colors = [
    const Color(0xFF64FFDA), // Cyan
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();
    generateChartData();
  }

  void generateChartData() {
    final random = Random();
    final List<FlSpot> data = [];

    for (int i = 0; i < 20; i++) {
      data.add(FlSpot(i.toDouble(), 20 + random.nextDouble() * 60));
    }

    setState(() {
      chartData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chart'), centerTitle: true, elevation: 0),
      body: Column(
        children: [
          Container(
            height: 380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF112240),
              border: Border.all(color: const Color(0xFF1a365d), width: 1),
            ),
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Stock Price Chart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Expanded(child: _buildChart()),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text('Chart Controls', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),

                    _buildSectionHeader('Line Color & Style'),
                    _buildColorSelector(),
                    const SizedBox(height: 16),

                    _buildSectionHeader('Line Settings'),
                    _buildSliderTile(
                      label: 'Line Thickness',
                      value: lineWidth,
                      min: 0.5,
                      max: 5,
                      onChanged: (v) => setState(() => lineWidth = v),
                      unit: 'px',
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      label: 'Curved Line',
                      value: isCurved,
                      onChanged: (v) => setState(() => isCurved = v),
                      icon: Icons.show_chart,
                    ),
                    if (isCurved) ...[
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Curve Smoothness',
                        value: curveSmoothness,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (v) => setState(() => curveSmoothness = v),
                        unit: '',
                      ),
                      const SizedBox(height: 8),
                      _buildToggleRow(
                        label: 'Prevent Overshooting',
                        value: preventCurveOverShooting,
                        onChanged: (v) => setState(() => preventCurveOverShooting = v),
                        icon: Icons.security,
                      ),
                    ],
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      label: 'Round Stroke Cap',
                      value: isStrokeCapRound,
                      onChanged: (v) => setState(() => isStrokeCapRound = v),
                      icon: Icons.ac_unit_rounded,
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      label: 'Round Stroke Join',
                      value: isStrokeJoinRound,
                      onChanged: (v) => setState(() => isStrokeJoinRound = v),
                      icon: Icons.join_left,
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      label: 'Dashed Line',
                      value: dashArray.isNotEmpty,
                      onChanged: (v) {
                        setState(() {
                          dashArray = v ? [5, 5] : [];
                        });
                      },
                      icon: Icons.line_style,
                    ),
                    const SizedBox(height: 16),
                    _buildSectionHeader('Data Points'),
                    _buildToggleRow(
                      label: 'Show Data Points',
                      value: showDots,
                      onChanged: (v) => setState(() => showDots = v),
                      icon: Icons.circle,
                    ),
                    if (showDots) ...[
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Dot Radius',
                        value: dotRadius,
                        min: 2,
                        max: 10,
                        onChanged: (v) => setState(() => dotRadius = v),
                        unit: 'px',
                      ),
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Dot Stroke Width',
                        value: dotStrokeWidth,
                        min: 0,
                        max: 5,
                        onChanged: (v) => setState(() => dotStrokeWidth = v),
                        unit: 'px',
                      ),
                    ],
                    const SizedBox(height: 16),

                    _buildSectionHeader('Area Fill (Below)'),
                    _buildToggleRow(
                      label: 'Show Area Fill',
                      value: showAreaFill,
                      onChanged: (v) => setState(() => showAreaFill = v),
                      icon: Icons.bubble_chart_sharp,
                    ),
                    if (showAreaFill) ...[
                      const SizedBox(height: 8),
                      _buildToggleRow(
                        label: 'Use Gradient Fill',
                        value: useAreaGradient,
                        onChanged: (v) => setState(() => useAreaGradient = v),
                        icon: Icons.gradient,
                      ),
                      const SizedBox(height: 8),
                      if (!useAreaGradient)
                        _buildColorPickerRow(
                          label: 'Fill Color',
                          color: areaFillColor,
                          onColorChanged: (c) => setState(() => areaFillColor = c),
                        ),
                      if (useAreaGradient) ...[
                        const SizedBox(height: 8),
                        _buildSliderTile(
                          label: 'Gradient Start Opacity',
                          value: areaOpacityStart,
                          min: 0,
                          max: 1,
                          onChanged: (v) => setState(() => areaOpacityStart = v),
                          unit: '',
                        ),
                        const SizedBox(height: 8),
                        _buildSliderTile(
                          label: 'Gradient End Opacity',
                          value: areaOpacityEnd,
                          min: 0,
                          max: 1,
                          onChanged: (v) => setState(() => areaOpacityEnd = v),
                          unit: '',
                        ),
                      ],
                    ],
                    const SizedBox(height: 16),

                    _buildSectionHeader('Area Fill (Above)'),
                    _buildToggleRow(
                      label: 'Show Above Area',
                      value: showAboveArea,
                      onChanged: (v) => setState(() => showAboveArea = v),
                      icon: Icons.cloud_upload,
                    ),
                    if (showAboveArea) ...[
                      const SizedBox(height: 8),
                      _buildColorPickerRow(
                        label: 'Above Area Color',
                        color: aboveAreaColor,
                        onColorChanged: (c) => setState(() => aboveAreaColor = c),
                      ),
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Above Area Opacity',
                        value: aboveAreaOpacity,
                        min: 0,
                        max: 1,
                        onChanged: (v) => setState(() => aboveAreaOpacity = v),
                        unit: '',
                      ),
                    ],
                    const SizedBox(height: 16),

                    _buildSectionHeader('Grid Lines'),
                    _buildToggleRow(
                      label: 'Show Grid',
                      value: showGrid,
                      onChanged: (v) => setState(() => showGrid = v),
                      icon: Icons.grid_on,
                    ),
                    if (showGrid) ...[
                      const SizedBox(height: 8),
                      _buildToggleRow(
                        label: 'Show Vertical Grid',
                        value: showVerticalGrid,
                        onChanged: (v) => setState(() => showVerticalGrid = v),
                        icon: Icons.more_vert,
                      ),
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Grid Interval',
                        value: gridHorizontalInterval,
                        min: 5,
                        max: 50,
                        onChanged: (v) => setState(() => gridHorizontalInterval = v),
                        unit: '',
                      ),
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Grid Opacity',
                        value: gridOpacity,
                        min: 0,
                        max: 1,
                        onChanged: (v) => setState(() => gridOpacity = v),
                        unit: '',
                      ),
                      const SizedBox(height: 8),
                      _buildToggleRow(
                        label: 'Dashed Grid',
                        value: gridDashed,
                        onChanged: (v) => setState(() => gridDashed = v),
                        icon: Icons.line_style,
                      ),
                    ],
                    const SizedBox(height: 16),

                    _buildSectionHeader('Chart Border'),
                    _buildToggleRow(
                      label: 'Show Border',
                      value: showBorder,
                      onChanged: (v) => setState(() => showBorder = v),
                      icon: Icons.border_all,
                    ),
                    if (showBorder) ...[
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Border Width',
                        value: borderWidth,
                        min: 0.5,
                        max: 5,
                        onChanged: (v) => setState(() => borderWidth = v),
                        unit: 'px',
                      ),
                    ],
                    const SizedBox(height: 16),

                    _buildSectionHeader('Background'),
                    _buildToggleRow(
                      label: 'Show Background',
                      value: showBackground,
                      onChanged: (v) => setState(() => showBackground = v),
                      icon: Icons.wallpaper,
                    ),
                    if (showBackground) ...[
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Background Opacity',
                        value: backgroundOpacity,
                        min: 0,
                        max: 1,
                        onChanged: (v) => setState(() => backgroundOpacity = v),
                        unit: '',
                      ),
                    ],
                    const SizedBox(height: 16),

                    _buildSectionHeader('Axis Titles'),
                    _buildToggleRow(
                      label: 'Show Left Titles',
                      value: showLeftTitles,
                      onChanged: (v) => setState(() => showLeftTitles = v),
                      icon: Icons.text_rotation_none,
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      label: 'Show Bottom Titles',
                      value: showBottomTitles,
                      onChanged: (v) => setState(() => showBottomTitles = v),
                      icon: Icons.text_rotation_none,
                    ),
                    const SizedBox(height: 8),
                    _buildSliderTile(
                      label: 'Title Font Size',
                      value: titleFontSize,
                      min: 8,
                      max: 16,
                      onChanged: (v) => setState(() => titleFontSize = v),
                      unit: 'pt',
                    ),
                    const SizedBox(height: 16),

                    _buildSectionHeader('Touch & Interaction'),
                    _buildToggleRow(
                      label: 'Enable Touch',
                      value: enableTouch,
                      onChanged: (v) => setState(() => enableTouch = v),
                      icon: Icons.touch_app,
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      label: 'Show Tooltip',
                      value: showTooltip,
                      onChanged: (v) => setState(() => showTooltip = v),
                      icon: Icons.info_outline,
                    ),
                    if (showTooltip) ...[
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Tooltip Border Radius',
                        value: tooltipBorderRadius,
                        min: 0,
                        max: 20,
                        onChanged: (v) => setState(() => tooltipBorderRadius = v),
                        unit: 'px',
                      ),
                      const SizedBox(height: 8),
                      _buildToggleRow(
                        label: 'Fit Tooltip Horizontally',
                        value: tooltipFitHorizontally,
                        onChanged: (v) => setState(() => tooltipFitHorizontally = v),
                        icon: Icons.swipe_left,
                      ),
                      const SizedBox(height: 8),
                      _buildToggleRow(
                        label: 'Fit Tooltip Vertically',
                        value: tooltipFitVertically,
                        onChanged: (v) => setState(() => tooltipFitVertically = v),
                        icon: Icons.swipe_up,
                      ),
                      const SizedBox(height: 8),
                      _buildToggleRow(
                        label: 'Show Tooltip On Top',
                        value: tooltipShowOnTop,
                        onChanged: (v) => setState(() => tooltipShowOnTop = v),
                        icon: Icons.arrow_upward,
                      ),
                    ],
                    const SizedBox(height: 16),

                    _buildSectionHeader('Chart Range'),
                    _buildToggleRow(
                      label: 'Auto Min/Max',
                      value: autoMinMax,
                      onChanged: (v) => setState(() => autoMinMax = v),
                      icon: Icons.auto_awesome,
                    ),
                    if (!autoMinMax) ...[
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Min Y Value',
                        value: minYValue,
                        min: -100,
                        max: 100,
                        onChanged: (v) => setState(() => minYValue = v),
                        unit: '',
                      ),
                      const SizedBox(height: 8),
                      _buildSliderTile(
                        label: 'Max Y Value',
                        value: maxYValue,
                        min: 0,
                        max: 200,
                        onChanged: (v) => setState(() => maxYValue = v),
                        unit: '',
                      ),
                    ],
                    const SizedBox(height: 16),

                    _buildSectionHeader('Animation & General'),
                    _buildSliderTile(
                      label: 'Animation Duration',
                      value: animationDurationMs.toDouble(),
                      min: 0,
                      max: 1000,
                      onChanged: (v) => setState(() => animationDurationMs = v.toInt()),
                      unit: 'ms',
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: generateChartData,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Generate Data'),
                            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _resetToDefaults,
                            icon: const Icon(Icons.restore),
                            label: const Text('Reset All'),
                            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    if (chartData.isEmpty) {
      return const Center(child: Text('No data'));
    }

    final minY = autoMinMax ? chartData.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 5 : minYValue;
    final maxY = autoMinMax ? chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 5 : maxYValue;

    return LineChart(
      LineChartData(
        minX: minXValue,
        maxX: maxXValue,
        minY: minY,
        maxY: maxY,
        borderData: showBorder
            ? FlBorderData(
                show: true,
                border: Border.all(color: borderColor, width: borderWidth),
              )
            : FlBorderData(show: false),
        gridData: FlGridData(
          show: showGrid,
          drawVerticalLine: showVerticalGrid,
          horizontalInterval: gridHorizontalInterval,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: gridColor.withOpacity(gridOpacity), strokeWidth: gridStrokeWidth, dashArray: gridDashed ? [5, 5] : null);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: gridColor.withOpacity(gridOpacity), strokeWidth: gridStrokeWidth, dashArray: gridDashed ? [5, 5] : null);
          },
        ),
        backgroundColor: showBackground ? backgroundColor.withOpacity(backgroundOpacity) : null,
        lineBarsData: [
          LineChartBarData(
            spots: chartData,
            color: lineColor,
            gradient: null,
            barWidth: lineWidth,
            isCurved: isCurved,
            curveSmoothness: curveSmoothness,
            preventCurveOverShooting: preventCurveOverShooting,
            isStrokeCapRound: isStrokeCapRound,
            isStrokeJoinRound: isStrokeJoinRound,
            dashArray: dashArray.isEmpty ? null : dashArray,
            dotData: FlDotData(
              show: showDots,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(radius: dotRadius, color: dotColor, strokeWidth: dotStrokeWidth, strokeColor: dotStrokeColor);
              },
            ),
            belowBarData: BarAreaData(
              show: showAreaFill,
              color: !useAreaGradient ? areaFillColor.withOpacity(areaOpacityStart) : null,
              gradient: useAreaGradient
                  ? LinearGradient(
                      colors: [areaFillColor.withOpacity(areaOpacityStart), areaFillColor.withOpacity(areaOpacityEnd)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : null,
            ),
            aboveBarData: BarAreaData(show: showAboveArea, color: aboveAreaColor.withOpacity(aboveAreaOpacity)),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: enableTouch && showTooltip,
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => tooltipBackgroundColor,
            tooltipPadding: EdgeInsets.symmetric(horizontal: tooltipPaddingHorizontal, vertical: tooltipPaddingVertical),
            tooltipMargin: tooltipMargin,
            tooltipBorderRadius: BorderRadius.circular(tooltipBorderRadius),
            fitInsideHorizontally: tooltipFitHorizontally,
            fitInsideVertically: tooltipFitVertically,
            showOnTopOfTheChartBoxArea: tooltipShowOnTop,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(spot.y.toStringAsFixed(2), TextStyle(color: lineColor, fontWeight: FontWeight.w600, fontSize: 14));
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: showLeftTitles,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(0),
                  style: TextStyle(fontSize: titleFontSize, color: titleColor),
                );
              },
              reservedSize: leftTitlesReservedSize,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: showBottomTitles,
              getTitlesWidget: (value, meta) {
                return Text(
                  'D${value.toInt()}',
                  style: TextStyle(fontSize: titleFontSize, color: titleColor),
                );
              },
              reservedSize: bottomTitlesReservedSize,
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF64FFDA)),
      ),
    );
  }

  Widget _buildColorSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.map((color) {
        final isSelected = lineColor == color;
        return GestureDetector(
          onTap: () {
            setState(() {
              lineColor = color;
            });
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
              boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 12, spreadRadius: 2)] : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildColorPickerRow({required String label, required Color color, required Function(Color) onColorChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a365d),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2d5a7d), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow({required String label, required bool value, required Function(bool) onChanged, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a365d),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2d5a7d), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF64FFDA)),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Switch(value: value, onChanged: onChanged, activeThumbColor: const Color(0xFF64FFDA), inactiveThumbColor: Colors.grey[700]),
        ],
      ),
    );
  }

  Widget _buildSliderTile({
    required String label,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
    required String unit,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a365d),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2d5a7d), width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF64FFDA).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF64FFDA)),
                ),
                child: Text(
                  '${value.toStringAsFixed(2)}$unit',
                  style: const TextStyle(color: Color(0xFF64FFDA), fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: const Color(0xFF64FFDA),
            inactiveColor: Colors.grey[700],
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() {
    setState(() {
      lineColor = const Color(0xFF64FFDA);
      lineGradientColorStart = const Color(0xFF64FFDA);
      lineGradientColorEnd = const Color(0xFF00D4FF);
      lineWidth = 2.0;
      isCurved = true;
      curveSmoothness = 0.35;
      isStrokeCapRound = true;
      isStrokeJoinRound = true;
      preventCurveOverShooting = false;
      dashArray = [];

      showAreaFill = true;
      areaFillColor = const Color(0xFF64FFDA);
      useAreaGradient = true;
      areaOpacityStart = 0.3;
      areaOpacityEnd = 0.01;

      showAboveArea = false;
      aboveAreaColor = const Color(0xFFFF6B6B);
      aboveAreaOpacity = 0.2;

      showDots = false;
      dotRadius = 4.0;
      dotColor = const Color(0xFF64FFDA);
      dotStrokeWidth = 2.0;
      dotStrokeColor = Colors.white;

      showGrid = true;
      showVerticalGrid = false;
      gridHorizontalInterval = 10.0;
      gridColor = Colors.grey;
      gridOpacity = 0.3;
      gridStrokeWidth = 0.5;
      gridDashed = false;

      showBorder = false;
      borderWidth = 2.0;
      borderColor = const Color(0xFF64FFDA);

      showBackground = false;
      backgroundColor = const Color(0xFF1a365d);
      backgroundOpacity = 0.1;

      showLeftTitles = true;
      showRightTitles = false;
      showTopTitles = false;
      showBottomTitles = true;
      leftTitlesReservedSize = 32.0;
      bottomTitlesReservedSize = 32.0;
      titleColor = Colors.grey;
      titleFontSize = 10.0;

      enableTouch = true;
      showTooltip = true;
      tooltipPaddingHorizontal = 12.0;
      tooltipPaddingVertical = 8.0;
      tooltipMargin = 12.0;
      tooltipBackgroundColor = const Color(0xFF1a365d);
      tooltipBorderRadius = 8.0;
      tooltipFitHorizontally = true;
      tooltipFitVertically = true;
      tooltipShowOnTop = false;

      autoMinMax = true;
      minXValue = 0;
      maxXValue = 19;
      minYValue = 0;
      maxYValue = 100;

      animationDurationMs = 200;
    });
  }
}
