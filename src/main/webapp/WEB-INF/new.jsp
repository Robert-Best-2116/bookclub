<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add A Book</title>
</head>
<body>

<h1>Add A Book To The Shelf!!</h1>

	<form:form action="/create" method="post" modelAttribute="book" >
		<div>
			<form:label path="title">Title</form:label>
			<form:input type="text" path="title"/>
			<form:errors path="title" class="text-danger" />
		</div>
		<div>
			<form:label path="author">Author</form:label>
			<form:input type='text' path='author'/>
			<form:errors path="author" class="text-danger" />
		</div>
		<div>
			<form:label path="thoughts">Your Thoughts??</form:label>
			<form:input type='text' path='thoughts'/>
			<form:errors path="thoughts" class="text-danger" />
		</div>
		<div>
			<form:input type="hidden" path="user" value="${user.id}"/>
			<input type='submit' value='Submit' class="button">
		</div>
	</form:form>
	
	<a href="/dashboard">Home</a>

</body>
</html>