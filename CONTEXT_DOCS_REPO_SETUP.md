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

## 🚀 Next Steps

1. **Create the new repository** on GitHub
2. **Set up the structure** (folders, docs.json)
3. **Migrate existing docs** from contextDocs.json
4. **Update your site code** to point to new repo
5. **Write README and CONTRIBUTING** files
6. **Announce to community!**

Much cleaner! 🎉
