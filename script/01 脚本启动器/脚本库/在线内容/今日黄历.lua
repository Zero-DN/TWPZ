
local 云输入内容="https://www.199ge.com/index.html"
--print("在线连接中,稍等片刻马上喝汤...\nヾ ^_^♪")
local 内容=""
local 内容组={}
Http.get(云输入内容,nil,"gbk",nil,function(a,b)
 if a==200 then 
  local 开始位置=string.find(b,"class=\"titme_right\">")
  开始位置=string.find(b,"<dt>",开始位置)
  local 结束位置=string.find(b,"</dt>",开始位置)
  内容="▂▂▂▂▂▂▂▂\n今日黄历\n🗓日期: "..string.sub(b,开始位置+4,结束位置-1)--日期 星期
  
  开始位置=string.find(b,"class=\"sxity\">",开始位置)
  结束位置=string.find(b,"</font>",开始位置)
  内容=内容.."\n岁次: "..string.sub(b,开始位置+14,结束位置-1)--
  
  开始位置=string.find(b,"<font>",开始位置)
  结束位置=string.find(b,"</font>",开始位置)
  内容=内容.."\n农历: "..string.sub(b,开始位置+6,结束位置-1)--
  
  开始位置=string.find(b,"宜",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."\n宜: "..string.sub(b,开始位置+14,结束位置-1)--
  
  开始位置=string.find(b,"忌",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."\n忌: "..string.sub(b,开始位置+14,结束位置-1)--
  
  开始位置=string.find(b,"冲",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."\n冲: "..string.sub(b,开始位置+14,结束位置-1)--
  
  开始位置=string.find(b,"吉神",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."\n吉神: "..string.sub(b,开始位置+17,结束位置-1)--
  
  开始位置=string.find(b,"凶神",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."\n凶神: "..string.sub(b,开始位置+17,结束位置-1)--
  
  开始位置=string.find(b,"五行",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."\n五行: "..string.sub(b,开始位置+17,结束位置-1)--
  
  开始位置=string.find(b,"执位",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."(执位: "..string.sub(b,开始位置+17,结束位置-1)..")"--
  
  开始位置=string.find(b,"胎神占方",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."\n胎神占方: "..string.sub(b,开始位置+23,结束位置-1)--
  
  开始位置=string.find(b,"彭祖百忌",开始位置)
  结束位置=string.find(b,"</dd>",开始位置)
  内容=内容.."\n彭祖百忌: "..string.sub(b,开始位置+23,结束位置-1)--
  
  
  
  内容=string.gsub(内容,"<br>","\n")
  内容=string.gsub(内容,"&nbsp;"," ")
  内容=string.gsub(内容,"<.->","")
  内容=string.gsub(内容,"&ldquo;","\"")
  内容=string.gsub(内容,"&rdquo;","\"")
  --内容=string.gsub(内容,"&nbsp"," ")
 --print(内容)
 task(100,function()
  service.addCompositions({内容}) end)
 else
 print("对不起,你的网络似乎出现了点问题")
 end
 end)
