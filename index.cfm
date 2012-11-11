<style type="text/css">
body{background-color: black;}
TD{font-family: Courier ; font-size: 10pt; color: lime;}
TH{font-family: Courier ; font-size: 10pt; color: lime;}
P{font-family: Courier ; font-size: 10pt; color: white;}
</style>
<cfsetting requesttimeout="500">
<cfoutput>
<cfset iName = "127.0.0.1">

<table width=945 bgcolor=black border="0"><tr><td style=color:black>&</td></tr><tr><th width=10% align=left><u>Service</u></th><th width=15% align=left><u>Application</u></th><th align=left><u>Server</u> / <u>Port</u></th><th align=right><u>Server: #iName#</u></th></tr></table>

<cfset xmlPortNumber = XmlParse("portindex.xml")>
<cfset maxList = #ArrayLen(xmlPortNumber.instance.XmlChildren)#>
<cfLoop index="i" from = "1" to = #maxList# step="1">
<cfset portNum = #xmlPortNumber.instance.XmlChildren[i].port.XmlText#>
<cfset appName = #xmlPortNumber.instance.XmlChildren[i].name.XmlText#>
<cfset serviceName = #xmlPortNumber.instance.XmlChildren[i].service.XmlText#>

<cfoutput>
<cfscript>
socket=CreateObject("java", "java.net.Socket");
try {
socket.init(iName, portNum);
socket.setSoTimeout(50000);
isAlive=true; 
ServerIP = socket.toString();
ServerPort = socket.getPort();
socket.close();
if(isAlive)
writeoutput("<table font-size:11 border=0 cellpadding=0 bgcolor=black width=945><tr><td width=10% align=left>#serviceName#</td><td width=15% style=color:lime align=left>#appName#</td><td align=left>#ServerIP#</td><td align=right>#Now()#</td><td width=2%><img src=correct.png height=20 width=20  align=right></td>");
} 
catch (Any excpt) {
isAlive=false;
writeoutput("<table font-size:11 border=0 cellpadding=0 bgcolor=black width=945><tr><td width=10% align=left>#serviceName#</td><td width=15% style=color:red align=left>#appName#</td><td width=12% align=left>#iName# </td><td align=left> / #portNum#</td><td align=right>#Now()#</td><td width=2%><img src=incorrect.png height=20 width=20 align=right></td>");
socket.close();
}
</cfscript>
</cfoutput>
</CFLoop>
</cfoutput>