package com.robertbest.bookclub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.robertbest.bookclub.models.Book;
import com.robertbest.bookclub.models.LoginUser;
import com.robertbest.bookclub.models.User;
import com.robertbest.bookclub.services.BookService;
import com.robertbest.bookclub.services.UserService;

@Controller
public class MainController {
	@Autowired
    private UserService userServ;
	
	@Autowired
	private BookService bookService;
    
	
	//Login & Reg
    @GetMapping("/")
    public String index(Model model) {

        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "index.jsp";
    }
    
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, 
            BindingResult result, Model model, HttpSession session) {

    	userServ.register(newUser, result);
        
        if(result.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "index.jsp";
        }

        session.setAttribute("userId", newUser.getId());
    
        return "redirect:/dashboard";
    }
    
    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
    		BindingResult result, Model model, HttpSession session) {
        
    	User user = userServ.login(newLogin, result);
    	
        if(result.hasErrors()) {
        	model.addAttribute("newUser", new User());
            return "index.jsp";
        }
    
        session.setAttribute("userId", user.getId());
    
        return "redirect:/dashboard";
    }
    
    
    //Books Home
    
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
    	Long userId = (Long) session.getAttribute("userId");
    	if(userId==null) {
    		return "redirect:/";
    	}
    	User user = userServ.findId(userId);
    	model.addAttribute("user", user);
    	List<Book> books = bookService.allBooks();
    	model.addAttribute("books", books);
    	return "dashboard.jsp";
    }
    
    //Create Book
	@GetMapping("/book/new")
	public String newBook(@ModelAttribute("book") Book book, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
    	if(userId==null) {
    		return "redirect:/";
    	}
    	User user = userServ.findId(userId);
    	model.addAttribute("user", user);
		return "new.jsp";
	}
    
	@PostMapping("/create")
	public String create(@Valid @ModelAttribute("book") Book book, BindingResult result) {
		if (result.hasErrors()) {
			return "new.jsp";
		}
		System.out.println(book);
		bookService.createBook(book);
		return "redirect:/dashboard";
	}
    
	//View Book
	@GetMapping("/book/{bookId}")
	public String index(Model model, @PathVariable("bookId") Long bookId, HttpSession session) {

		Long userId = (Long) session.getAttribute("userId");
    	if(userId==null) {
    		return "redirect:/";
    	}

		Book book = bookService.findBook(bookId);
		model.addAttribute("book", book);

		return "view.jsp";
	}
	
	
	
	//Delete
	/*
	 * @DeleteMapping("/delete/{id}") public String destroy(@PathVariable("id") Long
	 * id, HttpSession session) { Long userId = (Long)
	 * session.getAttribute("userId"); if(userId==null) { return "redirect:/"; }
	 * bookService.deleteBook(id); return "redirect:/dashboard"; }
	 */
	
    @GetMapping("/delete/{id}") 
    public String destroy(@PathVariable("id") Long id, HttpSession session) {
    Long userId = (Long) session.getAttribute("userId");
      if(userId==null) {
          return "redirect:/";
      }  
    Book book = bookService.findBook(id);
    bookService.deleteBook(book); 
    return "redirect:/dashboard"; 
      }
    
	//Edit
	@RequestMapping("/book/{id}/edit")
	public String edit(@PathVariable("id") Long id, Model model) {
		Book book = bookService.findBook(id);
		model.addAttribute("book", book);
		return "/edit.jsp";
	}

	@RequestMapping(value = "/editBook/{id}", method = RequestMethod.PUT)
	public String update(@Valid @ModelAttribute("book") Book book, BindingResult result) {
		if (result.hasErrors()) {
			return "/books/edit.jsp";
		} else {
			bookService.updateBook(book);
			return "redirect:/dashboard";
		}
	}
	
	//Borrow/Return
    @GetMapping("/book/{id}/borrow") 
    public String borrowBook(@PathVariable("id") Long id, HttpSession session) {
    Long userId = (Long) session.getAttribute("userId");
      if(userId==null) {
          return "redirect:/";
      }  
    Book book = bookService.findBook(id);
    
    book.setBorrower(userServ.findId((Long)session.getAttribute("userId")));
    bookService.updateBook(book);
    return "redirect:/dashboard"; 
      }
    
    @GetMapping("/book/{id}/return") 
    public String returnBook(@PathVariable("id") Long id, HttpSession session) {
    Long userId = (Long) session.getAttribute("userId");
      if(userId==null) {
          return "redirect:/";
      }  
    Book book = bookService.findBook(id);
    
    book.setBorrower(null);
    bookService.updateBook(book);
    return "redirect:/dashboard"; 
      }
	
    //Logout 
    @RequestMapping("/clear")
    public String clear(HttpSession session) {
    	session.invalidate();
    	return "redirect:/";
    	
    }
}
