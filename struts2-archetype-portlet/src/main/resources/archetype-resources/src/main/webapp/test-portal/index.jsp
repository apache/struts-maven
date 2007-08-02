<%@ taglib uri="http://portals.apache.org/pluto" prefix="pluto" %>
<pluto:portlet portletId="/${artifactId}.StrutsPortlet!">
  <div class="portlet" id="${artifactId}.StrutsPortlet">
    <div class="header">
      <h2 class="title"><pluto:title></pluto:title></h2>
   </div>
    <div class="body">
      <pluto:render></pluto:render>
   </div>
 </div>
</pluto:portlet>