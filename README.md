## Config to JSON Jekyll Plugin

This is a Jekyll plugin which will generate a JSON file of select configuration variables, along with Pages and output it into /api/config/config.json (if it's a config variable) and (if it's a page) path/to/page.json of the destination folder

to add properties to be generated, simply edit your `_config.yml`

This Plugin was inspired by https://github.com/18F/jekyll_pages_api
  This plugin was made out of a custom-use-case (Jekyll and ReactJS) that I think does not belong in the jekyll_pages_api plugin,
  however, if 18F decides that this functionality would be welcome in their plugin, I would be more than happy to contribute (Though, i'm not the best at Ruby)

This plugin was originally made for integration with React.js, so information to be generated should go under 'react' in your YAML. Nevertheless, it can be used for whatever you want

EX:

```
react:
  title: My Awesome Website
  email: crazy_guy@mysterious_people.com
  baseurl: ""
  url: www.example.com
```


If you want to make a page dynamic, add 'render: dynamic' to your Frontmatter of the page.

WARNING: This will *not* render the page as Static HTML anymore. Instead, the page's content will be rendered to Liquid and dropped into a JSON file at the same path (IE If you're page is at http://www.example.com/path/to/page.html, the json file will be at http://www.example.com/path/to/page.json)


Example:

```
---
layout: default
title: About
permalink: about/
render: dynamic
---
```

then you can write your page in Markdown as you normally would (you can even use your own custom or standard Liquid Tags as you would with Jekyll) and the page will be rendered



---

### TODO:
 - [] allow the plugin to be accessed from About.json or about.json (not case sensitive)
 - [] Add posts instead of just doing Post/Pages
 - [] Sanitize input/add checks for existence (IE if File.exists?)
 - [] Add cool features


---
### Contribution:
If you would like to add features, or discover something wrong with this plugin, open an issue! I'll be right on it.
