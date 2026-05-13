# barnabykina.com

Jekyll site modeled after the structure and visual language of `esafev/thoughts`.

## Development

```bash
bundle install
bundle exec jekyll serve
```

Jekyll will build the site into `_site/` and serve it locally, usually at `http://127.0.0.1:4000`.

## Site Structure

- `index.html`: homepage content
- `_notes/`: individual notes
- `notes/index.html`: notes archive page
- `_includes/footer.html`: footer markup and social links
- `_config.yml`: global site settings like title, email, URL, and timezone
- `assets/css/global.css`: site-wide styling

## Updating The Homepage

The homepage lives in `index.html`.

It has two main sections:

1. The intro at the top:

```html
<section class="intro">
  <p>...</p>
  <p>...</p>
</section>
```

Edit those paragraphs to change the short bio or introductory text.

2. The recent notes list below it:

```liquid
{% assign notes = site.notes | sort: "date" | reverse %}
```

This section is generated automatically from the files in `_notes/`. You usually do not need to edit the loop itself. If you add a new note with a newer date, it will appear on the homepage automatically.

The homepage title and description are set in the front matter at the top of `index.html`:

```yaml
---
title: Barnaby Kina Gichana
description: Notes, projects, and working thoughts.
---
```

## Adding A Note

Each note is a Markdown file inside `_notes/`.

To add a new note:

1. Create a new file in `_notes/`, for example `_notes/my-new-note.md`
2. Add front matter at the top
3. Write the note body in Markdown below it

Use this template:

```md
---
title: My New Note
description: A short summary of the note.
date: 2026-05-13
---

Write the note here.
```

What each field does:

- `title`: shown on the homepage, notes archive, browser title, and note page
- `description`: used for metadata and the RSS feed
- `date`: controls publish order

Once the file exists, Jekyll will:

- build it at `/notes/my-new-note/`
- include it on the homepage recent notes list
- include it on the notes archive page at `/notes/`
- include it in `rss.xml`

## Updating The Footer

The footer lives in `_includes/footer.html`.

This block controls the visible social links:

```html
<span>
  [↗]:
  <a target="_blank" rel="noreferrer" href="mailto:{{ site.email }}">Email</a>,
  <a target="_blank" rel="noreferrer" href="https://github.com/barnaby">GitHub</a>,
  <a target="_blank" rel="noreferrer" href="{{ '/rss.xml' | absolute_url }}">RSS</a>
</span>
```

To update the email link, change the `email` value in `_config.yml`:

```yaml
email: barnabykina@gmail.com
```

To update or replace other social links, edit the URLs directly in `_includes/footer.html`.

For example, to add LinkedIn:

```html
<a target="_blank" rel="noreferrer" href="https://linkedin.com/in/your-name">LinkedIn</a>
```

Keep the existing `target="_blank"` and `rel="noreferrer"` attributes for external links.

The "Last updated" line in the footer also lives in `_includes/footer.html`:

```html
<span class="footer-updated">Last updated: {{ site.time | date: "%B %-d, %Y" }}</span>
```

It is generated automatically from the current build time, so it updates each time the site is rebuilt.

## Adding Or Removing Sections

In this site, a "section" means a top-level content area with its own URL and, optionally, its own collection of items.

The existing `notes` section has three parts:

- a collection definition in `_config.yml`
- a content folder named `_notes/`
- an archive page at `notes/index.html`

### When To Use A Section

Create a new section if you want a new content type with its own archive and repeated entries.

Examples:

- `notes`: short written pieces
- `projects`: project writeups
- `reading`: books or articles

If you only need one standalone page, such as `/about/` or `/uses/`, you usually do not need a collection. A single page file is enough.

### How To Add A New Section

Suppose you want to add a `projects` section.

1. Add the collection to `_config.yml`:

```yaml
collections:
  notes:
    output: true
    permalink: /notes/:slug/
  projects:
    output: true
    permalink: /projects/:slug/
```

2. Add defaults if the new section should use a specific layout:

```yaml
defaults:
  - scope:
      path: ""
      type: projects
    values:
      layout: note
      header_title: ↩ Index
```

3. Create the collection folder:

```text
_projects/
```

4. Add entries inside that folder:

```md
---
title: Example Project
description: A short summary.
date: 2026-05-13
---

Project details go here.
```

5. Create an archive page for the section at `projects/index.html`:

```html
---
title: Projects
description: Archive of projects.
---
<section class="notes-list">
  <h2>All projects:</h2>
  {% assign projects = site.projects | sort: "date" | reverse %}
  {% for project in projects %}
    <section class="note-preview">
      <h3>
        <a href="{{ project.url | relative_url }}">{{ project.title }}</a>
      </h3>
      <span>{{ project.date | date: "%b %-d, %Y" }}</span>
    </section>
  {% endfor %}
</section>
```

6. If you want the new section to appear on the homepage, add a new block to `index.html` or replace the existing `notes` loop with a loop for the new section.

### How To Remove A Section

To remove a section such as `notes`:

1. Delete or rename its content folder, such as `_notes/`
2. Delete its archive page, such as `notes/index.html`
3. Remove its collection entry from `_config.yml`
4. Remove any section-specific defaults from `_config.yml`
5. Remove any homepage loops or links that reference it
6. Remove any references from `rss.xml` if the feed should no longer list that section

If you skip one of these steps, Jekyll may still build partial URLs or the homepage may still try to render content that no longer exists.

### Section Design Rule

For long-term maintenance, keep each section self-contained:

- one collection entry in `_config.yml`
- one underscored content folder such as `_notes/`
- one archive page such as `notes/index.html`
- one optional homepage block

That structure makes sections easy to add, change, or remove later without untangling the rest of the site.
