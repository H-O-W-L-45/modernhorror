
-- Disable the class system because we don't use it anyway.
function SCHEMA:CanPlayerJoinClass(client, class, info)
	return false
end