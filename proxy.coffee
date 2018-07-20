proxy = require 'proxy-agent'
module.exports = (robot) ->
  robot.globalHttpOptions.httpAgent  = proxy('http://proxy.atg.sony.co.jp:10080', false)
  robot.globalHttpOptions.httpsAgent = proxy('https://proxy.atg.sony.co.jp:10080', true)
