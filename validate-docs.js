const fs = require('fs');

function validateDocs() {
  try {
    // Read and parse JSON
    const data = fs.readFileSync('docs.json', 'utf8');
    const docs = JSON.parse(data);

    console.log('✅ JSON is valid');
    console.log(`📄 Found ${docs.length} documents\n`);

    // Validate each document
    const requiredFields = ['id', 'title', 'description', 'category', 'fileName', 'uploadedBy', 'uploadedDate'];
    const validCategories = ['templates', 'reference-materials', 'frameworks', 'style-references'];

    let hasErrors = false;

    docs.forEach((doc, index) => {
      console.log(`\n📋 Validating doc ${index + 1}: "${doc.title}"`);

      // Check required fields
      requiredFields.forEach(field => {
        if (!doc[field]) {
          console.error(`  ❌ Missing field: ${field}`);
          hasErrors = true;
        } else {
          console.log(`  ✅ ${field}: ${doc[field]}`);
        }
      });

      // Check category
      if (!validCategories.includes(doc.category)) {
        console.error(`  ❌ Invalid category: ${doc.category}`);
        hasErrors = true;
      }

      // Check if file exists
      const filePath = `${doc.category}/${doc.fileName}`;
      if (!fs.existsSync(filePath)) {
        console.error(`  ❌ File not found: ${filePath}`);
        hasErrors = true;
      } else {
        const stats = fs.statSync(filePath);
        console.log(`  ✅ File exists: ${filePath} (${stats.size} bytes)`);
      }

      // Check tags
      if (!doc.tags || !Array.isArray(doc.tags) || doc.tags.length === 0) {
        console.error(`  ⚠️  Warning: No tags found`);
      } else {
        console.log(`  ✅ Tags: ${doc.tags.join(', ')}`);
      }
    });

    console.log('\n' + '='.repeat(50));
    if (hasErrors) {
      console.log('❌ Validation completed with errors!');
      process.exit(1);
    } else {
      console.log('✅ Validation complete! All checks passed!');
      console.log(`\n📊 Summary:`);
      console.log(`   - Total documents: ${docs.length}`);
      console.log(`   - Categories: ${[...new Set(docs.map(d => d.category))].join(', ')}`);
      console.log(`   - All files present and accounted for!`);
    }
  } catch (error) {
    console.error('❌ Validation failed:', error.message);
    process.exit(1);
  }
}

validateDocs();
