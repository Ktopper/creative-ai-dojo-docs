# Context Docs - Separate Repository Setup

Much simpler approach! Create a dedicated `context-docs` repository where users can contribute without touching the main site code.

## 📦 New Repository Structure

Create a new repo: `https://github.com/Ktopper/creative-ai-dojo-docs`

```
creative-ai-dojo-docs/
├── README.md                      # Main guide for users
├── CONTRIBUTING.md                # Contribution guidelines
├── LICENSE                        # License file
├── .gitattributes                 # Git LFS for large files (optional)
│
├── docs.json                      # Main metadata file
│
├── templates/                     # Category folders
│   ├── character-sheet-template.pdf
│   ├── product-spec-template.docx
│   └── user-persona-template.pdf
│
├── reference-materials/
│   ├── brand-voice-guide.pdf
│   └── technical-documentation.pdf
│
├── frameworks/
│   ├── world-building-framework.pdf
│   └── content-strategy-framework.docx
│
└── style-references/
    ├── cyberpunk-aesthetic.pdf
    └── photography-style-guide.pdf
```

## 🎯 Benefits of Separate Repo

✅ **Simpler Contributions** - Users only deal with docs, not site code
✅ **Cleaner PRs** - Doc changes don't mix with site changes
✅ **Easier Review** - You only review documents
✅ **No Build Process** - Just files and JSON
✅ **Better Git LFS** - Can use Git LFS for large files
✅ **Clear Purpose** - Repo is specifically for docs
✅ **Easier Permissions** - Can give write access to trusted contributors

## 🚀 Quick Setup Steps

### 1. Create New GitHub Repository

Go to GitHub and create:
- **Name**: `creative-ai-dojo-docs`
- **Description**: "Community-contributed context documentation for AI tools"
- **Public** repository
- Initialize with README

### 2. Set Up Repository Structure

Clone and set up:
```bash
git clone https://github.com/Ktopper/creative-ai-dojo-docs.git
cd creative-ai-dojo-docs

# Create category folders
mkdir templates reference-materials frameworks style-references

# Create empty docs.json
echo "[]" > docs.json

# Commit structure
git add .
git commit -m "Initial repository structure"
git push
```

### 3. Add Initial Documents

Move your existing docs from `src/data/contextDocs.json` to the new repo.

## 📋 docs.json Schema

Single file at root of repo:

```json
[
  {
    "id": "doc-1",
    "title": "Character Sheet Template",
    "description": "Comprehensive character creation template for writers and game designers.",
    "category": "templates",
    "fileName": "character-sheet-template.pdf",
    "fileSize": 2457600,
    "uploadedBy": "Creative Dojo Team",
    "uploadedDate": "2024-10-15",
    "downloadCount": 342,
    "tags": ["character", "template", "writing", "game-design"],
    "previewText": "Includes physical appearance, personality traits, backstory, skills, and character development."
  }
]
```

**Note**: `fileName` is just the filename. Full URL is auto-generated:
```
https://raw.githubusercontent.com/Ktopper/creative-ai-dojo-docs/main/{category}/{fileName}
```

## 📖 User Contribution Flow

### Super Simple 3-Step Process:

1. **Fork the `creative-ai-dojo-docs` repo**
2. **Add your document + update docs.json**
3. **Create PR**

That's it! No dealing with React, no build process, just files.

### Detailed Steps:

```bash
# 1. Fork and clone
git clone https://github.com/YOUR-USERNAME/creative-ai-dojo-docs.git
cd creative-ai-dojo-docs

# 2. Add your document
cp ~/my-awesome-template.pdf templates/

# 3. Update docs.json
# Add your entry to the array

# 4. Commit and push
git add .
git commit -m "Add: My Awesome Template"
git push

# 5. Create PR on GitHub
```

## 🔧 Update Your Site

### Update githubDocsService.js

```javascript
// Change these constants
const GITHUB_OWNER = 'Ktopper';
const GITHUB_REPO = 'creative-ai-dojo-docs'; // Changed!
const DOCS_FILE = 'docs.json'; // Now at root

/**
 * Fetch docs metadata from dedicated docs repository
 */
export async function fetchDocsFromGitHub() {
  try {
    const url = `https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/contents/${DOCS_FILE}`;

    const response = await fetch(url);
    if (!response.ok) throw new Error(`GitHub API error: ${response.status}`);

    const data = await response.json();
    const decodedContent = atob(data.content);
    const docs = JSON.parse(decodedContent);

    // Add full URLs
    const docsWithUrls = docs.map(doc => ({
      ...doc,
      fileUrl: `https://raw.githubusercontent.com/${GITHUB_OWNER}/${GITHUB_REPO}/main/${doc.category}/${doc.fileName}`,
      source: 'github'
    }));

    return { success: true, docs: docsWithUrls };
  } catch (error) {
    console.error('Error fetching docs:', error);
    return { success: false, docs: [] };
  }
}
```

### Update ContributeDocsSection.jsx

```jsx
// Update links
<a
  href="https://github.com/Ktopper/creative-ai-dojo-docs/blob/main/README.md"
  target="_blank"
  rel="noopener noreferrer"
  className="btn-primary inline-flex items-center justify-center gap-2"
>
  <FileText className="w-5 h-5" />
  Read Full Guidelines
  <ExternalLink className="w-4 h-4" />
</a>

<a
  href="https://github.com/Ktopper/creative-ai-dojo-docs/fork"
  target="_blank"
  rel="noopener noreferrer"
  className="btn-secondary inline-flex items-center justify-center gap-2"
>
  <GitPullRequest className="w-5 h-5" />
  Submit on GitHub
  <ExternalLink className="w-4 h-4" />
</a>
```

## 📝 README.md for New Repo

```markdown
# Creative AI Dojo - Context Documentation

Community-contributed documentation, templates, and style guides for AI-assisted creative work.

## 🎯 What Are Context Docs?

Files that help AI tools understand specific contexts, styles, or requirements:
- **Templates**: Character sheets, product specs, creative briefs
- **Reference Materials**: Brand guides, technical docs
- **Frameworks**: World-building systems, strategy frameworks
- **Style References**: Visual guides, aesthetic references

## 📥 Using These Docs

1. Browse the folders above
2. Click any file to view
3. Click "Download" or "Raw" to get the file
4. Use with your favorite AI tools!

**Or visit**: [Creative AI Dojo Resources](https://creativeaidojo.com/resources)

## 🤝 Contributing

Want to share your templates and guides?

### Quick Steps:
1. Fork this repository
2. Add your document to the appropriate category folder
3. Update `docs.json` with your document metadata
4. Create a Pull Request

### Detailed Guide:
See [CONTRIBUTING.md](./CONTRIBUTING.md) for complete instructions.

## 📂 Repository Structure

```
templates/              - Blank forms and templates
reference-materials/    - Guides and documentation
frameworks/             - Structured methodologies
style-references/       - Visual aesthetic guides
docs.json              - Metadata for all documents
```

## 📊 Current Stats

- **Documents**: [will update automatically]
- **Contributors**: [will update]
- **Categories**: 4

## 🏷️ Metadata Format

Each document has an entry in `docs.json`:

```json
{
  "id": "doc-X",
  "title": "Document Title",
  "description": "What it contains",
  "category": "templates",
  "fileName": "my-doc.pdf",
  "fileSize": 2457600,
  "uploadedBy": "Your Name",
  "uploadedDate": "2024-10-22",
  "tags": ["relevant", "tags"]
}
```

## ✅ Contribution Guidelines

**We Accept:**
- ✅ Original templates and frameworks
- ✅ Well-formatted documents
- ✅ Properly attributed work
- ✅ PDF, DOCX, TXT, or MD files

**We Don't Accept:**
- ❌ Copyrighted material
- ❌ Low-quality or incomplete work
- ❌ Promotional content
- ❌ Executable files

## 📄 License

[Choose a license - MIT recommended]

## 🔗 Links

- **Main Site**: https://creativeaidojo.com
- **Forum**: https://creativeaidojo.com/forum
- **Contact**: hello@creativeaidojo.com

---

**Built by the Creative AI Dojo community** 🥷✨
```

## 📝 CONTRIBUTING.md for New Repo

```markdown
# Contributing to Creative AI Dojo Docs

Thank you for contributing! This guide will help you add your documents.

## 📋 Before You Start

Make sure your document is:
- [ ] Well-formatted and professional
- [ ] Useful for AI-assisted creative work
- [ ] Properly attributed (if based on other work)
- [ ] In PDF, DOCX, TXT, or MD format
- [ ] Under 10 MB (use Git LFS if larger)

## 🚀 How to Contribute

### Step 1: Fork the Repository

Click the "Fork" button at the top of this page.

### Step 2: Clone Your Fork

```bash
git clone https://github.com/YOUR-USERNAME/creative-ai-dojo-docs.git
cd creative-ai-dojo-docs
```

### Step 3: Add Your Document

Choose the right category folder:
- `templates/` - Blank forms to fill out
- `reference-materials/` - Guides and documentation
- `frameworks/` - Structured methodologies
- `style-references/` - Visual aesthetic guides

Copy your file:
```bash
cp ~/my-document.pdf templates/
```

### Step 4: Update docs.json

Open `docs.json` and add an entry:

```json
{
  "id": "doc-[next-number]",
  "title": "Your Document Title",
  "description": "Clear description of what this contains and how to use it",
  "category": "templates",
  "fileName": "my-document.pdf",
  "fileSize": 2457600,
  "uploadedBy": "Your Name",
  "uploadedDate": "2024-10-22",
  "downloadCount": 0,
  "tags": ["relevant", "searchable", "keywords"],
  "previewText": "Brief preview of what's inside..."
}
```

**Tips:**
- `id`: Use next sequential number (doc-11, doc-12, etc.)
- `fileSize`: In bytes (right-click file → Get Info)
- `uploadedDate`: Today's date (YYYY-MM-DD)
- `downloadCount`: Start at 0
- `tags`: 3-5 relevant keywords

### Step 5: Commit Your Changes

```bash
git add .
git commit -m "Add: [Your Document Title]"
git push origin main
```

### Step 6: Create Pull Request

1. Go to your fork on GitHub
2. Click "Pull Request"
3. Title: `Add: [Your Document Title]`
4. Description: Explain why it's useful
5. Submit!

## 📝 Metadata Guidelines

### Required Fields
- `id`, `title`, `description`, `category`, `fileName`, `uploadedBy`, `uploadedDate`

### Categories
- `templates` - Forms users fill out
- `reference-materials` - Information guides
- `frameworks` - Step-by-step methodologies
- `style-references` - Visual/aesthetic guides

### Good Descriptions
✅ "Complete character sheet for D&D 5E including stats, skills, and backstory"
❌ "A character sheet"

### Good Tags
✅ `["dnd", "rpg", "character", "template", "fantasy"]`
❌ `["sheet", "thing", "document"]`

## 🔍 Review Process

1. **Automated Check**: Verifies JSON syntax and file exists
2. **Quality Review**: We check if it's useful and well-formatted
3. **Approval**: Merged if meets standards
4. **Live**: Appears on Creative AI Dojo website!

## ❓ Questions?

- **Issues**: Create a GitHub Issue
- **Discussion**: Post in Creative AI Dojo Forum
- **Email**: hello@creativeaidojo.com

## 🎉 Recognition

Contributors are credited:
- Name appears on document card
- Listed in repository contributors
- Mentioned in community highlights

Thank you for making Creative AI Dojo better!
```

## 🎯 Summary

### Old Way (Complex):
- Users fork main site repo
- Deal with React, build tools, complex structure
- PR touches both docs and code
- Harder to review

### New Way (Simple):
- Users fork dedicated docs repo
- Just files and JSON
- PR only touches documents
- Easy to review

### Your Site Integration:
1. Update `githubDocsService.js` to point to new repo
2. Update `ContributeDocsSection.jsx` links
3. Optionally enable live GitHub fetching
4. Otherwise, periodically sync docs.json to your site

## 📚 Complete Examples

### Example 1: Adding Your First Document

Let's add a "World Building Template" step by step:

```bash
# 1. Clone your fork
git clone https://github.com/YOUR-USERNAME/creative-ai-dojo-docs.git
cd creative-ai-dojo-docs

# 2. Add the document to appropriate folder
cp ~/Downloads/world-building-template.pdf frameworks/

# 3. Check the file size (macOS)
ls -l frameworks/world-building-template.pdf
# Output: -rw-r--r--  1 user  staff  1543210 Oct 22 10:30 world-building-template.pdf
# File size is 1543210 bytes
```

Now edit `docs.json` and add this entry:

```json
[
  {
    "id": "doc-1",
    "title": "World Building Framework",
    "description": "Comprehensive framework for creating fictional worlds including geography, culture, history, and magic systems. Perfect for fantasy and sci-fi writers.",
    "category": "frameworks",
    "fileName": "world-building-template.pdf",
    "fileSize": 1543210,
    "uploadedBy": "Alex Chen",
    "uploadedDate": "2024-10-22",
    "downloadCount": 0,
    "tags": ["worldbuilding", "fantasy", "scifi", "writing", "framework"],
    "previewText": "Includes: Geography & Climate, Political Systems, Cultural Details, Magic/Tech Systems, Historical Timeline, Species & Creatures, Language Development"
  }
]
```

```bash
# 4. Commit and push
git add frameworks/world-building-template.pdf docs.json
git commit -m "Add: World Building Framework template"
git push origin main

# 5. Go to GitHub and create Pull Request
```

### Example 2: Full docs.json with Multiple Documents

Here's what a populated `docs.json` looks like:

```json
[
  {
    "id": "doc-1",
    "title": "Character Sheet Template",
    "description": "Comprehensive character creation template for writers and game designers. Includes physical traits, personality, backstory, skills, and development arcs.",
    "category": "templates",
    "fileName": "character-sheet-template.pdf",
    "fileSize": 2457600,
    "uploadedBy": "Creative Dojo Team",
    "uploadedDate": "2024-10-15",
    "downloadCount": 342,
    "tags": ["character", "template", "writing", "game-design"],
    "previewText": "Physical Appearance, Personality Traits, Backstory, Skills & Abilities, Character Arc"
  },
  {
    "id": "doc-2",
    "title": "Product Specification Template",
    "description": "Professional product spec template for product managers and designers. Covers user stories, technical requirements, and success metrics.",
    "category": "templates",
    "fileName": "product-spec-template.docx",
    "fileSize": 1856000,
    "uploadedBy": "Sarah Mitchell",
    "uploadedDate": "2024-10-18",
    "downloadCount": 127,
    "tags": ["product", "specification", "template", "project-management"],
    "previewText": "Problem Statement, User Stories, Technical Requirements, Success Metrics, Timeline"
  },
  {
    "id": "doc-3",
    "title": "Brand Voice Guide",
    "description": "Complete brand voice and tone guide with examples. Defines personality, communication style, and dos/don'ts for consistent messaging.",
    "category": "reference-materials",
    "fileName": "brand-voice-guide.pdf",
    "fileSize": 3204800,
    "uploadedBy": "Marketing Team",
    "uploadedDate": "2024-10-20",
    "downloadCount": 89,
    "tags": ["brand", "voice", "tone", "marketing", "communication"],
    "previewText": "Brand Personality, Tone Guidelines, Voice Attributes, Example Phrases, Dos and Don'ts"
  },
  {
    "id": "doc-4",
    "title": "Cyberpunk Aesthetic Guide",
    "description": "Visual style reference for cyberpunk aesthetics. Includes color palettes, lighting styles, architectural elements, and mood references.",
    "category": "style-references",
    "fileName": "cyberpunk-aesthetic.pdf",
    "fileSize": 5632100,
    "uploadedBy": "Visual Arts Collective",
    "uploadedDate": "2024-10-21",
    "downloadCount": 201,
    "tags": ["cyberpunk", "aesthetic", "visual", "style", "reference"],
    "previewText": "Color Palettes (neon, dark), Lighting (dramatic shadows, neon glow), Architecture (brutalist, tech), Fashion, Mood & Atmosphere"
  },
  {
    "id": "doc-5",
    "title": "Content Strategy Framework",
    "description": "Step-by-step framework for developing content strategies. Covers audience analysis, content pillars, distribution channels, and measurement.",
    "category": "frameworks",
    "fileName": "content-strategy-framework.docx",
    "fileSize": 1923400,
    "uploadedBy": "Jordan Lee",
    "uploadedDate": "2024-10-22",
    "downloadCount": 56,
    "tags": ["content", "strategy", "marketing", "framework", "planning"],
    "previewText": "1. Audience Research, 2. Content Pillars, 3. Channel Strategy, 4. Editorial Calendar, 5. Metrics & KPIs"
  }
]
```

### Example 3: Testing the File URLs

Once docs are in the repo, files are accessible at:

```
https://raw.githubusercontent.com/Ktopper/creative-ai-dojo-docs/main/frameworks/world-building-template.pdf
https://raw.githubusercontent.com/Ktopper/creative-ai-dojo-docs/main/templates/character-sheet-template.pdf
```

You can test these URLs in your browser or with curl:

```bash
curl -I https://raw.githubusercontent.com/Ktopper/creative-ai-dojo-docs/main/frameworks/world-building-template.pdf
```

## 🧪 How to Test Locally

### Step 1: Set Up the Docs Repository Locally

```bash
# Create a test directory structure
mkdir -p creative-ai-dojo-docs/{templates,reference-materials,frameworks,style-references}
cd creative-ai-dojo-docs

# Create a test docs.json with sample data
cat > docs.json << 'EOF'
[
  {
    "id": "doc-1",
    "title": "Test Character Sheet",
    "description": "A test character sheet template",
    "category": "templates",
    "fileName": "test-character-sheet.pdf",
    "fileSize": 100000,
    "uploadedBy": "Test User",
    "uploadedDate": "2024-10-22",
    "downloadCount": 0,
    "tags": ["test", "character", "template"],
    "previewText": "This is a test document"
  }
]
EOF

# Create a dummy PDF for testing (or add a real one)
echo "Test PDF content" > templates/test-character-sheet.pdf

# Initialize git
git init
git add .
git commit -m "Initial test setup"
```

### Step 2: Test JSON Validation

Create a simple validation script to test your docs.json:

```javascript
// validate-docs.js
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

    docs.forEach((doc, index) => {
      console.log(`Validating doc ${index + 1}: ${doc.title}`);

      // Check required fields
      requiredFields.forEach(field => {
        if (!doc[field]) {
          console.error(`  ❌ Missing field: ${field}`);
        }
      });

      // Check category
      if (!validCategories.includes(doc.category)) {
        console.error(`  ❌ Invalid category: ${doc.category}`);
      }

      // Check if file exists
      const filePath = `${doc.category}/${doc.fileName}`;
      if (!fs.existsSync(filePath)) {
        console.error(`  ❌ File not found: ${filePath}`);
      } else {
        console.log(`  ✅ File exists: ${filePath}`);
      }

      console.log('');
    });

    console.log('✅ Validation complete!');
  } catch (error) {
    console.error('❌ Validation failed:', error.message);
    process.exit(1);
  }
}

validateDocs();
```

Run validation:
```bash
node validate-docs.js
```

### Step 3: Test Your Website Integration Locally

Update your site's environment to point to your local/test repo:

```javascript
// In your githubDocsService.js or .env file
const GITHUB_OWNER = 'YOUR-USERNAME';  // Your test fork
const GITHUB_REPO = 'creative-ai-dojo-docs';
const DOCS_FILE = 'docs.json';
```

Then start your dev server:

```bash
cd your-main-website
npm run dev
```

### Step 4: Test with Mock Data (Without GitHub)

Create a local test file to simulate GitHub responses:

```javascript
// test/mockGithubDocs.js
export const mockDocsData = [
  {
    "id": "doc-1",
    "title": "Test Character Sheet",
    "description": "A test character sheet template",
    "category": "templates",
    "fileName": "test-character-sheet.pdf",
    "fileSize": 100000,
    "uploadedBy": "Test User",
    "uploadedDate": "2024-10-22",
    "downloadCount": 0,
    "tags": ["test", "character", "template"],
    "previewText": "This is a test document"
  }
];

// Temporarily modify githubDocsService.js to use mock data
export async function fetchDocsFromGitHub() {
  // return mockDocsData for local testing
  const docsWithUrls = mockDocsData.map(doc => ({
    ...doc,
    fileUrl: `http://localhost:3000/test-files/${doc.category}/${doc.fileName}`,
    source: 'github'
  }));
  return { success: true, docs: docsWithUrls };
}
```

### Step 5: Test the Complete Flow

1. **Test JSON parsing**:
```bash
cd creative-ai-dojo-docs
node validate-docs.js
```

2. **Test file accessibility**:
```bash
# Check all files exist
find . -name "*.pdf" -o -name "*.docx"
```

3. **Test website integration**:
```bash
cd your-main-website
npm run dev
# Visit http://localhost:3000/resources
# Check that documents appear correctly
```

4. **Test GitHub API (once pushed)**:
```bash
# Test GitHub API response
curl https://api.github.com/repos/YOUR-USERNAME/creative-ai-dojo-docs/contents/docs.json

# Test raw file access
curl -I https://raw.githubusercontent.com/YOUR-USERNAME/creative-ai-dojo-docs/main/templates/test-character-sheet.pdf
```

### Step 6: Pre-Commit Checklist

Before pushing to GitHub, verify:

```bash
# ✅ JSON is valid
node validate-docs.js

# ✅ All referenced files exist
for file in templates/* reference-materials/* frameworks/* style-references/*; do
  echo "Checking: $file"
done

# ✅ No sensitive data in commits
git diff --cached

# ✅ File sizes are reasonable
find . -type f -size +10M

# ✅ Commit messages are clear
git log --oneline -5
```

## 🚀 Final Setup Steps

### 1. Create the GitHub Repository

```bash
# On GitHub.com:
# 1. Click "New Repository"
# 2. Name: creative-ai-dojo-docs
# 3. Description: "Community-contributed context documentation for AI tools"
# 4. Public
# 5. Initialize with README
# 6. Create repository

# Then locally:
git remote add origin https://github.com/Ktopper/creative-ai-dojo-docs.git
git push -u origin main
```

### 2. Migrate Existing Documents

```bash
# If you have existing docs in your main site:
# 1. Export from contextDocs.json to docs.json format
# 2. Copy actual files to appropriate folders
# 3. Update file paths in docs.json
# 4. Commit and push
```

### 3. Update Your Main Website

```bash
cd your-main-website

# Update githubDocsService.js
# Update ContributeDocsSection.jsx links
# Test locally
npm run dev

# Deploy
npm run build
# Deploy to your hosting platform
```

### 4. Enable GitHub Pages (Optional)

This creates a nice preview page:

```bash
# On GitHub.com:
# Settings → Pages → Source: main branch → Save
# Your docs will be viewable at:
# https://ktopper.github.io/creative-ai-dojo-docs/
```

### 5. Set Up Automation (Optional)

Create `.github/workflows/validate.yml`:

```yaml
name: Validate Docs

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate JSON
        run: |
          node -e "
          const fs = require('fs');
          const data = JSON.parse(fs.readFileSync('docs.json'));
          console.log('✅ Valid JSON with', data.length, 'documents');
          "
      - name: Check files exist
        run: |
          node -e "
          const fs = require('fs');
          const docs = JSON.parse(fs.readFileSync('docs.json'));
          docs.forEach(doc => {
            const path = \`\${doc.category}/\${doc.fileName}\`;
            if (!fs.existsSync(path)) throw new Error(\`Missing: \${path}\`);
          });
          console.log('✅ All files exist');
          "
```

## 🎉 You're Done!

Your docs repository is now:
- ✅ Set up and tested locally
- ✅ Pushed to GitHub
- ✅ Integrated with your website
- ✅ Ready for community contributions

### Next Steps:
1. **Announce** to your community
2. **Add** initial set of quality documents
3. **Monitor** PRs and provide feedback
4. **Celebrate** contributions!

Much cleaner! 🎉
