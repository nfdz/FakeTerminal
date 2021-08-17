// NOTE: The preferred way is to install lcov and use command `lcov --summary path/to/lcov.info`
// Use this script only if you can't install lcov on your platform.

// Usage: dart coverage.dart path/to/lcov.info

import 'dart:io';

const minCoverage = 80;

void main(List<String> args) async {
  final lcovFilePath = args[0];
  final coverage = await _computeCoverage(File(lcovFilePath));
  final coverageString = coverage.toStringAsFixed(2);
  print('Total test coverage: $coverageString%');

  if (coverage < minCoverage) {
    print('Invalid coverage: $coverageString% < $minCoverage% (minimum)');
    exitCode = 1;
    throw InvalidCoverageException();
  } else {
    exitCode = 0;
  }
}

Future<double> _computeCoverage(File lcovFile) async {
  final lines = await lcovFile.readAsLines();
  final coverageData = lines.fold([0, 0], (List<int> data, line) {
    var testedLines = data[0];
    var totalLines = data[1];
    if (line.startsWith('DA')) {
      totalLines++;
      if (!line.endsWith('0')) {
        testedLines++;
      }
    }
    return [testedLines, totalLines];
  });

  final testedLines = coverageData[0].toDouble();
  final totalLines = coverageData[1].toDouble();
  return testedLines / totalLines * 100.0;
}

class InvalidCoverageException implements Exception {}
