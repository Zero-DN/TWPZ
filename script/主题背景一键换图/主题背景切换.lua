
local 版本号="1.0"

local 帮助内容=[[
</big><font color=red><b>帮助说明</b></font></big>
--无障碍版专用脚本
--脚本名称: 主题背景切换
--用途：使用脚本目录中图片库文件替换主题中的背景图,并自动刷新主题显示新的背景图
--版本号: 1.0
▂▂▂▂▂▂▂▂
日期: 2020年11月27日🗓️
农历: 鼠🐁庚子年十月十三
时间: 18:24:23🕕
星期: 周五
--制作者: 风之漫舞
--首发qq群: Rime 同文斋(458845988)
--邮箱: bj19490007@163.com(不一定及时看到)

--使用说明
<b>
①必须先在主题文件中设置背景图片名称
查找keyboard_back_color节点,可能有多个,推荐命名为 background.gif,以供使用动图
②如果使用了中文输入法设置中的 键盘图标包, 其中 background图片需移除
同样使用了 自定义颜色,其中背景键盘必须为空或默认值,否则会被设置内容优先覆盖
</b>

--脚本配置说明
<b>用法一</b>
①放到脚本启动器->脚本库目录 下任意位置及子文件夹中,脚本启动器自动显示该脚本
②主题方案挂载脚本启动器
③显示一个键盘界面,
单击图片切换,长按显示图片路径

--------------------
<b>用法二</b>
第①步 将 脚本文件解压放置 Android/rime/script 文件夹内,
默认脚本路径为Android/rime/script/主题一键换图/主题背景切换.lua

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys,加入以下内容

preset_keys:
  LuaTheme0: {label: 主题, send: function, command: '主题一键换图/主题背景切换.lua', option: ""}#显示rime目录下所有主题到一个键盘,点击切换并显示
  LuaTheme1: {label: 主题1, send: function, command: '主题操作/主题操作.lua', option: "《《命令行》》【【图片名】】"}#图片名为自定义项,图片库中文件名即可
  LuaTheme_fresh: {label: 刷新主题, send: function, command: '主题操作/主题操作.lua', option: "《《命令行》》【【随机图片】】"}#随机更换一张背景图片
  
向该主题方案任意键盘按键中加入上述按键既可


]]


require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.RectF"
import "java.io.*"
import "com.osfans.trime.*" --载入包
import "android.text.Html"
import "android.graphics.drawable.StateListDrawable"

--dofile(tostring(service.getLuaExtDir("script")).."/包/其它/主键盘.lua")
import "com.osfans.trime.*" --载入包
import "yaml"


local 参数=(...)

local 输入法目录=tostring(service.getLuaExtDir("")).."/"
local 脚本目录=tostring(service.getLuaExtDir("script")).."/"
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 纯脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#纯脚本名)
local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)

local 主题实例=Config.get()
local 当前主题=tostring(主题实例.getTheme())


local 输入法目录=tostring(service.getLuaExtDir("")).."/"
local 主题组=Config.get()
local 当前主题0=主题组.getTheme()
local 主题文件=输入法目录..当前主题0..".yaml"
local yaml组 = yaml.load(io.readall(主题文件))

local 背景图片组={}

for k,v pairs(yaml组["preset_color_schemes"])
 
 local 主题背景图片=yaml组["preset_color_schemes"][k]["keyboard_back_color"]
 背景图片组[#背景图片组+1]=主题背景图片
end





local 图片组={}



local 插件包=tostring(service.getLuaExtDir("script")).."/包/文件操作/递归查找文件.lua"
if File(插件包).exists() then
 插件包=目录.."递归查找文件.text"
end
dofile(插件包)
图片组=递归查找文件(File(目录.."/图片库/"),".*")
table.sort(图片组)--数组排序



local function 刷新当前主题()
  主题实例.setTheme(tostring(当前主题)) 
 local 按键界面=Trime.getService()
 按键界面.initKeyboard()
 print("当前背景已刷新")
 --service.sendEvent("Keyboard_default")
end

local function java随机整数(最大数)
 import "java.util.*"
 local 随机数种子 =Random()
 local 随机整数=随机数种子.nextInt(最大数)+1
 return 随机整数
end--function java随机整数


local function 主题背景(图片路径)
 for i=1,#背景图片组 do
    local 路径=输入法目录..当前主题.."/"..背景图片组[i]
    LuaUtil.copyDir(图片路径,路径)
  end
  --间隔时间
  task(300,function() end)
  刷新当前主题()

end

if 参数!=nil && string.find(参数,"《《命令行》》")!=nil && string.find(参数,"【【随机图片】】")!=nil then
 主题背景(图片组[java随机整数(#图片组)])--主题背景随机
 return
end

if 参数!=nil && string.find(参数,"《《命令行》》")!=nil && string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 local 图片名=string.sub(参数 ,string.find(参数,"【【")+6,string.find(参数,"】】")-1)
 local 路径=目录.."/图片库/"..图片名
 if File(路径).exists()==false then
   print(路径.." 图片文件不存在")
   return
 end
 刷新主题(主题文件)
 return
end


dofile_信息表=nil
dofile_信息表={}
local function 显示帮助(内容)
   dofile_信息表.上级脚本=脚本路径
   dofile_信息表.上级脚本所在目录=目录
   dofile_信息表.上级脚本相对路径=脚本相对路径
   dofile_信息表.纯脚本名=纯脚本名:sub(1,-5)
   dofile_信息表.内容=内容
   
   
   dofile(目录.."帮助模块.text")--导入模块

end




local ids={}
local data={}
local item={LinearLayout,
  layout_width=-1,
  layout_height="110dp",
  padding="2dp",
  orientation="vertical",
  gravity=17,
  {ImageView;
      id="img";
      layout_width="100dp"; 
      layout_height="80dp"; 
      layout_gravity="center"; 
      adjustViewBounds="true"; 
      scaleType="fitXY";
      --layout_width="400dp";
      --layout_height="200dp";
    },
  
  {CardView,
    radius="10dp",
    layout_height="12dp",
    CardElevation=0,
    layout_width=-1,
    BackgroundColor=0x49d3d7da,
    --gravity=3|17,
    
    {LinearLayout,
    layout_width=-1,
    --BackgroundColor=0x49d3d7da,
    --gravity=3|17,

}}}
      
      
      
local adp=LuaAdapter(service,data,item)


--刷新列表
local function fresh(t)
  ids.title.setText(纯脚本名:sub(1,-5))
  table.clear(data)
  if type(t)~="table" then
    local ts={}
    for a in utf8.gmatch(tostring(t),"%S")
      table.insert(ts,a)
    end
    t=ts
  end
  local i=0
  for _,v in ipairs(t) do
    i=i+1
    
    table.insert(data,{img=图片组[i],b=" "..tostring(i)})
  end
  
  adp.notifyDataSetChanged()
end




local function Back() --生成功能键背景
  local bka=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0xffffffff)
    c.drawRoundRect(b,20,20,p) --圆角20
  end)
  local bkb=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0x49d3d7da)
    c.drawRoundRect(b,20,20,p)
  end)

  local stb=StateListDrawable()
  stb.addState({-android.R.attr.state_pressed},bkb)
  stb.addState({android.R.attr.state_pressed},bka)
  return stb
end

local function Icon(k,s) --获取k功能图标，没有返回s
  k=Key.presetKeys[k]
  return k and k.label or s
end

local function Bu_R(id) --生成功能键
  local Bu={LinearLayout,
    layout_height=-1,
    layout_width=-1,
    layout_weight=1,
    padding="2dp",
    {FrameLayout,
      layout_height=-1,
      layout_width=-1,
      Background=Back(),
      {TextView,
        gravity=17|48,
        layout_height=-1,
        layout_width=-1,
        layout_marginTop="2dp",
        textColor=0xff232323,
        textSize="10dp"},
      {TextView,
        gravity=17,
        layout_height=-1,
        layout_width=-1,
        textColor=0xff232323,
        textSize="18dp"}}}
  local msg=Bu[2][2] --上标签
  local label=Bu[2][3] --主标签
  
 
  if id==2 then
    label.text=Icon("Keyboard_default","返回")
    Bu.onClick=function()
      service.sendEvent("Keyboard_default")
    end
   elseif id==1 then
    label.text=Icon("BackSpace","⌫")
    Bu.onClick=function()
      service.sendEvent("BackSpace")
    end
    elseif id==3 then
    label.text="随机"
    Bu.onClick=function()
      主题背景(图片组[java随机整数(#图片组)])--主题背景随机
    end
    elseif id==4 then
    label.text="帮助"
    Bu.onClick=function()
      显示帮助(帮助内容)
    end
    Bu.OnLongClickListener={onLongClick=function() return true end}
  end
  return Bu
end

local height="240dp" --键盘高度
pcall(function()
  --键盘自适应高度，旧版中文不支持，放pcall里防报错
  height=service.getLastKeyboardHeight()
end)


local layout={LinearLayout,
  orientation=1,
  --键盘高度
  layout_height=height,
  layout_width=-1,
  --背景颜色
  --BackgroundColor=0xffd7dddd,
  {TextView,
    id="title",
    layout_height="30dp",
    layout_width=-1,
    text="",
    gravity="center",
    paddingLeft="2dp",
    paddingRight="2dp",
    BackgroundColor=0x49d3d7da
    },
    {LinearLayout,
    gravity="right",
    layout_height=-1,
    {LinearLayout,
      id="main",
      orientation=1,
      --右侧功能键宽度
      layout_weight=1,
      layout_height=-1,
      layout_gravity=8|3,
      {GridView, --列表控件
        id="list",
        numColumns=2, --6列
        paddingLeft="2dp",
        paddingRight="2dp",
        layout_width=-1,
        layout_weight=1}},

   {LinearLayout,
      orientation=1,
      layout_weight=1,
      layout_width="100dp",
      layout_height=-1,
      --layout_gravity=5|84,
      Bu_R(4),
      Bu_R(3),
      Bu_R(1),
      Bu_R(2)
      },
}}



layout=loadlayout(layout,ids)




ids.list.Adapter=adp

ids.list.onItemClick=function(l,v,p)
  主题背景(图片组[p+1])
end

ids.list.onItemLongClick=function(l,v,p)
  print(图片组[p+1])
  return true
end




  fresh(图片组)
  local 标题=纯脚本名:sub(1,-5)
  标题=标题..版本号
ids.title.setText(标题)


local Bus={LinearLayout,
  paddingLeft="2dp",
  layout_width=-1}


ids.main.addView(loadlayout(Bus))


service.setKeyboard(layout)






