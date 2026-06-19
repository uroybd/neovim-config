#!/usr/bin/env nu


def generate_card [spec] {
  return $'<img src="($spec.value.src | str replace -r '^https:\/\/github\.com' 'https://githubcard.com').svg?d=JUwMjTqY" width="45%" alt="($spec.key)" />'
}

def generate_badges [plugin_count: int] {
  let package_manager = "![Package Manager](https://img.shields.io/badge/Package_Manager-zpack.nvim-blue?style=for-the-badge&logo=neovim)"
  let leader_key = "![Leader Key](https://img.shields.io/badge/Leader_Key-Space-blue?style=for-the-badge&logo=neovim)"
  let plugins = $"![Plugins]\(https://img.shields.io/badge/Plugins-($plugin_count)-blue?style=for-the-badge&logo=neovim\)"
  
  return $"($package_manager) ($leader_key) ($plugins)"
}

def generate_cards [data] {
  let cards = ($data | each {|kv| 
    let card = (generate_card $kv)
    $card
  } | str join "\n")
  
  return $'<p align="center">
($cards)
</p>'
}



def generate_readme [] {
  let data = (open ./nvim-pack-lock.json | get "plugins" | transpose key value)
  let plugin_count = ($data | length)
  let badges = (generate_badges $plugin_count)
  let cards = (generate_cards $data)
  
  let template = (open --raw ./README.template.md)
  let readme = ($template 
    | str replace "<BADGES>" $badges
    | str replace "<PLUGINS>" $cards)
  
  $readme | save -f ./README.md
}

generate_readme
