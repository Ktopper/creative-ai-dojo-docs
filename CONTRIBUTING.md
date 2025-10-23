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
- `id`: Use next sequential number (doc-6, doc-7, etc.)
- `fileSize`: In bytes (on macOS: `ls -l your-file.pdf` or right-click → Get Info)
- `uploadedDate`: Today's date (YYYY-MM-DD)
- `downloadCount`: Start at 0
- `tags`: 3-5 relevant keywords

### Step 5: Validate Your Changes

Run the validation script to make sure everything is correct:

```bash
node validate-docs.js
```

This will check:
- ✅ JSON syntax is valid
- ✅ All required fields are present
- ✅ File exists in the correct location
- ✅ Category is valid

### Step 6: Commit Your Changes

```bash
git add .
git commit -m "Add: [Your Document Title]"
git push origin main
```

### Step 7: Create Pull Request

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

## 💡 Examples

### Example 1: Adding a Character Template

```bash
# Copy your file
cp ~/Downloads/scifi-character-template.pdf templates/

# Check file size
ls -l templates/scifi-character-template.pdf
# -rw-r--r--  1 user  staff  1234567 Oct 22 10:30 scifi-character-template.pdf

# Add to docs.json (fileSize = 1234567)
{
  "id": "doc-6",
  "title": "Sci-Fi Character Template",
  "description": "Character creation template for sci-fi settings with tech skills, cybernetics, and spacefaring background options.",
  "category": "templates",
  "fileName": "scifi-character-template.pdf",
  "fileSize": 1234567,
  "uploadedBy": "Jane Doe",
  "uploadedDate": "2024-10-22",
  "downloadCount": 0,
  "tags": ["scifi", "character", "template", "rpg", "cyberpunk"],
  "previewText": "Physical Traits, Tech Skills, Cybernetic Augments, Background, Equipment"
}

# Validate
node validate-docs.js

# Commit and push
git add templates/scifi-character-template.pdf docs.json
git commit -m "Add: Sci-Fi Character Template"
git push origin main
```

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
