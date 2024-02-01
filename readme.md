# JsonHero.nvim
This plugin is intended to open visually selected json text from nvim in a new browser window in Json Hero.

## Setup

## Experimenting
```json
{
    "hello": "world"
}
```
This small json blerb works great, I struggle with some larger json files, and I think this has everything to do with hitting the url limit in number of characters with the base_64 text.

## TODO:
- [ ] When the encoded base_64 string goes past the limit for a url, error out instead of trying to hit json hero
