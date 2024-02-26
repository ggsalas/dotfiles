return {
  "David-Kunz/gen.nvim",

  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>i', ':Gen<CR>')
    vim.keymap.set({ 'n', 'v' }, '<leader>ii', ':Gen Code_Chat<CR>')
    vim.keymap.set({ 'n', 'v' }, '<leader>ij', ':Gen Code_File_Chat<CR>')
    vim.keymap.set({ 'n', 'v' }, '<leader>ig', ':Gen General_Chat<CR>')

    require('gen').setup({
      model = "mistral",      -- The default model to use. // codellama //
      display_mode = "split", -- The display mode. Can be "float" or "split".
      show_prompt = true,     -- Shows the Prompt submitted to Ollama.
      show_model = true,      -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = true,   -- Never closes the window automatically.
      debug = false           -- Prints errors and the command which is run.
    })

    require('gen').prompts = {
      General_Chat = { prompt = "$input" },

      General_Execute = { prompt = "$input", replace = true },

      Code_Chat = {
        prompt = "You are an expert programmer that writes simple, concise code and explanations. $input"
      },

      Code_File_Chat = {
        prompt =
        "You are an expert programmer that writes simple, concise code and explanations. Use the propper language for the $filetype file. $input"
      },

      Code_Refactor = {
        prompt =
        "You are an expert programmer that writes simple, concise code. Regarding the following code, $input, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      },

      Code_Review = {
        prompt = "Review the following code and make concise suggestions:\n```$filetype\n$text\n```",
      },

      Code_Enhance = {
        prompt =
        "Enhance the following code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      },

      Code_Fix = {
        prompt =
        "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```"
      },

      Code_Unit_test_case = {
        prompt =
        "You are an expert programmer that writes simple, concise code. Write unit test case for, $input, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = false,
        extract = "```$filetype\n(.-)```",
      },

      -- Txt inputs
      -------------
      Txt_Summarize = { prompt = "Summarize the following text:\n$text" },

      Txt_Ask = { prompt = "Regarding the following text, $input:\n$text" },

      Txt_Change = {
        prompt =
        "Change the following text, $input, just output the final text without additional quotes around it:\n$text",
        replace = true,
      },

      Txt_Enhance_Grammar_Spelling = {
        prompt =
        "Modify the following text to improve grammar and spelling, just output the final text without additional quotes around it:\n$text",
        replace = true,
      },

      Txt_Enhance_Wording = {
        prompt =
        "Modify the following text to use better wording and fix spelling errors if they exist, just output the final text without additional quotes around it:\n$text",
        replace = true,
      },

      Txt_Make_Concise = {
        prompt =
        "Modify the following text to make it as simple and concise as possible, just output the final text without additional quotes around it:\n$text",
        replace = true,
      },

      Elaborate_Text = {
        prompt = "Elaborate the following text:\n$text",
        replace = true
      },

      Txt_Make_List = {
        prompt = "Render the following text as a markdown list:\n$text",
        replace = true,
      },

      Txt_Make_Table = {
        prompt = "Render the following text as a markdown table:\n$text",
        replace = true,
      },
    }
  end
}
