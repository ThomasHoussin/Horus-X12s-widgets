GPS_Status = {}

local options = {
  { "Color", COLOR, WHITE },
  { "Shadow", COLOR, BLACK }
}

local function create(zone, options)
  local thisZone = { zone=zone, options=options, ts = MIDSIZE, xs = 0, yo = 0 }
   
  local i
	
  for i=0, 5 do
    GPS_Status[i] = {}
    GPS_Status[i].Name=""
  end

  GPS_Status[0].Name="No GPS"
  GPS_Status[1].Name="No Fix"
  GPS_Status[2].Name="2D Fix"
  GPS_Status[3].Name="3D Fix"
  GPS_Status[4].Name="3DD Fix"
  GPS_Status[5].Name="Invalid"
  
  if 		thisZone.zone.w  > 240 then
	thisZone.ts = DBLSIZE
	thisZone.xs = 11
	thisZone.yo = thisZone.zone.h / 2 - 38
  elseif 	thisZone.zone.w  > 70 then
	thisZone.ts = MIDSIZE
	thisZone.xs = 6
	thisZone.yo = thisZone.zone.h / 2 - 20
	else
			thisZone.ts = SMLSIZE
			thisZone.xs = 4
			thisZone.yo = thisZone.zone.h / 2 - 8
	end
  return thisZone
end

local function update(thisZone, options)
  thisZone.options = options
end

local function background(thisZone)
  return
end

function refresh(thisZone)
	
	local gpsinfo = getValue("Tmp2")
	local gpsnum = math.floor(gpsinfo / 10)
	local gpsstatus = gpsinfo - gpsnum * 10
	
    if gpsstatus < 0 or gpsstatus > 5 then
        gpsstatus = 5
    end
	
	local msg = GPS_Status[gpsstatus].Name
	if gpsstatus > 0 and gpsstatus <5 then
		msg = msg .. ", " .. gpsnum
	end
	
	local xo = thisZone.zone.x + (thisZone.zone.w / 2) - (thisZone.xs * string.len(msg))
	local yo = thisZone.zone.y + thisZone.yo
	lcd.setColor(CUSTOM_COLOR, thisZone.options.Color)
	lcd.drawText(xo, yo, msg, thisZone.ts + CUSTOM_COLOR + SHADOWED);
end

return { name="GPS_Status", options=options, create=create, update=update, background=background, refresh=refresh }
