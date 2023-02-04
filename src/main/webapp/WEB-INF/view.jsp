<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value = "${book.title}"/></title>
</head>
<body>
<nav> 
<h1><c:out value = "${book.title}"/></h1>
<a href="/dashboard">Home</a>

</nav>
<div>
<h3> <c:out value = "${book.user.userName}"/> read <c:out value = "${book.title}"/> by <c:out value = "${book.author}"/></h3>

</div>
<div>
<h4>Here are <c:out value = "${book.user.userName}"/> thoughts</h4>
<p><c:out value = "${book.thoughts}"/></p>
</div>

<div>
<c:set var="userID" value='<%= session.getAttribute("userId") %>'/>
		<c:if test="${userID == book.user.id}">
			<div class="d-flex justify-content-end">
				<a class="btn btn-primary me-2" href="/book/${book.id}/edit"><button>Edit</button></a>
				<a class="btn btn-primary me-2" href="/delete/${book.id}"><button>Delete</button></a>
			</div>
		</c:if>

</div>




</body>
</html>