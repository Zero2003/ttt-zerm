net.Receive("zerm_play", function ()
	local s2p = net.ReadString();
	surface.PlaySound(s2p);
end);
