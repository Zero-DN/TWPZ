require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "yaml"
--activity.setTitle('AndroLua+')
--activity.setTheme(android.R.style.Theme_Holo_Light)
--activity.setContentView(loadlayout(layout))

function checkyaml(path)
  local content = yaml.load(io.readall(activity.getLuaExtPath(path)))
  --print(dump(content))

  --serialized = yaml.dump(content)
  --print(serialized)
  function show(t,r)
    local l={}
    for k,v pairs(t)
      if type(v)~="table"
        k=k.."="..tostring(v)
      end
      table.insert(l,k)
    end
    table.sort(l)
    LuaDialog(){
      title=r,
      items=l,
      onItemClick=function(l,v)
        if t[v.text]
          show(t[v.text],r..">"..v.text)
         elseif t[tointeger(v.text)]
          show(t[tointeger(v.text)],r..">"..v.text)
        end
      end,
      button="确定",
    }.show()
  end
  show(content,path)
end



--activity.setTitle('AndroLua+')
dir=activity.getLuaExtDir()
--print(dir)

fs=luajava.astable(File(dir).list())
ds={}
--print(dir,dump(fs),#File(dir).list())
for k,v ipairs(fs)
  if v:find(".yaml$") and not(v:find("dict.yaml$"))
    table.insert(ds,v)
  end
end
table.sort(ds)
local layout={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  layout_height="fill",
  {
    ListView,
    id="list",
    items=ds,
    layout_width="fill",
  },
}

activity.setContentView(loadlayout(layout))
function read(p)
  local f=io.open(p)
  local s=f:read("a")
  f:close()
  return s
end


list.onItemClick=function(l,v)
  local s,m=pcall(checkyaml,v.text)
  if s==false
    LuaDialog(){
      title=v.text,
      message=m

    }.show()
  end
end
