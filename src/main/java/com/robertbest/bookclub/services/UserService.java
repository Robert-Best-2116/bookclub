package com.robertbest.bookclub.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.robertbest.bookclub.models.LoginUser;
import com.robertbest.bookclub.models.User;
import com.robertbest.bookclub.repositories.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	public User createUser(User user) {
		return userRepository.save(user);
	}
	

    public User register(User newUser, BindingResult result) {
 
    	Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
    	if(potentialUser.isPresent()) {
    		System.out.println("email taken");
    		result.rejectValue("email", "Taken","Email is already in use.");
    		
    	}
    	if(!newUser.getPassword().equals(newUser.getConfirm())) {
    		System.out.println("passwords dont match");
    	    result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
    	}
    	
    	if(result.hasErrors()) {
    		System.out.println("errors");
    		return null;
    	}
    	String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
    	newUser.setPassword(hashed);
    	
    	return userRepository.save(newUser);
        
    }
    
    
    
    
    public User login(LoginUser newLogin, BindingResult result) {

        Optional<User> potentialUser = userRepository.findByEmail(newLogin.getEmail());
    	if(!potentialUser.isPresent()) {
    		System.out.println("email not in use");
    		result.rejectValue("email", "Empty","Email is not registered.");
    		return null;
    		
    	}
    	
		if(!BCrypt.checkpw(newLogin.getPassword(), potentialUser.get().getPassword())) {
			System.out.println("passwords dont match-login");
			result.rejectValue("password", "Matches", "Invalid Password!");
		}
		if(result.hasErrors()) {
			System.out.println("login errors");
			return null;
		}
		User user = potentialUser.get();
		return user;
    }
    
    public User findId(Long id) {
    	Optional<User> optionalUser = userRepository.findById(id);
    		if(optionalUser.isPresent()) {
    			return optionalUser.get();
    		}
    		return null;
    	}
    
    
	
}
