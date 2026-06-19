#!/usr/bin/env nu


def generate_card [spec] {
  return $'<a target="_blank" href="($spec.value.src)"><img width="400" hspace="20" vspace="10" src="($spec.value.src | str replace -r '^https:\/\/github\.com' 'https://githubcard.com').svg?d=JUwMjTqY" alt="($spec.key)" /></a>'
}

def generate_badges [plugin_count: int] {
  let package_manager = "![Package Manager](https://img.shields.io/badge/Package_Manager-zpack.nvim-blue?style=for-the-badge&logo=neovim)"
  let leader_key = "![Leader Key](https://img.shields.io/badge/Leader_Key-Space-blue?style=for-the-badge&logo=neovim)"
  let plugins = $"![Plugins]\(https://img.shields.io/badge/Plugins-($plugin_count)-blue?style=for-the-badge&logo=neovim\)"
  
  return $"($package_manager) ($leader_key) ($plugins)"
}

def generate_cards [data] {
  return $'<p>($data | each {|kv| generate_card $kv} | str join "")</p>'
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
