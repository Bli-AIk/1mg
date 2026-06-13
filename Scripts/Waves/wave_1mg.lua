-- MARENOL 1mg by LeaF

local Arena = battle.mainarena
local Player = battle.Player

local mus, ins = audio.PlayMusic("1mg/marenol_1mg.mp3", 0.5, true)
local Beat = require("Scripts.Libraries.Beat")

function setupBasicBeatTracking()
    Beat.SetBPM(140)

    Beat.RegisterEvent("beat", function(current_beat)
        local beat_sound = current_beat % 4 == 1 and "metronome_high.wav" or "metronome_low.wav"
        audio.PlaySound("Beats/" .. beat_sound, 1.0, false)
        print(string.format("第 %d 拍触发！", current_beat))
    end)

    Beat.RegisterEvent("reset", function(beat)
        print(string.format("节拍重置至：%.2f", beat))
    end)
end

local wave = {
    ENDED = false,
    objects = {}
}

local function EndWave()
    wave.ENDED = true
    arenas.clear()
    for i = #wave.objects, 1, -1 do
        local obj = wave.objects[i]
        obj:Destroy()
        table.remove(wave.objects, i)
    end
end

Arena:Resize(155, 130)
Arena.width = 155
Arena.height = 130

Player.sprite:MoveTo(320, 320)

local mask = masks.New("rectangle", 320, 320, 155, 130, 0, 1)

setupBasicBeatTracking()

function wave.update(dt)
    mask:Follow(Arena.black)

    for i = #wave.objects, 1, -1 do
        local obj = wave.objects[i]
        if (obj.logic) then
            obj:logic(dt)
        end
    end

    Beat.Update(dt)
end

function wave.draw()
end

return wave
