#!/bin/sh -xe

flutter clean && find . -name "*.g.dart" -exec rm -rf {} \; && find . -name "*.mocks.dart" -exec rm -rf {} \;