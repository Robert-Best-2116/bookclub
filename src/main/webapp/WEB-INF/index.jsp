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
<title>Login Or Register</title>
</head>
<body>

	<form:form action="/register" method="post" modelAttribute="newUser" >
		<div>
			<form:label path="userName">User Name: </form:label>
			<form:input type="text" path="userName"/>
			<form:errors path="userName" class="text-danger" />
		</div>
		<div>
			<form:label path="email">Email:</form:label>
			<form:input type='text' path='email'/>
			<form:errors path="email" class="text-danger" />
		</div>
		<div>
			<form:label path="password">Password: </form:label>
			<form:input type='password' path='password'/>
			<form:errors path="password" class="text-danger" />
		</div>
		<div>
			<form:label path="confirm">Confirm Password:</form:label>
			<form:input type='password' path='confirm'/>
			<form:errors path="confirm" class="text-danger" />		
		</div>
		<div>
			<input type='submit' value='Submit' class="button">
		</div>
	</form:form>
	
	
			<p class="error" style="color:red;"><c:out value="${error}" /></p>
		<form:form action="/login" method="post" modelAttribute="newLogin" >
		<div>
			<form:label path="email">Email:</form:label>
			<form:input type='text' path='email'/>
			<form:errors path="email" class="text-danger" />
		</div>
		<div>
			<form:label path="password">Password: </form:label>
			<form:input type='password' path='password'/>
			<form:errors path="password" class="text-danger" />
		</div>
		<div>
			<input type='submit' value='Submit' class="button">
		</div>
	</form:form>

</body>
</html>