<%@ page language="java"%>
<%@ page import="java.util.List,org.tutorial.Panne,org.tutorial.PanneDAOImpl"%>
<%@ page import="java.sql.Timestamp"%>
<%
List<Panne> listPanne = (List<Panne>)request.getAttribute("listPanne");

if(request.getParameter("Résolution")!=null)
{
	PanneDAOImpl.solvePanne(request.getParameter("Résolution").toString());
	String site=new String("http://localhost:8080/HighLanderJEE/MainServlet");
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location",site);
	}
%>


<html>
<head>
<title>Accueil</title>
</head>
<body>
<h1>Accueil</h1>
liste des pannes : 
<table border="1">
	<tr>
		<th>Nom du serveur</th>
		<th>Date de la panne</th>
		<th>Type de la panne</th>
		<th>Résolution de la pannes</th>
	</tr>
<%
for (Panne Panne:listPanne) {
	String serveur_nom = Panne.getServeur_nom();
	Timestamp date = Panne.getDate();
	String type = Panne.getType();
	int status = Panne.getStatus();
%>
<tr>
	<td><%=serveur_nom%></td>
	<td><%=date%></td>
	<td><%=type%></td>
	<td>
	<% if(status == 0)
		{ %>
		<form method=POST>
		<button class="resolved_button" name="Résolution" type=submit value=<%=serveur_nom%> id="file">
		Resoudre la panne 
		</button>
		</form>
		<% }
		else
		{%>
		<div>Panne resolue</div>
		<%
		}%>
	</td>
</tr>

<%
}
%>
</table>

</body>
</html>