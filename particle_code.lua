local particle_enabled = false  -- Initial state for particle spawning

-- Specify the armor item you want to check for
local specific_armor_item = "3d_armor:specific_armor"  -- Change this to your specific armor item

local function is_wearing_specific_armor(player)
    local armor_inv = player:get_inventory():get_list("armor")
    return armor_inv[1] and armor_inv[1]:get_name() == specific_armor_item  -- Check if the specified armor is equipped
end

local function spawn_particles(player_pos)
    for i = 1, 10 do
        local ppos = {
            x = player_pos.x + math.random(-1, 1),  -- Randomize position around player
            y = player_pos.y + math.random(0, 2),  -- Slightly above the player
            z = player_pos.z + math.random(-1, 1)
        }

        minetest.add_particle(ppos, {
            velocity = {x = 0, y = 0, z = 0},  -- Stationary particles
            expirationtime = 50,  -- Lifespan of the particle
            size = 2,  -- Size of the particle
            texture = "particle_texture.png",  -- Texture for the particle
        })
    end
end

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local player_pos = player:get_pos()
        
        -- Check if the player is wearing the specific armor
        if is_wearing_specific_armor(player) then
            particle_enabled = true
            spawn_particles(player_pos)  -- Spawn particles if specific armor is worn
        else
            particle_enabled = false
        end
    end
end)
