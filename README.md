## Config to JSON Jekyll Plugin

This is a Jekyll plugin which will generate a JSON file of select configuration variables and output it into /api/config/config.json of you're destination (build) folder.

to add properties to be generated, simply edit your `_config.yml`

This plugin was originally made for integration with React.js, so information to be generated should go under 'react' in your YAML

EX:

```
react:
  title: My Awesome Website
  email: crazy_guy@mysterious_people.com
  baseurl: ""
  url: www.example.com
```



