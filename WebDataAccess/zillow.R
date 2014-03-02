#http://www.zillow.com/howto/api/GetZestimate.htm
#
u = 'http://www.zillow.com/webservice/GetSearchResults.htm'

txt = getForm(u, 'zws-id' = ZillowId,  address = "1292 Monterey Avenue", citystatezip = "Berkeley, 94707")
