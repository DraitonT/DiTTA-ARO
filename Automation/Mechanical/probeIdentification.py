nodeID = 100
analysis=ExtAPI.DataModel.AnalysisByName('Static Structural')
resultObject=ExtAPI.DataModel.GetObjectsByName('Equivalent Stress')[0]
probeLabel = Graphics.LabelManager.CreateProbeLabel(resultObject)
probeLabel.Scoping.Node = nodeID 

with Transaction(nodeID):
    labelsForRes = Graphics.LabelManager.GetObjectLabels(resultObject)
    Graphics.LabelManager.DeleteLabels(labelsForRes)
    probeLabel = Graphics.LabelManager.CreateProbeLabel(resultObject)
    probeLabel.Scoping.Node = nodeID
    probeLabel.Note = "NOT OK"
    probeLabel.Color = Ansys.ACT.Common.Graphics.Color(red=240, green=0, blue=0, alpha=50)