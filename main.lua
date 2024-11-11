log.info("Successfully loaded " .. _ENV["!guid"] .. ".")
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto()

PATH = _ENV["!plugins_mod_folder_path"] .. "/"

local active = false

Initialize(function()
    local Typhoon = Difficulty.new("Onyx", "Typhoon")
    local director = nil
    local player = nil

    Typhoon:set_sprite(Resources.sprite_load("Onyx", "TyphoonIconSmall", PATH .. "typhoon_small.png", 1, 14, 10),
        Resources.sprite_load("Onyx", "TyphoonIcon", PATH .. "typhoon.png", 4, 30, 23))
    Typhoon:set_primary_color(Color(0x8d2362))
    Typhoon:set_sound(Resources.sfx_load("Onyx", "TyphoonSfx", PATH .. "typhoon.ogg"))

    Typhoon:set_scaling(0.3, 4.0, 3)
    Typhoon:set_monsoon_or_higher(true)
    Typhoon:set_allow_blight_spawns(true)

    Callback.add("onPlayerInit", "Typhoon-onPlayerInit", function()
        if Typhoon:is_active() then
            player = Player.get_client()
            local function InitTyphoon()
                director = Instance.find(gm.constants.oDirectorControl)
                director.elite_spawn_chance = 0.8
                director.loops = 1
                director.enemy_buff = director.enemy_buff + 1.5
            end
            Alarm.create(InitTyphoon, 60)
        end
    end)

    Typhoon:onActive(function()
        Actor:onPostStatRecalc("Typhoon-onPostStatRecalc", function(actor)
            if actor.team and actor.team == 2 then
                actor.attack_speed = actor.attack_speed * 1.15
                actor.cdr = 1 - ((1 - actor.cdr) * 0.85)
                actor.pHmax = actor.pHmax * 1.15
                actor.pHmax_raw = actor.pHmax_raw * 1.15
                actor.exp_worth = actor.exp_worth * 0.7
            end
        end)
    end)
end)
