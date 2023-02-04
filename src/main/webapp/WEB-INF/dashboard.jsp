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
<title>Home</title>
</head>
<body>
<c:set var="userId" value='<%= session.getAttribute("userId") %>'/>
<nav>
<h1>Welcome <c:out value="${user.userName}"/> <a href="/clear">Logout</a></h1>

</nav>
<nav><h3>Books From Everyone's Shelves <a href="/book/new">+ Add A Book To The Shelf!</a></h3></nav>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Posted By</th>
            <th>Actions</th>
        </tr>
    </thead>
<c:out value="${book.borrower.id}"></c:out>
    <tbody>
    <c:forEach var="oneBook" items="${books}">
    	<c:if test="${userId != oneBook.borrower.id}">    	
    		<tr>
    			<td><c:out value = "${oneBook.id}"/></td>
    			<td><a href="/book/${oneBook.id}" ><c:out value = "${oneBook.title}"/></a></td>
    			<td><c:out value = "${oneBook.author}"/></td>
    			<td><c:out value = "${oneBook.user.userName}"/></td>
    			<c:if test="${userId == oneBook.user.id}">
					<td>
						<a href="/book/${book.id}/edit"><button>Edit</button></a>
						<a href="/delete/${book.id}"><button>Delete</button></a>
					</td>
				</c:if>
				<c:if test="${userId!= oneBook.user.id}">
					<td>
						<a href="/book/${oneBook.id}/borrow"><button>borrow</button></a>
					</td>
				</c:if>
    		</tr>
    	</c:if>
    </c:forEach>
	    </tbody>
</table>

<h3>Borrowed Books </h3>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Posted By</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="oneBook" items="${books}">
    	<c:if test="${userId == oneBook.borrower.id}">
    		<tr>
    			<td><c:out value = "${oneBook.id}"/></td>
    			<td><a href="/book/${oneBook.id}" ><c:out value = "${oneBook.title}"/></a></td>
    			<td><c:out value = "${oneBook.author}"/></td>
    			<td><c:out value = "${oneBook.user.userName}"/></td>
    			<c:if test="${userId != oneBook.user.id}">
					<td>
						<a href="/book/${oneBook.id}/return"><button>return</button></a>
					</td>
				</c:if>
    		</tr>    	
    	</c:if>
    </c:forEach>
	    </tbody>
</table>

</body>
</html>