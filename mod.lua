function register()
   return {
    name = "definitely_a_bee",
    hooks = {"worldgen","click"},
    modules = {"define"}
   }
end

function init()
   api_set_devmode(true)

   api_create_log("California Bee", "init")
   
   define_boba()

   define_boba_drink()

   define_slippery_bee()

   define_bee_house()

   define_antislip_gloves()

   define_workbench()

   return "Success"
end

function worldgen(before_objects)
  if before_objects then
      
      for x=0,290 do
          for y=0, 290 do
              ground = api_get_ground(x*16, y*16)
              if string.sub(ground, 1, 5) == "water" then
                  if api_random(2000) < 1 then
                      api_create_obj("definitely_a_bee_house", x*16, y*16)

                  end
              end
          end
      end
  end
end

function click(button, click_type)
    if button == "LEFT" and click_type == "PRESSED" then
        equipped_item = api_get_equipped()
        if equipped_item == "definitely_a_bee_antislip_gloves" then
            
            highlighted_obj_id = api_get_highlighted("obj") -- get the id of the obj the mouse cursor is over
            
            if highlighted_obj_id ~= nil then -- if the mouse was over a obj
                
                highlighted_inst = api_get_inst(highlighted_obj_id) -- get the obj instance data (x, y, oid, id, ... )
                
                if highlighted_inst["oid"] == "definitely_a_bee_house" then -- check if we are pointing at a 'bee house'
                    
                    x = highlighted_inst["x"]
                    y = highlighted_inst["y"]
                    id = highlighted_inst["id"]
                    new_bee_stats = api_create_bee_stats("slippery_bee", false)
                    
                    api_create_item("bee", 2, x, y, new_bee_stats)
                    api_destroy_inst(id)

                end
            end
        end
    end
end