#!/bin/bash

# Test script for creative-ai-dojo-docs repository
# This script runs all validation checks

echo "🧪 Running Creative AI Dojo Docs Test Suite"
echo "=============================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Test 1: Check if all folders exist
echo "📁 Test 1: Checking folder structure..."
if [ -d "templates" ] && [ -d "reference-materials" ] && [ -d "frameworks" ] && [ -d "style-references" ]; then
    echo -e "${GREEN}✅ All category folders exist${NC}"
    ((TESTS_PASSED++))
else
    echo -e "${RED}❌ Missing category folders${NC}"
    ((TESTS_FAILED++))
fi
echo ""

# Test 2: Check if docs.json exists
echo "📄 Test 2: Checking docs.json..."
if [ -f "docs.json" ]; then
    echo -e "${GREEN}✅ docs.json exists${NC}"
    ((TESTS_PASSED++))
else
    echo -e "${RED}❌ docs.json not found${NC}"
    ((TESTS_FAILED++))
fi
echo ""

# Test 3: Validate JSON syntax
echo "🔍 Test 3: Validating JSON syntax..."
if node -e "JSON.parse(require('fs').readFileSync('docs.json'))" 2>/dev/null; then
    echo -e "${GREEN}✅ JSON syntax is valid${NC}"
    ((TESTS_PASSED++))
else
    echo -e "${RED}❌ JSON syntax error${NC}"
    ((TESTS_FAILED++))
fi
echo ""

# Test 4: Run full validation script
echo "🔬 Test 4: Running full validation..."
if node validate-docs.js; then
    ((TESTS_PASSED++))
else
    echo -e "${RED}❌ Validation failed${NC}"
    ((TESTS_FAILED++))
fi
echo ""

# Test 5: Check for required files
echo "📋 Test 5: Checking for README and CONTRIBUTING..."
if [ -f "README.md" ] && [ -f "CONTRIBUTING.md" ]; then
    echo -e "${GREEN}✅ Documentation files exist${NC}"
    ((TESTS_PASSED++))
else
    echo -e "${RED}❌ Missing documentation files${NC}"
    ((TESTS_FAILED++))
fi
echo ""

# Test 6: Check file permissions
echo "🔒 Test 6: Checking file permissions..."
if [ -r "docs.json" ] && [ -w "docs.json" ]; then
    echo -e "${GREEN}✅ docs.json is readable and writable${NC}"
    ((TESTS_PASSED++))
else
    echo -e "${RED}❌ Permission issues with docs.json${NC}"
    ((TESTS_FAILED++))
fi
echo ""

# Test 7: Count files in each category
echo "📊 Test 7: Counting files in categories..."
TEMPLATE_COUNT=$(find templates -type f | wc -l)
REF_COUNT=$(find reference-materials -type f | wc -l)
FRAMEWORK_COUNT=$(find frameworks -type f | wc -l)
STYLE_COUNT=$(find style-references -type f | wc -l)

echo "   Templates: $TEMPLATE_COUNT files"
echo "   Reference Materials: $REF_COUNT files"
echo "   Frameworks: $FRAMEWORK_COUNT files"
echo "   Style References: $STYLE_COUNT files"

TOTAL_FILES=$((TEMPLATE_COUNT + REF_COUNT + FRAMEWORK_COUNT + STYLE_COUNT))
if [ $TOTAL_FILES -gt 0 ]; then
    echo -e "${GREEN}✅ Found $TOTAL_FILES total files${NC}"
    ((TESTS_PASSED++))
else
    echo -e "${YELLOW}⚠️  No files found${NC}"
fi
echo ""

# Test 8: Check git repository status
echo "🔧 Test 8: Checking git status..."
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Git repository initialized${NC}"
    ((TESTS_PASSED++))

    # Show current status
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${YELLOW}   ⚠️  You have uncommitted changes${NC}"
        git status --short
    else
        echo "   No uncommitted changes"
    fi
else
    echo -e "${YELLOW}⚠️  Not a git repository (run 'git init' if needed)${NC}"
fi
echo ""

# Summary
echo "=============================================="
echo "📈 Test Summary"
echo "=============================================="
echo -e "${GREEN}✅ Tests Passed: $TESTS_PASSED${NC}"
echo -e "${RED}❌ Tests Failed: $TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed! Your repository is ready.${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. git add ."
    echo "  2. git commit -m 'Initial setup with test documents'"
    echo "  3. git remote add origin YOUR_GITHUB_URL"
    echo "  4. git push -u origin main"
    exit 0
else
    echo -e "${RED}⚠️  Some tests failed. Please fix the issues above.${NC}"
    exit 1
fi
