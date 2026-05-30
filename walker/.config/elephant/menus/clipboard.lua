Name = "clipboard"
NamePretty = "Clipboard"
Icon = "edit-paste"
HideFromProviderlist = false
Cache = false
Action = "echo '%VALUE%' | cliphist decode | wl-copy"

function GetEntries()
	local entries = {}
	local handle = io.popen("cliphist list")
	if handle then
		for line in handle:lines() do
			table.insert(entries, {
				Text = line:gsub("^%d+%s+", ""),
				Subtext = "clipboard",
				Value = line,
				Icon = "edit-paste",
			})
		end
		handle:close()
	end
	return entries
end
