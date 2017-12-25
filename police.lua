--[		     Ext. by: ThaNightHawk		  	]
--[      Discord: ThaNightHawk#7290	    ]
--[ Ext. for: ByHyperion/HyperionNetwork]
--[			     Date: 24/12/2017  				  ]

--Insert this just above "--police records" and under "local cfg = module("cfg/police")

MySQL.createCommand("vRP/set_license","UPDATE vrp_users SET DmvTest = @dmvtest WHERE id = @user_id")

--Insert this as a function after police records.

-- Driverslicense Function
function vRP.setLicense(user_id,dmvtest)
  MySQL.execute("vRP/set_license", {user_id = user_id, dmvtest = dmvtest})
end

function vRP.license(source)
  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    vRP.setLicense(user_id,"Required")
  end
end

-- Insert into the "Police-menu" 

-- Remove License (UserID)
local choice_license = {function(player, choice)
  local user_id = vRP.getUserId(player)
   if user_id ~= nil then
    vRP.prompt(player,"UserID: ","",function(player,id)
      id = parseInt(id)
        local source = vRP.getUserSource(id)
        if source ~= nil then
          vRP.license(source)
              vRPclient.notify(source,"You took the driverslicense from" ..id)
        end
    end)
  end
end, lang.police.menu.license.description()}


-- Policemenu entry

          if vRP.hasPermission(user_id,"police.license") then
            menu[lang.police.menu.license.title()] = choice_license
          end
