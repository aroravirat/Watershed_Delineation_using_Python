from pcraster import*

DEM = readmap ("/home/omkar/dem5.map")

FlowDirection = lddcreate(DEM,3601,3601,0.000277778,72.9999)

report(FlowDirection,"FlowDirectionpys.map")

Strahler = streamorder(FlowDirection)

report(Strahler, "strahlerpys.map")

Strahler8 = ifthen(Strahler > 4 , boolean(1))

report(Strahler8, "strahlerpys4a.map")

outlet = readmap("/home/omkar/outletpys.map")

RurCatchment = catchment(FlowDirection,outlet)

report(RurCatchment,"rurcatchmentpys.map")


