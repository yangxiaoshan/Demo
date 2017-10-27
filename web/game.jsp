<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: dllo
  Date: 17/10/27
  Time: 上午9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>游戏</title>
    <script>
        function onChange(value) {
            //输出value的值
            console.log(value)
            //根据value的值发送请求,获取二级列表的json数据
            var data = new FormData();
            data.append("index", value);

            var xhr = new XMLHttpRequest();
            xhr.withCredentials = true;

            xhr.addEventListener("readystatechange", function () {
                if (this.readyState === 4) {
                    console.log(this.responseText);
                    //对请求回来的数据进行解析
                    json =eval('('+this.responseText+')');
                    //获取服务器的标签
                    serverSelect = document.getElementById("servers");
                    //获取option标签
                    optionEle = serverSelect.getElementsByTagName("option")
                    //获取option数量
                    length = optionEle.length;
                    //使用循环清空所有的option标签
                    for (var i = 0;i<length;i++){
                        serverSelect.removeChild(optionEle[0]);
                    }
                    serverSelect.innerHTML = "<option value = '-1'>--选择服务器--</option>";
                    //将json数据插入到option中
                    for(var i = 0;i<json.length;i++){
                        //创建一个option标签
                        option = document.createElement("option");
                        //设置value属性
                        option.setAttribute("value",json[i].id);
                        //设置文本信息
                        text = document.createTextNode(json[i].sname);
                        //把文本信息添加到option标签中
                        option.appendChild(text);
                        //把option标签添加到servers的select中
                        serverSelect.appendChild(option);
                    }
                }
            });

            xhr.open("POST", "getServerJson.action");

            xhr.send(data);
        }
    </script>
</head>
<body>
<h1>选择游戏大区</h1>
<%--显示CitySelectAction中的区数据--%>
<s:select list="areaList" label="选择区" headerKey="-1" headerValue="--选择大区--" listKey="id"
          listvalue="aname" onchange="onChange(this.value)"/>

<hr/>
<select onchange="onChange(value)">
    <option value="-1">--选择大区--</option>
    <s:iterator value="areaList" var="area">
        <option value=${area.id}>${area.aname}</option>
    </s:iterator>
</select>

服务器:
<select id="servers">
    <option value="-1">--选择服务器--</option>
</select>
</body>
</html>
