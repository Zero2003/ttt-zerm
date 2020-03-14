zerm_ts = {};
zerm_is = {};

local files, directory = file.Find("sound/tttmusic/traitors/*.mp3", "GAME");
for i = 1, #files do
	files[i] = "tttmusic/traitors/" .. files[i];
	table.insert(zerm_ts, files[i]);
	resource.AddFile(files[i]);
	util.PrecacheSound(files[i]);
end

local files, directory = file.Find("sound/tttmusic/innocent/*.mp3", "GAME");
for i = 1, #files do
	files[i] = "tttmusic/innocent/" .. files[i];
	table.insert(zerm_is, files[i]);
	resource.AddFile(files[i]);
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
