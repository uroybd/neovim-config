local M = {
"harrisoncramer/gitlab.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
    "nvim-tree/nvim-web-devicons" -- Recommended but not required. Icons in discussion tree.
  },
}

function M.build()
  require("gitlab.server").build(true)
end

function M.config()
  local gitlab = require("gitlab")
  gitlab.setup()
  local gitlab_server = require("gitlab.server")
  local wk = require("which-key")
  wk.register({
    ["<leader>gl"] = {
      name = "GitLab",
      b = { gitlab.choose_merge_request, "Choose Merge Request" },
      r = { gitlab.review, "Review" },
      s = {gitlab.summary, "Summary" },
      A = {gitlab.approve, "Approve" },
      R = {gitlab.revoke, "Revoke" },
      c = {gitlab.create_comment, "Create Comment" },
      O = {gitlab.create_mr, "Create Merge Request" },
      m = {gitlab.move_to_discussion_tree_from_diagnostic, "Move to Discussion Tree" },
      n = {gitlab.create_note, "Create Note" },
      d = {gitlab.toggle_discussions, "Toggle Discussions" },
      a = {
        name = "Assignee",
        a = {gitlab.add_assignee, "Add Assignee" },
        d = {gitlab.delete_assignee, "Delete Assignee" },
      },
      l = {
        name = "Label",
        a = {gitlab.add_label, "Add Label" },
        d = {gitlab.delete_label, "Delete Label" },
      },
      r = {
        name = "Reviewer",
        a = {gitlab.add_reviewer, "Add Reviewer" },
        d = {gitlab.delete_reviewer, "Delete Reviewer" },
      },
      p = {gitlab.pipeline, "Pipeline" },
      o = {gitlab.open_in_browser, "Open in Browser" },
      M = {gitlab.merge, "Merge" },
      u = {gitlab.copy_mr_url, "Copy Merge Request URL" },
      P = {gitlab.publish_all_drafts, "Publish All Drafts" },
      D = {gitlab.toggle_draft_mode, "Toggle Draft Mode" }
    },
  })

  wk.register({
    ["<leader>glc"] = { gitlab.create_multiline_comment, "Create Multiline Comment" },
    ["<leader>glC"] = { gitlab.create_comment_suggestion, "Create Comment Suggestion" },
  }, {
    mode = "v",
  })
end

return M
