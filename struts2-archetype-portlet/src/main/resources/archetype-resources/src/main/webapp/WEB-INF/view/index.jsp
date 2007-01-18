<%@ taglib prefix="s" uri="/struts-tags" %>
<H2>Welcome to the Struts blank portlet</H2>
<p/>
This is an example of accessing the action's properties:
<table>
 <tr>
  <th>Name</th>
  <td><s:property value="%{name}" /></td>
 </tr>
</table>
<ul>
<li><a href="<s:url action="index" portletMode="edit"/>">Go to edit mode and see what's there</a></li>
<li><a href="<s:url action="index" portletMode="help"/>">Go to help mode and see what's there</a></li>
</ul>
