<jsp:include page="header.jsp" flush="true" />
<%-- $HeadURL$
 This file is part of deegree, http://deegree.org/
 Copyright (C) 2001-2009 by:
 - Department of Geography, University of Bonn -
 and
 - lat/lon GmbH -

 This library is free software; you can redistribute it and/or modify it under
 the terms of the GNU Lesser General Public License as published by the Free
 Software Foundation; either version 2.1 of the License, or (at your option)
 any later version.
 This library is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 details.
 You should have received a copy of the GNU Lesser General Public License
 along with this library; if not, write to the Free Software Foundation, Inc.,
 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

 Contact information:

 lat/lon GmbH
 Aennchenstr. 19, 53177 Bonn
 Germany
 http://lat-lon.de/

 Department of Geography, University of Bonn
 Prof. Dr. Klaus Greve
 Postfach 1147, 53001 Bonn
 Germany
 http://www.geographie.uni-bonn.de/deegree/

 e-mail: info@deegree.org
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="logotable.jsp" flush="true" />
<jsp:include page="menutable.jsp" flush="true" />

<%@ page import="org.deegree.security.drm.model.*"%>
<%@ page import="org.deegree.portal.standard.security.control.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.deegree.framework.util.*"%>

<script language="JavaScript1.2" type="text/javascript" src="js/serviceseditor.js"></script>
<script language="JavaScript1.2" type="text/javascript">
var linkmap = { sort1: "updateServicesTable(sortFun(true, 'title'))",
                        sort2: "updateServicesTable(sortFun(false, 'title'))",
                sort3: "updateServicesTable(sortFun(true, 'address'))",
                sort4: "updateServicesTable(sortFun(false, 'address'))",
                sort5: "updateServicesTable(sortFun(true, 'type'))",
                sort6: "updateServicesTable(sortFun(false, 'type'))" }
function init() {
    services = {}
    document.getElementById("contentDiv").style.height = (calcWindowSize("Height") - 240) + "px"
<%
    LinkedList<Service> services = (LinkedList<Service>)request.getAttribute("SERVICES");
    if(services != null){
    for(Service service : services){
        out.println("services[\"" + service.getAddress() + "\"] = {}");
        out.println("var service = services[\"" + service.getAddress() + "\"]");
        out.println("service[\"title\"] = '" + (service.getServiceTitle() == null ? "(kein Titel)" : service.getServiceTitle()) + "'");
        out.println("service.objects = {}");
        out.println("service.type = '" + service.getServiceType() + "'");
        out.println("service.address = '" + service.getAddress() + "'");
        for(StringPair pair : service.getObjects()){
            out.println("service.objects[\"" + pair.first + "\"] = '" + pair.second.replace("'", "\\'") + "'");
        }
    }
}

%>

    var table = document.getElementById("servicesTable")
    if(!table.addEventListener){
        table.firstChild.firstChild.lastChild.setAttribute("className", "servicesBorderTop")
    }
    updateServicesTable()
}
</script>
<table class="maintablebig">
    <tr>
        <td valign="top">
        <h2>Services-Editor</h2>
        <div>
        <form action="javascript:importService()" name="serviceSelectForm">
        <p class="caption">Typ: <input type="radio" name="serviceType" checked="checked" value="wms" onclick="clickedRadio()"><span style="font-weight:normal;">WMS
        <input type="radio" name="serviceType" value="wfs" onclick="clickedRadio()">WFS</span></p>
        <p class="caption">Eingabe: <input type="text" name="serviceAddress" size="50"
            value="http://demo.deegree.org/deegree-wms/services" /> <input type="submit" name="import"
            value="Importieren" /></p>
        <div id="contentDiv" class="scrollable">
        <table id="servicesTable" rules="rows" class="centeredTable">
            <tr id="servicesTableHeader">
                <th class="servicesBorder">Nr.</th>
                <th class="servicesBorder">Titel<a title="Aufsteigend sortieren" class="sorting" id="sort1" href="javascript:sortLinkClicked(linkmap, 'sort1')">&lsaquo;</a><a title="Absteigend sortieren" class="sorting" id="sort2" href="javascript:sortLinkClicked(linkmap, 'sort2')">&rsaquo;</a></th>
                <th class="servicesBorder">Adresse<a title="Aufsteigend sortieren" class="sorting" id="sort3" href="javascript:sortLinkClicked(linkmap, 'sort3')">&lsaquo;</a><a title="Absteigend sortieren" class="sorting" id="sort4" href="javascript:sortLinkClicked(linkmap, 'sort4')">&rsaquo;</a></th>
                <th class="servicesBorder">Typ<a title="Aufsteigend sortieren" class="sorting" id="sort5" href="javascript:sortLinkClicked(linkmap, 'sort5')">&lsaquo;</a><a title="Absteigend sortieren" class="sorting" id="sort6" href="javascript:sortLinkClicked(linkmap, 'sort6')">&rsaquo;</a></th>
                <th class="servicesBorder">Aktion</th>
            </tr>
        </table>
        </div>
        </form>
        </div>
        </td>
    </tr>
</table>
<jsp:include page="footer.jsp" flush="true" />
