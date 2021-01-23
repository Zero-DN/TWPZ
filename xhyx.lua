
function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

------------



require "import"
import "cjson"
import "android.widget.*"


function updateComposing(i,c,t)
  if i=="" then service.addCompositions({"云翻译\n请输入单词或句子，\'表示空格"}) end
  if geting return end
  if i=="" then service.addCompositions({"微信分享使用说明(需开悬浮窗口)","任意内容+后缀关键字微信","例子 \n打出如下内容\n今天天气不错微信","自动向微信分享 今天天气不错 内容"}) end





  有网络=true
  
  local 有道启动码="~"
  local 其它编码=string.sub(i,#有道启动码+1)
  首字符="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  字符="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  if string.sub(i,1,#有道启动码)==有道启动码  && #i>#有道启动码 && string.find(首字符,string.sub(其它编码,1,1))>0 then
    geting=true
    local 其它编码=string.gsub(其它编码,"//"," ")
    local 其它编码=string.gsub(其它编码,"/"," ")
    local 云输入内容0="http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i="..其它编码
    Http.get(云输入内容0,function(c,t)
    local s1 = string.find(t,"tgt\":\"",1, true)+6
    local s2 = string.find(t,"}]]}")-2
    local 候选=string.sub(t,s1,s2)
    service.addCompositions({其它编码,候选})
    geting=false
    end)
  end
  
  
  候选后缀="英语"
  if  string.sub(t,-#候选后缀 ) == 候选后缀 && t !=候选后缀 then
  实际内容=string.sub(t,1,-#候选后缀 -1)
    geting=true
   有网络=true
    local 云输入内容0="http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i="..实际内容
    Http.get(云输入内容0,function(c,t)
    if string.find(t,"Unable to resolve")==1 then 
    Toast.makeText(service, "翻译云无内容，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
    if 有网络 then
    候选=string.sub(t,string.find(t,"tgt\":\"",1, true)+6,string.find(t,"}]]}")-2)
     task(100,function() end)
     内容1=候选..".("..实际内容..")"
     service.addCompositions({候选,内容1})
  end
    geting=false
  end)
  end


--翻译法语
候选后缀="法语"
  if  string.sub(t,-#候选后缀 ) == 候选后缀 && t !=候选后缀 then
  实际内容=string.sub(t,1,-#候选后缀 -1)
    geting=true
   有网络=true
    local 云输入内容0="http://fanyi.youdao.com/translate?&doctype=json&type=ZH_CN2FR&i="..实际内容
    Http.get(云输入内容0,function(c,t)
    if string.find(t,"Unable to resolve")==1 then 
    Toast.makeText(service, "翻译云无内容，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
    if 有网络 then
    候选=string.sub(t,string.find(t,"tgt\":\"",1, true)+6,string.find(t,"}]]}")-2)
     task(100,function() end)
     内容1=候选..".("..实际内容..")"
     service.addCompositions({候选,内容1})
  end
    geting=false
  end)
  end





--翻译日语
候选后缀="日语"
  if  string.sub(t,-#候选后缀 ) == 候选后缀 && t !=候选后缀 then
  实际内容=string.sub(t,1,-#候选后缀 -1)
    geting=true
   有网络=true
    local 云输入内容0="http://fanyi.youdao.com/translate?&doctype=json&type=ZH_CN2JA&i="..实际内容
    Http.get(云输入内容0,function(c,t)
    if string.find(t,"Unable to resolve")==1 then 
    Toast.makeText(service, "翻译云无内容，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
    if 有网络 then
    候选=string.sub(t,string.find(t,"tgt\":\"",1, true)+6,string.find(t,"}]]}")-2)
     task(100,function() end)
     内容1=候选..".("..实际内容..")"
     service.addCompositions({候选,内容1})
  end
    geting=false
  end)
  end



  
    if t=="天气" then
    geting=true
    Http.get("http://t.weather.sojson.com/api/weather/city/101180101",function(c1,t1)
     if string.find(t1,"Unable to resolve")==1 then 
    Toast.makeText(service, t.."内容无法获取，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
   if 有网络 then
    --service.addCandidates({utf8.reverse(t)})
    local d=cjson.decode(t1).data.forecast[1]
    if d==nil return end
    service.addCompositions({string.format("【广州🏝】%s\n----------------------------\n❄️️%s 🔥️%s\n💨️%s%s\n🌳️空气质量:%s",d.type,d.low,d.high,d.fx,d.fl,d.aqi)})
    --service.addCompositions({t1})
    end
    geting=false
    end)
  end
  


  if t=="日期"
    local date=os.date("%Y年%m月%d日",os.time())
    date=date:gsub("(%D)0(%d)","%1%2")
    date=date:gsub("%d",{
      ["1"]="一",
      ["2"]="二",
      ["3"]="三",
      ["4"]="四",
      ["5"]="五",
      ["6"]="六",
      ["7"]="七",
      ["8"]="八",
      ["9"]="九",
      ["0"]="零",
    })
    service.addCompositions({date})
  end


require "import"
import "cjson"
import "android.widget.*"
import "java.io.File"
import "android.content.Context" 

import "android.view.*"


function 微信分享(内容)
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "android.content.*"

--分享文字到微信
text=内容
intent=Intent(Intent.ACTION_SEND); 
intent.setType("text/plain"); 
intent.putExtra(Intent.EXTRA_SUBJECT, "分享"); 
intent.putExtra(Intent.EXTRA_TEXT, text); 
intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
componentName =ComponentName("com.tencent.mm","com.tencent.mm.ui.tools.ShareImgUI");
intent.setComponent(componentName)

service.startActivity(Intent.createChooser(intent,"分享到:")); 
end


候选后缀="微信"
  if  string.sub(t,-#候选后缀 ) == 候选后缀 && t !=候选后缀 then
  实际内容=string.sub(t,1,-#候选后缀 -1)
  微信分享(实际内容)
  end



if t=="高考" then 
   local 提醒内容="高考时间为 2020-7-7 \n还有 "..倒计时("2020-7-7").."天 加油✊✊✊"
   service.addCompositions({提醒内容})
  end
function 倒计时(结束日期)
 local strDate1 =  tostring(os.date("%Y-%m-%d"))
 local _, _, y, m, d, _hour, _min, _sec = string.find(strDate1, "(%d+)-(%d+)-(%d+)");
 --转化为时间戳
 local s1 = os.time({year=y, month = m, day = d});
 
  local strDate2 = 结束日期
  local _, _, y, m, d, _hour, _min, _sec = string.find(strDate2, "(%d+)-(%d+)-(%d+)");
  --转化为时间戳
  local s2 = os.time({year=y, month = m, day = d});
  local s = os.difftime(s2, s1)
  local t_time=tostring((s/(60*60*24))-1)
 return string.sub(t_time,1,#t_time-2)
end

if t=="宝贝" then 
   local 提醒内容="宝贝生日时间为 2021-3-23 \n还有 "..倒计时("2021-3-23").."天"
   service.addCompositions({提醒内容})
  end
function 倒计时(结束日期)
 local strDate1 =  tostring(os.date("%Y-%m-%d"))
 local _, _, y, m, d, _hour, _min, _sec = string.find(strDate1, "(%d+)-(%d+)-(%d+)");
 --转化为时间戳
 local s1 = os.time({year=y, month = m, day = d});
 
  local strDate2 = 结束日期
  local _, _, y, m, d, _hour, _min, _sec = string.find(strDate2, "(%d+)-(%d+)-(%d+)");
  --转化为时间戳
  local s2 = os.time({year=y, month = m, day = d});
  local s = os.difftime(s2, s1)
  local t_time=tostring((s/(60*60*24))-1)
 return string.sub(t_time,1,#t_time-2)
end

if t=="考研" then 
   local 提醒内容="考研时间为 2020-12-19 \n还有 "..倒计时("2020-12-19").."天 加油👍👍👍"
   service.addCompositions({提醒内容})
  end
function 倒计时(结束日期)
 local strDate1 =  tostring(os.date("%Y-%m-%d"))
 local _, _, y, m, d, _hour, _min, _sec = string.find(strDate1, "(%d+)-(%d+)-(%d+)");
 --转化为时间戳
 local s1 = os.time({year=y, month = m, day = d});
 
  local strDate2 = 结束日期
  local _, _, y, m, d, _hour, _min, _sec = string.find(strDate2, "(%d+)-(%d+)-(%d+)");
  --转化为时间戳
  local s2 = os.time({year=y, month = m, day = d});
  local s = os.difftime(s2, s1)
  local t_time=tostring((s/(60*60*24))-1)
 return string.sub(t_time,1,#t_time-2)
end


end
