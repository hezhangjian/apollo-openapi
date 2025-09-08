#!/bin/bash
set -e

SPEC_FILE="apollo-openapi.yaml"
JAVA_DIR="java"
PYTHON_DIR="python"
RUST_DIR="rust"
TS_DIR="typescript"

echo "🧹 Cleaning old generated SDKs..."
rm -rf "$JAVA_DIR"
rm -rf "$PYTHON_DIR"
rm -rf "$RUST_DIR"
rm -rf "$TS_DIR"

echo "🚀 Generating Python SDK..."
openapi-generator generate \
  -i "$SPEC_FILE" \
  -g python \
  -o "$PYTHON_DIR" \
  --package-name apollo_openapi \
  --additional-properties=projectName=apollo-openapi,packageVersion=0.0.1

echo "🚀 Generating TypeScript SDK..."
openapi-generator generate \
  -i "$SPEC_FILE" \
  -g typescript-fetch \
  -o "$TS_DIR" \
  --additional-properties=npmName=apollo-openapi,npmVersion=0.0.1,typescriptThreePlus=true

echo "🚀 Generating Rust SDK..."
openapi-generator generate \
  -i "$SPEC_FILE" \
  -g rust \
  -o "$RUST_DIR" \
  --global-property models,supportingFiles \
  --additional-properties=packageName=apollo-openapi,packageVersion=0.0.1

echo "✅ SDK generation complete."
