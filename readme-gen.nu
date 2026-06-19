#!/usr/bin/env nu


def generate_card [spec] {
  return $'<a target="_blank" href="($spec.value.src)"><img src="($spec.value.src | str replace -r '^https:\/\/github\.com' 'https://githubcard.com')" alt="($spec.key)" /></a>'
}

def generate_cards [data] {
   $data | each {|kv| generate_card $kv } | str join "\n"
}

def generate_badges [plugin_count: int] {
  let package_manager = "![Package Manager](https://img.shields.io/badge/Package_Manager-zpack.nvim-blue?style=flat-square)"
  let leader_key = "![Leader Key](https://img.shields.io/badge/Leader_Key-Space-blue?style=flat-square)"
  let plugins = $"![Plugins]\(https://img.shields.io/badge/Plugins-($plugin_count)-blue?style=flat-square\)"
  
  return $"($package_manager) ($leader_key) ($plugins)"
}

def generate_cards_two_columns [data] {
  let cards = ($data | each {|kv| generate_card $kv })
  let total = ($cards | length)
  let mid = (($total + 1) / 2 | into int)
  
  let left_column = ($cards | first $mid | str join "\n")
  let right_column = ($cards | skip $mid | str join "\n")
  
  return $'<table>
<tr>
<td valign="top" width="50%">

($left_column)

</td>
<td valign="top" width="50%">

($right_column)

</td>
</tr>
</table>'
}



def generate_readme [] {
  let data = (open ./nvim-pack-lock.json | get "plugins" | transpose key value)
  let plugin_count = ($data | length)
  let badges = (generate_badges $plugin_count)
  let cards = (generate_cards_two_columns $data)
  
  let template = (open --raw ./README.template.md)
  let readme = ($template 
    | str replace "<BADGES>" $badges
    | str replace "<PLUGINS>" $cards)
  
  $readme | save -f ./README.md
}

generate_readme
