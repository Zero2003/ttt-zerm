zerm_ts = {};
zerm_is = {};

local files, directory = file.Find("sound/tttmusic/traitors/*.mp3", "GAME");
for i = 1, #files do
	files[i] = "tttmusic/traitors/" .. files[i];
	table.insert(zerm_ts, files[i]);
	resource.AddFile("sound/" .. files[i]);
	util.PrecacheSound(files[i]);
end

local files, directory = file.Find("sound/tttmusic/innocent/*.mp3", "GAME");
for i = 1, #files do
	files[i] = "tttmusic/innocent/" .. files[i];
	table.insert(zerm_is, files[i]);
	resource.AddFile("sound/" .. files[i]);
	util.PrecacheSound(files[i]);
end

util.AddNetworkString("zerm_play");
hook.Add("TTTEndRound", "SoundManager", function (winType)
	if (winType == WIN_INNOCENT) then
		local max = table.Count(zerm_is);
		local s2p = math.Round(math.Rand(1, max));
		net.Start("zerm_play");
			net.WriteString(zerm_is[s2p]);
		net.Broadcast();
	else
		local max = table.Count(zerm_ts);
		local s2p = math.Round(math.Rand(1, max));
		net.Start("zerm_play");
			net.WriteString(zerm_ts[s2p]);
		net.Broadcast();
	end
end);

local function check(ply)
	if (IsValid(ply) && ply:IsSuperAdmin()) then
		net.Start("zerm_transfer");
			net.WriteString("Traitors Sound Table:");
			net.WriteTable(zerm_ts);
			net.WriteString("Innocents Sound Table:");
			net.WriteTable(zerm_is);
		net.Send(ply);
		return;
	elseif (IsValid(ply) && !ply:IsSuperAdmin()) then
		ply:ChatPrint("[ERROR]: This command is superadmin / console only.");
		return;
	end
end
util.AddNetworkString("zerm_transfer");
net.Receive("zerm_transfer", function (_, ply)
	check(ply);
end);
concommand.Add("printSounds", function (ply, cmd, args)
	check(ply);
	PrintTable(zerm_ts, 4);
	PrintTable(zerm_is, 4);
end);