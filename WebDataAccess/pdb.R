u = 'http://www.rcsb.org/pdb/rest/customReport.xml'

library(RCurl)

txt = getForm(u,     pdbids = '1stp,2jef,1cdg',
           customReportColumns = 'structureId,structureTitle,experimentalTechnique')

library(XML)
doc = xmlParse(txt)


u = 'http://www.rcsb.org/pdb/rest/describeMol'
tmp = getForm(u, structureId = '4MZ1')
