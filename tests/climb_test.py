from pyBADA.bada3 import Bada3Aircraft


def test_climb_a320():
    AC = Bada3Aircraft(
        badaVersion="3.16",
        acName="A320",
        filePath="/home/giraudan/work/navigation-configuration/aircraftperformance",
    )
    altM = 20000 * 0.3048  # feet to meters
    tasMpS = 380 * 0.514444  # knots to m/s
    thrust = AC.Thrust(altM, 0, "ADAPTED", tasMpS, "CR")
    sigma = 
    CL = AC.CL(sigma, masskg, tasMpS, 1.0)
    cd = AC.CD(CL, "CR", False, {"deployed": False})
    drag = AC.D(sigma, tasMpS, cd)
    rocd = AC.ROCD(thrust, drag, tasMpS, masskg, esf, altM, 0, False)
    print(rocd)