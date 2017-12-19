FlightMode = {}

local options = {
  { "Color", COLOR, WHITE },
  { "Shadow", COLOR, BLACK }
}

local function create(zone, options)
  local thisZone = { zone=zone, options=options, ts = MIDSIZE, xs = 0, yo = 0 }
   
  local i
	
  for i=0, 22 do
    FlightMode[i] = {}
    FlightMode[i].Name=""
  end

  FlightMode[0].Name="Manual"
  FlightMode[1].Name="Circle"
  FlightMode[2].Name="Stabilize"
  FlightMode[3].Name="Training"
  FlightMode[4].Name="Acro"
  FlightMode[5].Name="FBWA"
  FlightMode[6].Name="FBWB"
  FlightMode[7].Name="Cruise"
  FlightMode[8].Name="Autotune"
  FlightMode[9].Name="Undef"
  FlightMode[10].Name="Auto"
  FlightMode[11].Name="RTL"
  FlightMode[12].Name="Loiter"
  FlightMode[13].Name="Undef"
  FlightMode[14].Name="AVOID_ADSB"
  FlightMode[15].Name="Guided"
  FlightMode[16].Name="Undef"
  FlightMode[17].Name="QSTABILIZE"
  FlightMode[18].Name="QHOVER"
  FlightMode[19].Name="QLOITER"
  FlightMode[20].Name="QLAND"
  FlightMode[21].Name="QRTL"
  FlightMode[22].Name="Invalid"
  
  if 		thisZone.zone.w  > 240 then
	thisZone.ts = XXLSIZE
	thisZone.xs = 14
	thisZone.yo = thisZone.zone.h / 2 - 38
  elseif 	thisZone.zone.w  > 70 then
	thisZone.ts = DBLSIZE
	thisZone.xs = 11
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
	
	local flightModeNumber = getValue("Tmp1")
	
    if flightModeNumber < 0 or flightModeNumber > 22 then
        flightModeNumber = 22
    end
	
    local fm = FlightMode[flightModeNumber].Name

	local xo = thisZone.zone.x + (thisZone.zone.w / 2) - (thisZone.xs * string.len(fm))
	local yo = thisZone.zone.y + thisZone.yo
	lcd.setColor(CUSTOM_COLOR, thisZone.options.Shadow)
	lcd.drawText(xo + 2, yo + 2, fm, thisZone.ts + CUSTOM_COLOR)
	lcd.setColor(CUSTOM_COLOR, thisZone.options.Color)
	lcd.drawText(xo, yo, fm, thisZone.ts + CUSTOM_COLOR);
end

return { name="FlightMode", options=options, create=create, update=update, background=background, refresh=refresh }
