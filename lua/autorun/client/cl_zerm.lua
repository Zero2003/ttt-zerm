net.Receive("zerm_play", function ()
	local s2p = tostring(net.ReadString());
	print("Sound Selected: " .. s2p);
	surface.PlaySound(Sound(s2p));
end);

net.Receive("zerm_transfer", function ()
	local str1 = net.ReadString();
	local tbl1 = net.ReadTable();
	local str2 = net.ReadString();
	local tbl2 = net.ReadTable();
	print(str1);
	PrintTable(tbl1, 1);
	print(str2);
	PrintTable(tbl2, 1);
	chat.AddText(Color(25, 230, 22), "Table data received! Check your console!");
end);

concommand.Add("printSounds", function (ply, cmd, args)
	net.Start("zerm_transfer");
	net.SendToServer();
end);