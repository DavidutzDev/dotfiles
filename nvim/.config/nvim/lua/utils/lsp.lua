local M = {}

function M.send_lsp_request(method, params)
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.buf_request(bufnr, method, params, function(err, result, ctx, _)
		if err then
			vim.notify("LSP Error: " .. err.message, vim.log.levels.ERROR)
			return
		end
		if not result then
			vim.notify("No result from LSP request: " .. method, vim.log.levels.WARN)
			return
		end

		-- Handle common response types
		if method == "workspace/executeCommand" then
			vim.notify("Command executed: " .. params.command)
		elseif method == "textDocument/codeAction" then
			for _, action in ipairs(result) do
				if action.edit then
					vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
				end
				if action.command then
					M.send_lsp_request("workspace/executeCommand", action.command)
				end
			end
		end
	end)
end

return M
