--!strict

local Constants = {}

Constants.SETS = { "k", "M", "B" }

Constants.FIRST_ONES = {
	"", "U", "D", "T", "Qd", "Qn", "Sx", "Sp", "Oc", "No"
}

Constants.SECOND_ONES = {
	"", "De", "Vg", "Tg", "Qag", "Qig", "Sxg", "Spg", "Ocg", "Nog"
}

Constants.THIRD_ONES = {
	"", "Ce", "Du", "Tr", "Qa", "Qi", "Se", "Si", "Ot", "Ni"
}

Constants.MULT_ONES = {
	"", "Mi", "Mc", "Na", "Pi", "Fm", "At", "Zp", "Yc", "Xo", "Ve", "Me",
	"Due", "Tre", "Te", "Pt", "He", "Hp", "Oct", "En", "Ic", "Mei",
	"Dui", "Tri", "Teti", "Pti", "Hei", "Hp", "Oci", "Eni", "Tra", "TeC",
	"MTc", "DTc", "TrTc", "TeTc", "PeTc", "HTc", "HpT", "OcT", "EnT", "TetC",
	"MTetc", "DTetc", "TrTetc", "TeTetc", "PeTetc", "HTetc", "HpTetc", "OcTetc", "EnTetc",
	"PcT", "MPcT", "DPcT", "TPCt", "TePCt", "PePCt", "HePCt", "HpPct", "OcPct", "EnPct",
	"HCt", "MHcT", "DHcT", "THCt", "TeHCt", "PeHCt", "HeHCt", "HpHct", "OcHct", "EnHct",
	"HpCt", "MHpcT", "DHpcT", "THpCt", "TeHpCt", "PeHpCt", "HeHpCt", "HpHpct", "OcHpct", "EnHpct",
	"OCt", "MOcT", "DOcT", "TOCt", "TeOCt", "PeOCt", "HeOCt", "HpOct", "OcOct", "EnOct",
	"Ent", "MEnT", "DEnT", "TEnt", "TeEnt", "PeEnt", "HeEnt", "HpEnt", "OcEnt", "EnEnt",
	"Hect", "MeHect"
}

return Constants
