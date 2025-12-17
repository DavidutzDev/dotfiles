local lang = require("utils.lang")
local lsp = require("utils.lsp")

lang.register("typescript", {
	mason = { "vtsls" },
	treesitter = { "typescript", "tsx", "javascript" },
	none_ls = { "biome" },
	lsp = {
		tsserver = { enabled = false },
		ts_ls = { enabled = false },
		vtsls = {
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.jsx",
				"svelte",
				"vue",
			},
			settings = {
				complete_function_calls = true,
				vtsls = {
					enableMoveToFileCodeAction = true,
					autoUseWorkspaceTsdk = true,
					experimental = {
						maxInlayHintLength = 30,
						completion = {
							enableServerSideFuzzyMatch = true,
						},
					},
					tsserver = {
						globalPlugins = {
							{
								name = "typescript-svelte-plugin",
								location = vim.fn.stdpath("data")
									.. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
								enableForWorkspaceTypeScriptVersions = true,
							},
						},
					},
				},
				typescript = {
					updateImportsOnFileMove = { enabled = "always" },
					suggest = {
						completeFunctionCalls = true,
					},
					inlayHints = {
						enumMemberValues = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						parameterNames = { enabled = "literals" },
						parameterTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						variableTypes = { enabled = false },
					},
				},
			},
		},
	},

	lsp_setup = {
		tsserver = function()
			return true
		end,
		ts_ls = function()
			return true
		end,

		vtsls = function(_, opts)
			if vim.lsp.config.denols and vim.lsp.config.vtsls then
				---@param server string
				local function resolve(server)
					local markers, root_dir = vim.lsp.config[server].root_markers, vim.lsp.config[server].root_dir
					vim.lsp.config(server, {
						root_dir = function(bufnr, on_dir)
							local is_deno = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) ~= nil
							if is_deno == (server == "denols") then
								if root_dir then
									return root_dir(bufnr, on_dir)
								elseif type(markers) == "table" then
									local root = vim.fs.root(bufnr, markers)
									return root and on_dir(root)
								end
							end
						end,
					})
				end
				resolve("denols")
				resolve("vtsls")
			end

			require("snacks.util.lsp").on({ name = "vtsls" }, function(_, client)
				client.commands["_typescript.moveToFileRefactoring"] = function(command)
					local action, uri, range = unpack(command.arguments)
					local function move(newf)
						client:request("workspace/executeCommand", {
							command = command.command,
							arguments = { action, uri, range, newf },
						})
					end
					local fname = vim.uri_to_fname(uri)
					client:request("workspace/executeCommand", {
						command = "typescript.tsserverRequest",
						arguments = {
							"getMoveToRefactoringFileSuggestions",
							{
								file = fname,
								startLine = range.start.line + 1,
								startOffset = range.start.character + 1,
								endLine = range["end"].line + 1,
								endOffset = range["end"].character + 1,
							},
						},
					}, function(_, result)
						local files = result.body.files
						table.insert(files, 1, "Enter new path...")
						vim.ui.select(files, {
							prompt = "Select move destination:",
							format_item = function(f)
								return vim.fn.fnamemodify(f, ":~:.")
							end,
						}, function(f)
							if f and f:find("^Enter new path") then
								vim.ui.input({
									prompt = "Enter move destination:",
									default = vim.fn.fnamemodify(fname, ":h") .. "/",
									completion = "file",
								}, function(newf)
									return newf and move(newf)
								end)
							elseif f then
								move(f)
							end
						end)
					end)
				end
			end)

			-- sync TS and JS settings
			opts.settings.javascript =
				vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
		end,
	},
	keymaps = {
		{
			"gD",
			function()
				local win = vim.api.nvim_get_current_win()
				local params = vim.lsp.util.make_position_params(win, "utf-16")
				lsp.send_lsp_request("workspace/executeCommand", {
					command = "typescript.goToSourceDefinition",
					arguments = { params.textDocument.uri, params.position },
				})
			end,
			desc = "Goto Source Definition",
		},
		{
			"gR",
			function()
				lsp.send_lsp_request("workspace/executeCommand", {
					command = "typescript.findAllFileReferences",
					arguments = { vim.uri_from_bufnr(0) },
				})
			end,
			desc = "File References",
		},
		{
			"<leader>co",
			function()
				lsp.send_lsp_request("textDocument/codeAction", {
					textDocument = vim.lsp.util.make_text_document_params(),
					range = vim.lsp.util.make_range_params(_, "utf-8").range,
					context = { only = { "source.organizeImports" } },
				})
			end,
			desc = "Organize Imports",
		},
		{
			"<leader>cM",
			function()
				lsp.send_lsp_request("textDocument/codeAction", {
					textDocument = vim.lsp.util.make_text_document_params(),
					range = vim.lsp.util.make_range_params(_, "utf-8").range,
					context = { only = { "source.addMissingImports.ts" } },
				})
			end,
			desc = "Add missing imports",
		},
		{
			"<leader>cu",
			function()
				lsp.send_lsp_request("textDocument/codeAction", {
					textDocument = vim.lsp.util.make_text_document_params(),
					range = vim.lsp.util.make_range_params().range,
					context = { only = { "source.removeUnused.ts" } },
				})
			end,
			desc = "Remove unused imports",
		},
		{
			"<leader>cD",
			function()
				lsp.send_lsp_request("textDocument/codeAction", {
					textDocument = vim.lsp.util.make_text_document_params(),
					range = vim.lsp.util.make_range_params().range,
					context = { only = { "source.fixAll.ts" } },
				})
			end,
			desc = "Fix all diagnostics",
		},
		{
			"<leader>cV",
			function()
				lsp.send_lsp_request("workspace/executeCommand", {
					command = "typescript.selectTypeScriptVersion",
				})
			end,
			desc = "Select TS workspace version",
		},
	},
})
