<h1>Student#index</h1>

<%len=@students.size%>

<table style="width:100%">
<tr>
<td>ID</td><td>IDENTITY_NO</td><td>DEPARTMENT</td><td>MATHS</td><td>PHYSICS</td><td>CHEMISTRY</td><td>YEAR</td>
</tr>
	<%for i in 0..len-1%>
		<tr>
		<td><%=i+1%></td>
		<td><%=@students[i].sid%></td>
		<td><%=@students[i].dept%></td>
		<td><%=@students[i].maths%></td>
		<td><%=@students[i].physics%></td>
		<td><%=@students[i].chemistry%></td>
		<td><%=@students[i].year%></td>
		</tr>
	<%end%>	
</table>


do_query file

<h1>Student#do_query</h1>
<p>Find me in app/views/student/do_query.html.erb</p>
<% if true%>
	<div><%=@students[member].id%><div>
<%end%>
