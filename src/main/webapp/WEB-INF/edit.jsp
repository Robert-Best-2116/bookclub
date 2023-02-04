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
<title>Edit</title>
</head>
<body>

  <h1>Edit Book</h1>
  <form:form action="/editBook/${book.id}" method="put" modelAttribute="book">
      <input type="hidden" name="_method" value="put">
      <p>
          <form:label path="title">Title</form:label>
          <form:errors path="title"/>
          <form:input path="title"/>
      </p>
      <p>
          <form:label path="author">Author</form:label>
          <form:errors path="author"/>
          <form:textarea path="author"/>
      </p>
      <p>
          <form:label path="thoughts">thoughts</form:label>
          <form:errors path="thoughts"/>
          <form:input path="thoughts"/>
      </p>
      		<div>
			<form:input type="hidden" path="user" value="${book.user.id}"/>
			<form:input type="hidden" path="user" value="${book.borrower.id}"/>
			<input type='submit' value='Submit' class="button">
		</div>
      <input type="submit" value="Submit"/>
  </form:form>

  <a href="/dashboard">Home</a>

</body>
</html>