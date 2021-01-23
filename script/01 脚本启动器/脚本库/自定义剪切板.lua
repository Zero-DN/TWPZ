
require "import"
import "java.io.File"
import "android.os.*"
import "cjson"

import "script.包.其它.主键盘"


local 参数=(...)
local 编号=1

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 脚本相对路径=string.sub(脚本名,#脚本目录+1)

local 文件=tostring(service.getLuaDir("")).."/clipboard.json"
local 内容=io.open(文件):read("*a") --读取文件全部内容
local json = require "cjson"
local 剪切板组=json.decode(内容) 







local 短语组1=剪切板组
local 当前脚本组1={}
local 短语数=5--单个键盘的短语数量
local 默认宽度=100

for c in io.lines(数据文件) do
 if c!="" then 短语组1[#短语组1+1]=c end
end--for
local 总序号=math.ceil(#短语组1/短语数)




if string.sub(参数,1,1)=="<" && string.sub(参数,#参数,#参数)==">" then
 编号=tonumber(string.sub(参数,2,#参数-1))
end

 
if 编号==1 then
 local 按键1={}
 按键1["width"]=100
 按键1["height"]=25
 按键1["click"]=""
 按键1["label"]="自定义剪切板("..编号.."/"..总序号..")"
 当前脚本组1[#当前脚本组1+1]=按键1
 if #短语组1<短语数 then
  for i=1,#短语组1 do
   当前脚本组1[#当前脚本组1+1]=短语组1[i]
  end--
  local 按键={}
  按键["width"]=100
  for i=1,短语数-#短语组1 do
   当前脚本组1[#当前脚本组1+1]=按键
  end--for
  当前脚本组1[#当前脚本组1+1]=主键盘()
 else
  
 当前脚本组1[#当前脚本组1+1]=按键2
  for i=1,短语数 do
   local 子编号=i
   if #短语组1>子编号-1 then
    当前脚本组1[#当前脚本组1+1]=短语组1[子编号]
   end--if
  end--for
 local 按键2={}
 按键2["width"]=50
 按键2["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<"..(编号+1)..">"}
 当前脚本组1[#当前脚本组1+1]=按键2
 local 按键3=主键盘()
 按键3["width"]=50
 当前脚本组1[#当前脚本组1+1]=按键3


 end--if #短语组1<25
end--if 编号==1

if 编号>1 then
 local 按键2={}
 按键2["width"]=100
 按键2["height"]=25
 按键2["click"]=""
 按键2["label"]="自定义剪切板("..编号.."/"..总序号..")"
 当前脚本组1[#当前脚本组1+1]=按键2
if #短语组1<编号*短语数 then
  for i=1,22 do
   local 子编号=i
   if #短语组1>子编号-1 then
    当前脚本组1[#当前脚本组1+1]=短语组1[子编号+(编号-1)*短语数]
   end--if
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数*编号-#短语组1 do
   当前脚本组1[#当前脚本组1+1]=按键
  end--for
  local 按键1={}
  按键1["width"]=50
  按键1["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<"..(编号-1)..">"}
 当前脚本组1[#当前脚本组1+1]=按键1
 local 按键3=主键盘()
 按键3["width"]=50
 当前脚本组1[#当前脚本组1+1]=按键3

else
  for i=1,短语数 do
   local 子编号=i
   if #短语组1>子编号-1 then
    当前脚本组1[#当前脚本组1+1]=短语组1[子编号+(编号-1)*短语数]
   end--if
  end--for
  local 按键1={}
  按键1["width"]=33
 按键1["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<"..(编号-1)..">"}
 当前脚本组1[#当前脚本组1+1]=按键1
 local 按键2={}
 按键2["width"]=33
 按键2["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<"..(编号+1)..">"}
 当前脚本组1[#当前脚本组1+1]=按键2
 local 按键3=主键盘()
 按键3["width"]=34
 当前脚本组1[#当前脚本组1+1]=按键3


end--if #短语组1>编号*22
end--if 编号>1 



service.setKeyboard{
  name="自定义剪切板",
  ascii_mode=0,
  width=默认宽度,
  height=32,
  keys=当前脚本组1
  }



